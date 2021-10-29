########################################################################
# CMake module for finding CSVParser
#
# The following variables will be defined:
#
#  CSVParser_FOUND
#  CSVParser_INCLUDE_DIR
#  CSVParser_LIBRARY
#

find_path(CSVParser_INCLUDE_DIR
  NAMES csv.hpp
  PATHS ${PROJECT_SOURCE_DIR}/thirdparty/csv_parser/include
  NO_DEFAULT_PATH)
find_library(CSVParser_LIBRARY_RELEASE
  NAMES csv
  PATHS ${PROJECT_SOURCE_DIR}/thirdparty/csv_parser/lib
  NO_DEFAULT_PATH)
find_library(CSVParser_LIBRARY_DEBUG
  NAMES csv_d
  PATHS ${PROJECT_SOURCE_DIR}/thirdparty/csv_parser/lib
  NO_DEFAULT_PATH)

set(CSVParser_LIBRARY optimized ${CSVParser_LIBRARY_RELEASE} debug ${CSVParser_LIBRARY_DEBUG})

include(FindPackageHandleStandardArgs)
#find_package_handle_standard_args(CSVParser DEFAULT_MSG CSVParser_LIBRARY CSVParser_LIBRARY_DEBUG CSVParser_INCLUDE_DIR)
find_package_handle_standard_args(CSVParser DEFAULT_MSG CSVParser_LIBRARY CSVParser_INCLUDE_DIR)
