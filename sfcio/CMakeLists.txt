#------------------------------------------------------------------------------
#
project(sfcio)

#------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8)

#------------------------------------------------------------------------------
# Enable Fortran
enable_language(Fortran)

#------------------------------------------------------------------------------
# Set a default build type if none was specified
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to 'Release' as none was specified.")
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)

    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
                 "MinSizeRel" "RelWithDebInfo")
endif()

#------------------------------------------------------------------------------
# Set the CMake module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

#------------------------------------------------------------------------------
# Set the sources
set(SOURCES
    sfcio_module.f90
)

#------------------------------------------------------------------------------
# Create a libraray
add_library(sfcio ${SOURCES})
target_link_libraries(sfcio LINK_PUBLIC)

#------------------------------------------------------------------------------
# Installation
install(TARGETS sfcio
	EXPORT sfcio-targets
	ARCHIVE DESTINATION "lib")
install(FILES ${PROJECT_BINARY_DIR}/sfcio_module.mod
        DESTINATION "include/sfcio")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT sfcio-targets
	DESTINATION "lib/cmake")
install(FILES sfcio-config.cmake
	DESTINATION "lib/cmake")


