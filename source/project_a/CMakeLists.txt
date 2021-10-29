# 
# External dependencies
# 
find_package(Qt5 COMPONENTS Widgets Network Core PrintSupport)

#
# Executable name and options
#
set(target project_a)

set(META_NAME ${target})
set(META_VERSION_REVISION ${GIT_COMMIT_VER_})
configure_file(${PROJECT_BINARY_DIR}/version.rc ${CMAKE_CURRENT_BINARY_DIR}/version.rc)
set(RES_FILES  ${CMAKE_CURRENT_BINARY_DIR}/version.rc)
set(CMAKE_RC_COMPILER_INIT windres)
ENABLE_LANGUAGE(RC)
SET(CMAKE_RC_COMPILE_OBJECT 
"<CMAKE_RC_COMPILER> <FLAGS> -O coff <DEFINES> -i <SOURCE> -o <OBJECT>")


# Tell CMake to run moc when necessary:
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 17)

# As moc files are generated in the binary dir, tell CMake
# to always look for includes there:
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_definitions(-DUNICODE -D_UNICODE -DQUALISYS_TEST)

# Exit here if required dependencies are not met
message(STATUS "server app: ${target}")

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
)

# Group source files
set(header_group "Header Files (API)")
set(source_group "Source Files")
source_group_by_path(${include_path} "\\\\.h$|\\\\.hpp$" 
    ${header_group} ${headers})
source_group_by_path(${source_path}  "\\\\.cpp$|\\\\.c$|\\\\.h$|\\\\.hpp$" 
    ${source_group} ${sources})

#
# Create executable
#

# Build executable
add_executable(${target} ${sources} ${headers} ${RES_FILES})

# Create namespaced alias
add_executable(${META_PROJECT_NAME}::${target} ALIAS ${target})

# 
# Project options
# 

set_target_properties(${target}
    PROPERTIES
        ${DEFAULT_PROJECT_OPTIONS}
        FOLDER "${IDE_FOLDER}"
)


# 
# Include directories
# 

target_include_directories(${target}
    PRIVATE
        ${DEFAULT_INCLUDE_DIRECTORIES}
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_BINARY_DIR}/include
        ${PROJECT_BINARY_DIR}/source/include
		${PROJECT_SOURCE_DIR}/thirdparty
		${PROJECT_SOURCE_DIR}/source
   )

# 
# Libraries
# 

target_link_libraries(${target}
    PRIVATE
        Iphlpapi
		ws2_32
        ${DEFAULT_LIBRARIES}
        ${Qt5Widgets_LIBRARIES}
		${Qt5Network_LIBRARIES}
        ${Qt5PrintSupport_LIBRARIES}
		${META_PROJECT_NAME}::lib_a
    )

# 
# Compile definitions
# 

target_compile_definitions(${target}
    PRIVATE
        ${DEFAULT_COMPILE_DEFINITIONS}
)


# 
# Compile options
# 

target_compile_options(${target}
    PRIVATE
        ${DEFAULT_COMPILE_OPTIONS}
)


# 
# Linker options
# 

target_link_libraries(${target}
    PRIVATE
        ${DEFAULT_LINKER_OPTIONS}
)


# 
# Deployment
# 

# Executable
install(TARGETS ${target}
    RUNTIME DESTINATION ${INSTALL_BIN} COMPONENT runtime
    BUNDLE  DESTINATION ${INSTALL_BIN} COMPONENT runtime
)
# Install QT language files
file(GLOB QM ${CMAKE_CURRENT_BINARY_DIR}/*.qm)
install(FILES ${QM} DESTINATION ${INSTALL_BIN}/langs COMPONENT runtime)
