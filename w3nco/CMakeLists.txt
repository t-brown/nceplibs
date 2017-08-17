#------------------------------------------------------------------------------
#
project(w3nco)
set(VERSION 2.0.6)

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
# Find dependencies
if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    find_package(sigio REQUIRED)
else()
    include_directories(${CMAKE_CURRENT_BINARY_DIR}/../sigio)
    link_directories(${CMAKE_CURRENT_BINARY_DIR}/../sigio)
    set(SIGIO_LIBRARIES sigio)
endif()

#------------------------------------------------------------------------------
# Set the sources
set(SOURCES
    aea.f       getgb.f       putgbex.f   w3doxdat.f  w3fs13.f
    errexit.f   getgbh.f      putgb.f     w3fi01.f    w3fs15.f
    errmsg.f    getgbm.f      putgbn.f    w3fi04.f    w3fs21.f
    fparsei.f   getgbmh.f     q9ie32.f    w3fi58.f    w3fs26.f
    fparser.f   getgbmp.f     r63w72.f    w3fi59.f    w3ft32.f
    gbytec.f    getgbp.f      sbytec.f    w3fi62.f    w3kind.f
    gbyte.f     getgi.f       sbyte.f     w3fi63.f    w3locdat.f
    gbytesc.f   getgir.f      sbytesc.f   w3fi64.f    w3movdat.f
    gbytes.f    gtbits.f      sbytes.f    w3fi68.f    w3nogds.f
    getbit.f    idsdef.f      skgb.f      w3fi69.f    w3pradat.f
    getgb1.f    instrument.f  summary.c   w3fi71.f    w3reddat.f
    getgb1re.f  iw3jdn.f      w3ai00.f    w3fi72.f    w3tagb.f
    getgb1r.f   iw3pds.f      w3ai01.f    w3fi73.f    w3trnarg.f
    getgb1s.f   iw3unp29.f    w3ai08.f    w3fi74.f    w3unpk77.f
    getgbe.f    ixgb.f        w3ai15.f    w3fi75.f    w3utcdat.f
    getgbeh.f   lengds.f      w3ai18.f    w3fi76.f    w3valdat.f
    getgbem.f   makwmo.f      w3ai19.f    w3fi82.f    w3ymdh4.f
    getgbemh.f  mkfldsep.f    w3ai24.f    w3fi83.f    xmovex.f
    getgbemn.f  mova2i.c      w3ai38.f    w3fi88.f    xstore.f
    getgbemp.f  pdsens.f      w3ai39.f    w3fi92.f
    getgbep.f   pdseup.f      w3aq15.f    w3fp11.f
    getgbex.f   putgbe.f      w3as00.f    w3fp12.f
    getgbexm.f  putgben.f     w3difdat.f  w3fp13.f
)

#------------------------------------------------------------------------------
# Create a libraray
add_library(w3nco ${SOURCES})
target_link_libraries(w3nco LINK_PUBLIC)

#------------------------------------------------------------------------------
# Add needed C flags
string(TOUPPER ${CMAKE_SYSTEM_NAME} UPPER_SYSTEM_NAME)
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-D${UPPER_SYSTEM_NAME}")

#------------------------------------------------------------------------------
# Installation
install(TARGETS w3nco EXPORT w3nco-targets
	ARCHIVE DESTINATION "lib")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT w3nco-targets
	DESTINATION "lib/cmake")
install(FILES w3nco-config.cmake
	DESTINATION "lib/cmake")

