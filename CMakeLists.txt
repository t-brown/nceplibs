#------------------------------------------------------------------------------
#
project(nceplibs)
set(VERSION 1.0.0)

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
# Add all the sub-directories

add_subdirectory(bacio)
add_subdirectory(bufr)
add_subdirectory(crtm)
#add_subdirectory(ip)
add_subdirectory(nemsio)
add_subdirectory(sfcio)
add_subdirectory(sigio)
add_subdirectory(sp)
add_subdirectory(w3)
add_subdirectory(w3emc)
add_subdirectory(w3nco)
