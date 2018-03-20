#------------------------------------------------------------------------------
#
project(w3emc)
set(VERSION 2.0.5)

#------------------------------------------------------------------------------
cmake_minimum_required(VERSION 2.8)
cmake_policy(SET CMP0015 NEW)

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
# Find dependencies
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    find_package(sigio REQUIRED)
else()
    include_directories(${CMAKE_CURRENT_BINARY_DIR}/../sigio)
    link_directories(${CMAKE_CURRENT_BINARY_DIR}/../sigio)
    set(SIGIO_LIBRARIES sigio)
endif()

#------------------------------------------------------------------------------
# Set the sources
set(SOURCES
    args_mod.f          w3fb12.f   w3ft06.f
    gblevents.f         w3fc02.f   w3ft06v.f
    getgbens.f          w3fc05.f   w3ft07.f
    isrchne.f           w3fc06.f   w3ft08.f
    iw3mat.f            w3fc07.f   w3ft09.f
    mersenne_twister.f  w3fc08.f   w3ft10.f
    mova2i.f            w3fi02.f   w3ft11.f
    orders.f            w3fi03.f   w3ft12.f
    putgbens.f          w3fi18.f   w3ft16.f
    start.f             w3fi19.f   w3ft17.f
    summary.f           w3fi20.f   w3ft201.f
    w3ai40.f            w3fi32.f   w3ft202.f
    w3ai41.f            w3fi47.f   w3ft203.f
    w3ctzdat.f          w3fi48.f   w3ft204.f
    w3fa01.f            w3fi52.f   w3ft205.f
    w3fa03.f            w3fi61.f   w3ft206.f
    w3fa03v.f           w3fi65.f   w3ft207.f
    w3fa04.f            w3fi66.f   w3ft208.f
    w3fa06.f            w3fi67.f   w3ft209.f
    w3fa09.f            w3fi70.f   w3ft210.f
    w3fa11.f            w3fi78.f   w3ft211.f
    w3fa12.f            w3fi85.f   w3ft212.f
    w3fa13.f            w3fm07.f   w3ft213.f
    w3fb00.f            w3fm08.f   w3ft214.f
    w3fb01.f            w3fp04.f   w3ft21.f
    w3fb02.f            w3fp05.f   w3ft26.f
    w3fb03.f            w3fp06.f   w3ft33.f
    w3fb04.f            w3fp10.f   w3ft38.f
    w3fb05.f            w3fq07.f   w3ft39.f
    w3fb06.f            w3ft00.f   w3ft40.f
    w3fb07.f            w3ft01.f   w3ft41.f
    w3fb08.f            w3ft02.f   w3ft43v.f
    w3fb09.f            w3ft03.f   w3log.f
    w3fb10.f            w3ft05.f   w3miscan.f
    w3fb11.f            w3ft05v.f  xdopen.f
)

set_source_files_properties(mersenne_twister.f PROPERTIES COMPILE_FLAGS -fno-range-check)
set_source_files_properties(w3fi32.f PROPERTIES COMPILE_FLAGS -fno-range-check)
set_source_files_properties(w3fi85.f PROPERTIES COMPILE_FLAGS -fno-range-check)
set_source_files_properties(w3fp05.f PROPERTIES COMPILE_FLAGS -fno-range-check)
set_source_files_properties(w3fp06.f PROPERTIES COMPILE_FLAGS -fno-range-check)
set_source_files_properties(w3fp10.f PROPERTIES COMPILE_FLAGS -fno-range-check)

#------------------------------------------------------------------------------
# Create a libraray
add_library(w3emc ${SOURCES})
target_link_libraries(w3emc LINK_PUBLIC ${SIGIO_LIBRARIES})

#------------------------------------------------------------------------------
# Add needed C flags
string(TOUPPER ${CMAKE_SYSTEM_NAME} UPPER_SYSTEM_NAME)
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-D${UPPER_SYSTEM_NAME}")

#------------------------------------------------------------------------------
# Installation
install(TARGETS w3emc EXPORT w3emc-targets
	ARCHIVE DESTINATION "lib")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT w3emc-targets
	DESTINATION "lib/cmake")
install(FILES w3emc-config.cmake
	DESTINATION "lib/cmake")

