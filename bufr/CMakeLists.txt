#------------------------------------------------------------------------------
#
project(bufr)

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
# Set the Fortran flags needed for this library
include(compiler_flags)
compiler_flags()

#------------------------------------------------------------------------------
# Look for packages


#------------------------------------------------------------------------------
# Set the sources
set(SOURCES
    adn30.f      getntbe.f   lmsg.f      posapx.f    ufbcnt.f
    atrcpt.f     gets1loc.f  lstjpb.f    rbytes.c    ufbcpy.f
    bfrini.f     gettagpr.f  Makefile    rcstpl.f    ufbcup.f
    blocks.f     gettbh.f    makestab.f  rdbfdx.f    ufbdmp.f
    bort2.f      getvalnb.f  maxout.f    rdcmps.f    ufbevn.f
    bort_exit.c  getwin.f    mesgbc.f    rdmemm.f    ufbget.f
    bort.f       i4dy.f      mesgbf.f    rdmems.f    ufbin3.f
    bufrlib.h    ibfms.f     minimg.f    rdmgsb.f    ufbint.f
    bvers.f      icbfms.f    mrginv.f    rdmsgb.f    ufbinx.f
    cadn30.f     ichkstr.f   msgfull.f   rdmsgw.f    ufbmem.f
    capit.f      icmpdx.f    msgini.f    rdmtbb.f    ufbmex.f
    ccbfl.c      icopysb.f   msgupd.f    rdmtbd.f    ufbmms.f
    chekstab.f   icvidx.c    msgwrt.f    rdtree.f    ufbmns.f
    chrtrna.f    idn30.f     mtinfo.f    rdusdx.f    ufbovr.f
    chrtrn.f     idxmsg.f    mvb.f       readdx.f    ufbpos.f
    cktaba.f     ifbget.f    nemock.f    readerme.f  ufbqcd.f
    closbf.f     ifxy.f      nemtab.f    readlc.f    ufbqcp.f
    closmg.f     igetdate.f  nemtba.f    readmg.f    ufbrep.f
    cmpia.c      igetfxy.f   nemtbax.f   readmm.f    ufbrms.f
    cmpmsg.f     igetntbi.f  nemtbb.f    readmt.f    ufbrp.f
    cmsgini.f    igetntbl.f  nemtbd.f    readns.f    ufbrw.f
    cnved4.f     igetsc.f    nenubd.f    reads3.f    ufbseq.f
    cobfl.c      igettdi.f   nevn.f      readsb.f    ufbsp.f
    conwin.f     inctab.f    newwin.f    restd.c     ufbstp.f
    copybf.f     invcon.f    nmsub.f     rewnbf.f    ufbtab.f
    copymg.f     invmrg.f    nmwrd.f     rjust.f     ufbtam.f
    copysb.f     invtag.f    numbck.f    rsvfvm.f    ufdump.f
    cpbfdx.f     invwin.f    nummtb.c    rtrcpt.f    upbb.f
    cpdxmm.f     iok2cpy.f   numtab.f    seqsdx.f    upb.f
    cpymem.f     ipkm.f      numtbd.f    setblock.f  upc.f
    cpyupd.f     ipks.f      nvnwin.f    setbmiss.f  upds3.f
    crbmg.c      ireadmg.f   nwords.f    sntbbe.f    upftbv.f
    cread.c      ireadmm.f   nxtwin.f    sntbde.f    ups.f
    cwbmg.c      ireadns.f   openbf.f    status.f    uptdd.f
    datebf.f     ireadsb.f   openbt.f    stbfdx.f    usrtpl.f
    datelen.f    irev.F      openmb.f    stdmsg.f    valx.f
    digit.f      irev.s      openmg.f    stndrd.f    wrcmps.f
    drfini.f     ishrdx.f    pad.f       stntbia.f   wrdesc.c
    drstpl.f     isize.f     padmsg.f    stntbi.f    wrdlen.F
    dumpbf.f     istdesc.f   parstr.f    strcln.f    wrdlen.s
    dxdump.f     iupb.f      parusr.f    strcpt.f    wrdxtb.f
    dxinit.f     iupbs01.f   parutg.f    string.f    writcp.f
    dxmini.f     iupbs3.f    pkb.f       strnum.f    writdx.f
    elemdx.f     iupm.f      pkbs1.f     strsuc.f    writlc.f
    errwrt.f     iupvs01.f   pkc.f       stseq.c     writsa.f
    getabdb.f    jstchr.f    pkftbv.f    tabent.f    writsb.f
    getbmiss.f   jstnum.f    pktdd.f     tabsub.f    wrtree.f
    getlens.f    lcmgdf.f    pkvs01.f    trybump.f   wtstat.f
)

#------------------------------------------------------------------------------
# Use the pre-processor to generate the bufrlib parameter file
add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/bufrlib.prm
	COMMAND ${CMAKE_Fortran_COMPILER} -o ${CMAKE_CURRENT_BINARY_DIR}/bufrlib.prm -E ${CMAKE_CURRENT_SOURCE_DIR}/bufrlib.F
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/bufrlib.F
)
list(APPEND SOURCES ${CMAKE_CURRENT_BINARY_DIR}/bufrlib.prm)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

#------------------------------------------------------------------------------
# Create a libraray
add_library(bufr ${SOURCES})
target_link_libraries(bufr LINK_PUBLIC)

#------------------------------------------------------------------------------
# Installation
install(TARGETS bufr
	EXPORT bufr-targets
	ARCHIVE DESTINATION "lib")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT bufr-targets
	DESTINATION "lib/cmake")
install(FILES bufr-config.cmake
	DESTINATION "lib/cmake")


