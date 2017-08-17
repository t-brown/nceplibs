#------------------------------------------------------------------------------
#
project(sp)
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
# Set the sources
set(SOURCES
    bll2ps.f      spgradx.f   sptezv.f    sptrand.f   sptrunm.f
    fftpack.F     spgrady.f   sptgpmd.f   sptran.f    sptrunmv.f
    lapack_gen.F  splaplac.f  sptgpm.f    sptranf0.f  sptruns.f
    ncpus.F       splat.F     sptgpmv.f   sptranf1.f  sptrunsv.f
    spanaly.f     splegend.f  sptgpsd.f   sptranf.f   sptrunv.f
    spdz2uv.f     sppad.f     sptgps.f    sptranfv.f  spuv2dz.f
    speps.f       spsynth.f   sptgpsv.f   sptranv.f   spvar.f
    spfft1.f      sptezd.f    sptgptd.f   sptrund.f   spwget.f
    spffte.f      sptez.f     sptgpt.f    sptrun.f
    spfft.f       sptezmd.f   sptgptsd.f  sptrung.f
    spfftpt.f     sptezm.f    sptgptvd.f  sptrungv.f
    spgradq.f     sptezmv.f   sptgptv.f   sptrunl.f
)

#------------------------------------------------------------------------------
# Create a libraray
add_library(sp ${SOURCES})
target_link_libraries(sp LINK_PUBLIC)

#------------------------------------------------------------------------------
# Add needed C flags
string(TOUPPER ${CMAKE_SYSTEM_NAME} UPPER_SYSTEM_NAME)
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-D${UPPER_SYSTEM_NAME}")

#------------------------------------------------------------------------------
# Installation
install(TARGETS sp EXPORT sp-targets
	ARCHIVE DESTINATION "lib")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT sp-targets
	DESTINATION "lib/cmake")
install(FILES sp-config.cmake
	DESTINATION "lib/cmake")

