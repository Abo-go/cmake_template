# 
# External dependencies
# 
find_package(CSVParser REQUIRED)
find_package(OpencvWorld REQUIRED)
# 
# Library name and options
# 

# Target name
set(target lib_a)
set(META_NAME ${target})
configure_file(${PROJECT_BINARY_DIR}/version.rc ${CMAKE_CURRENT_BINARY_DIR}/version.rc)
set(RES_FILES  ${CMAKE_CURRENT_BINARY_DIR}/version.rc)
set(CMAKE_RC_COMPILER_INIT windres)
ENABLE_LANGUAGE(RC)
SET(CMAKE_RC_COMPILE_OBJECT 
"<CMAKE_RC_COMPILER> <FLAGS> -O coff <DEFINES> -i <SOURCE> -o <OBJECT>")

# Exit here if required dependencies are not met
message(STATUS "Lib ${target}")

# Set API export file and macro
string(TOUPPER ${target} target_upper)
set(feature_file "include/${target}_features.h")
set(export_file  "include/${target}_api.h")
set(export_macro "${target_upper}_API")
set(CMAKE_CXX_STANDARD 17)

# 
# Sources
# 
set(include_path "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(source_path "${CMAKE_CURRENT_SOURCE_DIR}/source")

file(GLOB headers
    "${include_path}/*.h" 
    "${include_path}/*.hpp"

)
file(GLOB sources
    "${source_path}/*.cpp"
    ${CMAKE_CURRENT_BINARY_DIR}/version.rc
)

# Group source files
set(header_group "Header Files (API)")
set(source_group "Source Files")
source_group_by_path(${include_path} "\\\\.h$|\\\\.hpp$" 
    ${header_group} ${headers})
source_group_by_path(${source_path}  "\\\\.cpp$|\\\\.c$|\\\\.h$|\\\\.hpp$" 
    ${source_group} ${sources})


# 
# Create library
# 

# Build library
add_library(${target}
    ${sources}
    ${headers}
)

# Create namespaced alias
add_library(${META_PROJECT_NAME}::${target} ALIAS ${target})

# Export library for downstream projects
export(TARGETS ${target} NAMESPACE ${META_PROJECT_NAME}:: FILE ${PROJECT_BINARY_DIR}/cmake/${target}/${target}-export.cmake)

# Create feature detection header
# Compilers: https://cmake.org/cmake/help/v3.1/variable/CMAKE_LANG_COMPILER_ID.html#variable:CMAKE_%3CLANG%3E_COMPILER_ID
# Feature: https://cmake.org/cmake/help/v3.1/prop_gbl/CMAKE_CXX_KNOWN_FEATURES.html

# Check for availability of module; use pre-generated version if not found
if (WriterCompilerDetectionHeaderFound)
    write_compiler_detection_header(
        FILE ${feature_file}
        PREFIX ${target_upper}
        COMPILERS AppleClang Clang GNU MSVC
        FEATURES cxx_alignas cxx_alignof cxx_constexpr cxx_final cxx_noexcept cxx_nullptr cxx_sizeof_member cxx_thread_local
        VERSION 3.2
    )
else()
    file(
        COPY ${PROJECT_SOURCE_DIR}/codegeneration/${target}_features.h
        DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/include/${target}
        USE_SOURCE_PERMISSIONS
    )
endif()

# Create API export header
generate_export_header(${target}
    EXPORT_FILE_NAME  ${export_file}
    EXPORT_MACRO_NAME ${export_macro}
)

# 
# Project options
# 

set_target_properties(${target}
    PROPERTIES
        ${DEFAULT_PROJECT_OPTIONS}
    FOLDER "${IDE_FOLDER}"
)

# customed export macro

# 
# Include directories
# 
target_include_directories(${target}
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_BINARY_DIR}/include
        ${PROJECT_BINARY_DIR}/source/include
		${PROJECT_SOURCE_DIR}/source
        ${PROJECT_SOURCE_DIR}/thirdparty
		${CSVParser_INCLUDE_DIR}
		${OPENCVWORLD_INCLUDE_DIR}
    PUBLIC
        ${DEFAULT_INCLUDE_DIRECTORIES}

    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:include>
        
)

# 
# Libraries
# 

target_link_libraries(${target}
    PRIVATE
		${CSVParser_LIBRARY}
		${OPENCVWORLD_LIBRARY}
        ${DEFAULT_LIBRARIES}
    PUBLIC
        ${DEFAULT_LIBRARIES}

    INTERFACE
)

# 
# Compile definitions
# 

target_compile_definitions(${target}
    PRIVATE

    PUBLIC
        $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:${target_upper}_STATIC_DEFINE>
        ${DEFAULT_COMPILE_DEFINITIONS}

    INTERFACE
)


# 
# Compile options
# 

target_compile_options(${target}
    PRIVATE

    PUBLIC
        ${DEFAULT_COMPILE_OPTIONS}

    INTERFACE
)


# 
# Linker options
# 

target_link_libraries(${target}
    PRIVATE

    PUBLIC
        ${DEFAULT_LINKER_OPTIONS}

    INTERFACE
)
