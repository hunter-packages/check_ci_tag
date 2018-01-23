cmake_minimum_required(VERSION 3.1) # CMP0054
project(check_ci_tag VERSION 1.0.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/module")

include(check_ci_tag)

check_ci_tag()

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")

set(config_install_dir "lib/cmake/${PROJECT_NAME}")
set(MODULE_INSTALL_DIR "cmake/module")

include(CMakePackageConfigHelpers)

# Use:
# * PROJECT_VERSION
write_basic_package_version_file(
    ${version_config} COMPATIBILITY SameMajorVersion
)

# Use:
# * PROJECT_NAME
# * MODULE_INSTALL_DIR
configure_package_config_file(
    cmake/template/Config.cmake.in
    ${project_config}
    INSTALL_DESTINATION "${config_install_dir}"
    PATH_VARS MODULE_INSTALL_DIR
)

install(
    FILES "${CMAKE_CURRENT_LIST_DIR}/cmake/module/check_ci_tag.cmake"
    DESTINATION ${MODULE_INSTALL_DIR}
)

install(
    FILES ${project_config} ${version_config}
    DESTINATION ${config_install_dir}
)
