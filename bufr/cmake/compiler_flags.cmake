# =========================================================================
# COMPILER FLAGS
# =========================================================================

macro(compiler_flags)

  if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(CMAKE_Fortran_FLAGS         "${CMAKE_Fortran_FLAGS} -fdefault-real-8 -fdefault-double-8 -fbackslash -ffree-line-length-0")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -finline-functions -fstack-arrays")
    set(CMAKE_Fortran_FLAGS_PROFILE "-pg -O3 -finline-functions -fstack-arrays")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-g -O0 -ffpe-trap=invalid -fbounds-check -finit-real=snan -fbacktrace -Wall")
  elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(CMAKE_Fortran_FLAGS         "${CMAKE_Fortran_FLAGS} -i4 -r8 -traceback -fp-model precise")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
    set(CMAKE_Fortran_FLAGS_PROFILE "-p -O3 -qopt-report0 -qopt-report-phase=vec -no-prec-div")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-g -O0 -fpe0 -traceback -check all -init=snan -init=arrays")
  elseif(CMAKE_Fortran_COMPILER_ID MATCHES "PGI")
    set(CMAKE_Fortran_FLAGS         "${CMAKE_Fortran_FLAGS} -i4 -r8 -traceback")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O2 ")
    set(CMAKE_Fortran_FLAGS_PROFILE "-O2 -Mprof")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-g -O0 -Mbounds -Mchkfpstk -Mchkstk")
  else()
    message(ERROR "Unknown compiler")
  endif()

endmacro()
