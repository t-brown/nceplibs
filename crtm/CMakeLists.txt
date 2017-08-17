#------------------------------------------------------------------------------
#
project(crtm)
set(VERSION 2.1.3)

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
# Set the sources
set(SOURCES
        ACCoeff_Binary_IO.f90           Endian_Utility.f90
        ACCoeff_Define.f90              File_Utility.f90
        ADA_Module.f90                  FitCoeff_Define.f90
        AerosolCoeff_Binary_IO.f90      FitCoeff_Destroy.inc
        AerosolCoeff_Define.f90         FitCoeff_Equal.inc
        ASvar_Define.f90                FitCoeff_Info.inc
        Azimuth_Emissivity_Module.f90   FitCoeff_ReadFile.inc
        Binary_File_Utility.f90         FitCoeff_SetValue.inc
        CloudCoeff_Binary_IO.f90        FitCoeff_WriteFile.inc
        CloudCoeff_Define.f90           Foam_Utility_Module.f90
        Common_RTSolution.f90           Fresnel.f90
        Compare_Float_Numbers.f90       Fundamental_Constants.f90
        CRTM_Adjoint_Module.f90         Guillou.f90
        CRTM_AerosolCoeff.f90           Hyperbolic_Step.f90
        CRTM_Aerosol_Define.f90         iAtm_Define.f90
        CRTM_AerosolScatter.f90         IRwaterCoeff_Define.f90
        CRTM_AncillaryInput_Define.f90  Large_Scale_Correction_Module.f90
        CRTM_AntennaCorrection.f90      Liu.f90
        CRTM_AOD_Module.f90             LSEatlas_Define.f90
        CRTM_AtmAbsorption.f90          Message_Handler.f90
        CRTM_AtmOptics_Define.f90       MinMax_Find_Utility.f90
        CRTM_AtmOptics.f90              MWwaterCoeff_Define.f90
        CRTM_Atmosphere_Define.f90      MWwaterLUT_Define.f90
        CRTM_Atmosphere.f90             NESDIS_AMSRE_SICEEM_Module.f90
        CRTM_ChannelInfo_Define.f90     NESDIS_AMSRE_SNOWEM_Module.f90
        CRTM_CloudCoeff.f90             NESDIS_AMSU_SICEEM_Module.f90
        CRTM_Cloud_Define.f90           NESDIS_AMSU_SnowEM_Module.f90
        CRTM_CloudScatter.f90           NESDIS_LandEM_Module.f90
        CRTM_Fastem1.f90                NESDIS_MHS_SICEEM_Module.f90
        CRTM_FastemX.f90                NESDIS_MHS_SnowEM_Module.f90
        CRTM_Forward_Module.f90         NESDIS_SEAICE_PHYEM_MODULE.f90
        CRTM_Geometry_Define.f90        NESDIS_SnowEM_Parameters.f90
        CRTM_GeometryInfo_Define.f90    NESDIS_SSMI_Module.f90
        CRTM_GeometryInfo.f90           NESDIS_SSMI_SIceEM_Module.f90
        CRTM_Interpolation.f90          NESDIS_SSMI_SnowEM_Module.f90
        CRTM_IRiceCoeff.f90             NESDIS_SSMIS_SeaIceEM_Module.f90
        CRTM_IR_Ice_SfcOptics.f90       NESDIS_SSMIS_SnowEM_Module.f90
        CRTM_IRlandCoeff.f90            NLTECoeff_Binary_IO.f90
        CRTM_IR_Land_SfcOptics.f90      NLTECoeff_Define.f90
        CRTM_IRsnowCoeff.f90            NLTE_Parameters.f90
        CRTM_IR_Snow_SfcOptics.f90      NLTE_Predictor_Define.f90
        CRTM_IRSSEM.f90                 NLTE_Predictor_IO.f90
        CRTM_IRwaterCoeff.f90           ODAS_AtmAbsorption.f90
        CRTM_IR_Water_SfcOptics.f90     ODAS_Binary_IO.f90
        CRTM_K_Matrix_Module.f90        ODAS_Define.f90
        CRTM_Land_Parameters.f90        ODAS_Predictor_Define.f90
        CRTM_LifeCycle.f90              ODAS_Predictor.f90
        CRTM_LowFrequency_MWSSEM.f90    ODAS_TauCoeff.f90
        CRTM_Model_Profiles.f90         ODPS_AtmAbsorption.f90
        CRTM_Module.f90                 ODPS_Binary_IO.f90
        CRTM_MoleculeScatter.f90        ODPS_CoordinateMapping.f90
        CRTM_MW_Ice_SfcOptics.f90       ODPS_Define.f90
        CRTM_MW_Land_SfcOptics.f90      ODPS_Predictor_Define.f90
        CRTM_MW_Snow_SfcOptics.f90      ODPS_Predictor.f90
        CRTM_MWwaterCoeff.f90           ODPS_TauCoeff.f90
        CRTM_MW_Water_SfcOptics.f90     ODSSU_AtmAbsorption.f90
        CRTM_NLTECorrection.f90         ODSSU_Binary_IO.f90
        CRTM_Options_Define.f90         ODSSU_Define.f90
        CRTM_Parameters.f90             ODSSU_TauCoeff.f90
        CRTM_Planck_Functions.f90       ODZeeman_AtmAbsorption.f90
        CRTM_Predictor_Define.f90       ODZeeman_Predictor.f90
        CRTM_Predictor.f90              ODZeeman_TauCoeff.f90
        CRTM_RTSolution_Define.f90      PAFV_Define.f90
        CRTM_RTSolution.f90             Profile_Utility_Parameters.f90
        CRTM_SEcategory.f90             Reflection_Correction_Module.f90
        CRTM_SensorData_Define.f90      RTV_Define.f90
        CRTM_SensorInfo.f90             Search_Utility.f90
        CRTM_SfcOptics_Define.f90       SEcategory_Define.f90
        CRTM_SfcOptics.f90              SensorInfo_Parameters.f90
        CRTM_SpcCoeff.f90               Slope_Variance.f90
        CRTM_Surface_Define.f90         Small_Scale_Correction_Module.f90
        CRTM_Tangent_Linear_Module.f90  SOI_Module.f90
        CRTM_TauCoeff.f90               Sort_Utility.f90
        CRTM_Utility.f90                SpcCoeff_Binary_IO.f90
        CRTM_VISiceCoeff.f90            SpcCoeff_Define.f90
        CRTM_VIS_Ice_SfcOptics.f90      Spectral_Units_Conversion.f90
        CRTM_VISlandCoeff.f90           SSU_Input_Define.f90
        CRTM_VIS_Land_SfcOptics.f90     String_Utility.f90
        CRTM_VISsnowCoeff.f90           Subset_Define.f90
        CRTM_VIS_Snow_SfcOptics.f90     TauCoeff_Define.f90
        CRTM_VISwaterCoeff.f90          Timing_Utility.f90
        CRTM_VIS_Water_SfcOptics.f90    Type_Kinds.f90
        CSvar_Define.f90                UnitTest_Define.f90
        Date_Utility.f90                Zeeman_Input_Define.f90
        Ellison.f90                     Zeeman_Utility.f90
        Emission_Module.f90
)

#------------------------------------------------------------------------------
# Create a libraray
add_library(crtm ${SOURCES})
target_link_libraries(crtm LINK_PUBLIC)

#------------------------------------------------------------------------------
# Add needed C flags
string(TOUPPER ${CMAKE_SYSTEM_NAME} UPPER_SYSTEM_NAME)
set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} "-D${UPPER_SYSTEM_NAME}")

#------------------------------------------------------------------------------
# Installation
install(TARGETS crtm EXPORT crtm-targets
        ARCHIVE DESTINATION "lib")
install(FILES
        ${PROJECT_BINARY_DIR}/accoeff_binary_io.mod
        ${PROJECT_BINARY_DIR}/accoeff_define.mod
        ${PROJECT_BINARY_DIR}/ada_module.mod
        ${PROJECT_BINARY_DIR}/aerosolcoeff_binary_io.mod
        ${PROJECT_BINARY_DIR}/aerosolcoeff_define.mod
        ${PROJECT_BINARY_DIR}/asvar_define.mod
        ${PROJECT_BINARY_DIR}/azimuth_emissivity_module.mod
        ${PROJECT_BINARY_DIR}/binary_file_utility.mod
        ${PROJECT_BINARY_DIR}/cloudcoeff_binary_io.mod
        ${PROJECT_BINARY_DIR}/cloudcoeff_define.mod
        ${PROJECT_BINARY_DIR}/common_rtsolution.mod
        ${PROJECT_BINARY_DIR}/compare_float_numbers.mod
        ${PROJECT_BINARY_DIR}/crtm_adjoint_module.mod
        ${PROJECT_BINARY_DIR}/crtm_aerosolcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_aerosol_define.mod
        ${PROJECT_BINARY_DIR}/crtm_aerosolscatter.mod
        ${PROJECT_BINARY_DIR}/crtm_ancillaryinput_define.mod
        ${PROJECT_BINARY_DIR}/crtm_antennacorrection.mod
        ${PROJECT_BINARY_DIR}/crtm_aod_module.mod
        ${PROJECT_BINARY_DIR}/crtm_atmabsorption.mod
        ${PROJECT_BINARY_DIR}/crtm_atmoptics_define.mod
        ${PROJECT_BINARY_DIR}/crtm_atmoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_atmosphere_define.mod
        ${PROJECT_BINARY_DIR}/crtm_atmosphere.mod
        ${PROJECT_BINARY_DIR}/crtm_channelinfo_define.mod
        ${PROJECT_BINARY_DIR}/crtm_cloudcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_cloud_define.mod
        ${PROJECT_BINARY_DIR}/crtm_cloudscatter.mod
        ${PROJECT_BINARY_DIR}/crtm_fastem1.mod
        ${PROJECT_BINARY_DIR}/crtm_fastemx.mod
        ${PROJECT_BINARY_DIR}/crtm_forward_module.mod
        ${PROJECT_BINARY_DIR}/crtm_geometry_define.mod
        ${PROJECT_BINARY_DIR}/crtm_geometryinfo_define.mod
        ${PROJECT_BINARY_DIR}/crtm_geometryinfo.mod
        ${PROJECT_BINARY_DIR}/crtm_interpolation.mod
        ${PROJECT_BINARY_DIR}/crtm_iricecoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_ir_ice_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_irlandcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_ir_land_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_irsnowcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_ir_snow_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_irssem.mod
        ${PROJECT_BINARY_DIR}/crtm_irwatercoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_ir_water_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_k_matrix_module.mod
        ${PROJECT_BINARY_DIR}/crtm_land_parameters.mod
        ${PROJECT_BINARY_DIR}/crtm_lifecycle.mod
        ${PROJECT_BINARY_DIR}/crtm_lowfrequency_mwssem.mod
        ${PROJECT_BINARY_DIR}/crtm_model_profiles.mod
        ${PROJECT_BINARY_DIR}/crtm_module.mod
        ${PROJECT_BINARY_DIR}/crtm_moleculescatter.mod
        ${PROJECT_BINARY_DIR}/crtm_mw_ice_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_mw_land_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_mw_snow_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_mwwatercoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_mw_water_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_nltecorrection.mod
        ${PROJECT_BINARY_DIR}/crtm_options_define.mod
        ${PROJECT_BINARY_DIR}/crtm_parameters.mod
        ${PROJECT_BINARY_DIR}/crtm_planck_functions.mod
        ${PROJECT_BINARY_DIR}/crtm_predictor_define.mod
        ${PROJECT_BINARY_DIR}/crtm_predictor.mod
        ${PROJECT_BINARY_DIR}/crtm_rtsolution_define.mod
        ${PROJECT_BINARY_DIR}/crtm_rtsolution.mod
        ${PROJECT_BINARY_DIR}/crtm_secategory.mod
        ${PROJECT_BINARY_DIR}/crtm_sensordata_define.mod
        ${PROJECT_BINARY_DIR}/crtm_sensorinfo.mod
        ${PROJECT_BINARY_DIR}/crtm_sfcoptics_define.mod
        ${PROJECT_BINARY_DIR}/crtm_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_spccoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_surface_define.mod
        ${PROJECT_BINARY_DIR}/crtm_tangent_linear_module.mod
        ${PROJECT_BINARY_DIR}/crtm_taucoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_utility.mod
        ${PROJECT_BINARY_DIR}/crtm_visicecoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_vis_ice_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_vislandcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_vis_land_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_vissnowcoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_vis_snow_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/crtm_viswatercoeff.mod
        ${PROJECT_BINARY_DIR}/crtm_vis_water_sfcoptics.mod
        ${PROJECT_BINARY_DIR}/csvar_define.mod
        ${PROJECT_BINARY_DIR}/date_utility.mod
        ${PROJECT_BINARY_DIR}/ellison.mod
        ${PROJECT_BINARY_DIR}/emission_module.mod
        ${PROJECT_BINARY_DIR}/endian_utility.mod
        ${PROJECT_BINARY_DIR}/file_utility.mod
        ${PROJECT_BINARY_DIR}/fitcoeff_define.mod
        ${PROJECT_BINARY_DIR}/foam_utility_module.mod
        ${PROJECT_BINARY_DIR}/fresnel.mod
        ${PROJECT_BINARY_DIR}/fundamental_constants.mod
        ${PROJECT_BINARY_DIR}/guillou.mod
        ${PROJECT_BINARY_DIR}/hyperbolic_step.mod
        ${PROJECT_BINARY_DIR}/iatm_define.mod
        ${PROJECT_BINARY_DIR}/irwatercoeff_define.mod
        ${PROJECT_BINARY_DIR}/large_scale_correction_module.mod
        ${PROJECT_BINARY_DIR}/liu.mod
        ${PROJECT_BINARY_DIR}/lseatlas_define.mod
        ${PROJECT_BINARY_DIR}/message_handler.mod
        ${PROJECT_BINARY_DIR}/minmax_find_utility.mod
        ${PROJECT_BINARY_DIR}/mwwatercoeff_define.mod
        ${PROJECT_BINARY_DIR}/mwwaterlut_define.mod
        ${PROJECT_BINARY_DIR}/nesdis_amsre_siceem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_amsre_snowem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_amsu_siceem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_amsu_snowem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_landem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_mhs_siceem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_mhs_snowem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_seaice_phyem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_snowem_parameters.mod
        ${PROJECT_BINARY_DIR}/nesdis_ssmi_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_ssmi_siceem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_ssmi_snowem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_ssmis_seaiceem_module.mod
        ${PROJECT_BINARY_DIR}/nesdis_ssmis_snowem_module.mod
        ${PROJECT_BINARY_DIR}/nltecoeff_binary_io.mod
        ${PROJECT_BINARY_DIR}/nltecoeff_define.mod
        ${PROJECT_BINARY_DIR}/nlte_parameters.mod
        ${PROJECT_BINARY_DIR}/nlte_predictor_define.mod
        ${PROJECT_BINARY_DIR}/nlte_predictor_io.mod
        ${PROJECT_BINARY_DIR}/odas_atmabsorption.mod
        ${PROJECT_BINARY_DIR}/odas_binary_io.mod
        ${PROJECT_BINARY_DIR}/odas_define.mod
        ${PROJECT_BINARY_DIR}/odas_predictor_define.mod
        ${PROJECT_BINARY_DIR}/odas_predictor.mod
        ${PROJECT_BINARY_DIR}/odas_taucoeff.mod
        ${PROJECT_BINARY_DIR}/odps_atmabsorption.mod
        ${PROJECT_BINARY_DIR}/odps_binary_io.mod
        ${PROJECT_BINARY_DIR}/odps_coordinatemapping.mod
        ${PROJECT_BINARY_DIR}/odps_define.mod
        ${PROJECT_BINARY_DIR}/odps_predictor_define.mod
        ${PROJECT_BINARY_DIR}/odps_predictor.mod
        ${PROJECT_BINARY_DIR}/odps_taucoeff.mod
        ${PROJECT_BINARY_DIR}/odssu_atmabsorption.mod
        ${PROJECT_BINARY_DIR}/odssu_binary_io.mod
        ${PROJECT_BINARY_DIR}/odssu_define.mod
        ${PROJECT_BINARY_DIR}/odssu_taucoeff.mod
        ${PROJECT_BINARY_DIR}/odzeeman_atmabsorption.mod
        ${PROJECT_BINARY_DIR}/odzeeman_predictor.mod
        ${PROJECT_BINARY_DIR}/odzeeman_taucoeff.mod
        ${PROJECT_BINARY_DIR}/pafv_define.mod
        ${PROJECT_BINARY_DIR}/profile_utility_parameters.mod
        ${PROJECT_BINARY_DIR}/reflection_correction_module.mod
        ${PROJECT_BINARY_DIR}/rtv_define.mod
        ${PROJECT_BINARY_DIR}/search_utility.mod
        ${PROJECT_BINARY_DIR}/secategory_define.mod
        ${PROJECT_BINARY_DIR}/sensorinfo_parameters.mod
        ${PROJECT_BINARY_DIR}/slope_variance.mod
        ${PROJECT_BINARY_DIR}/small_scale_correction_module.mod
        ${PROJECT_BINARY_DIR}/soi_module.mod
        ${PROJECT_BINARY_DIR}/sort_utility.mod
        ${PROJECT_BINARY_DIR}/spccoeff_binary_io.mod
        ${PROJECT_BINARY_DIR}/spccoeff_define.mod
        ${PROJECT_BINARY_DIR}/spectral_units_conversion.mod
        ${PROJECT_BINARY_DIR}/ssu_input_define.mod
        ${PROJECT_BINARY_DIR}/string_utility.mod
        ${PROJECT_BINARY_DIR}/subset_define.mod
        ${PROJECT_BINARY_DIR}/taucoeff_define.mod
        ${PROJECT_BINARY_DIR}/timing_utility.mod
        ${PROJECT_BINARY_DIR}/type_kinds.mod
        ${PROJECT_BINARY_DIR}/unittest_define.mod
        ${PROJECT_BINARY_DIR}/zeeman_input_define.mod
        ${PROJECT_BINARY_DIR}/zeeman_utility.mod
        DESTINATION "include/crtm")

#------------------------------------------------------------------------------
# CMake package configuration
install(EXPORT crtm-targets
        DESTINATION "lib/cmake")
install(FILES crtm-config.cmake
        DESTINATION "lib/cmake")

