include(CMakeParseArguments) # cmake_parse_arguments

function(check_ci_tag)
  if(NOT "${ARGV}" STREQUAL "")
    message(FATAL_ERROR "No arguments expected, got: '${ARGV}'")
  endif()

  if("${PROJECT_VERSION}" STREQUAL "")
    message(FATAL_ERROR "Variable PROJECT_VERSION is not set")
  endif()

  if(CHECK_CI_TAG_DONE)
    return()
  endif()

  set(CHECK_CI_TAG_DONE TRUE PARENT_SCOPE)

  if(HUNTER_ENABLED)
    # Hunter support: Skip checks if project build as a third party
    if(NOT "${HUNTER_PARENT_PACKAGE}" STREQUAL "")
      message(
          "Hunter detected. Parent project: ${HUNTER_PARENT_PACKAGE}."
          " Skipping tag check."
      )
      return()
    endif()
  endif()

  if(NOT "$ENV{TRAVIS_TAG}" STREQUAL "")
    # Tag from Travis CI environment:
    # * https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
    if(NOT "$ENV{TRAVIS_TAG}" STREQUAL "v${PROJECT_VERSION}")
      string(REGEX REPLACE "^v" "" expected_project_version "$ENV{TRAVIS_TAG}")
      message(
          FATAL_ERROR
          "Inconsistent tag/version:\n"
          " TRAVIS_TAG = $ENV{TRAVIS_TAG}\n"
          " PROJECT_VERSION = ${PROJECT_VERSION}\n"
          "Expected PROJECT_VERSION value is '${expected_project_version}'\n"
          "CMake code:\n"
          "project(${PROJECT_NAME} VERSION ${expected_project_version})\n"
      )
    endif()
  endif()

  if("$ENV{APPVEYOR_REPO_TAG}" STREQUAL "true")
    # Tag from AppVeyor environment:
    # * https://www.appveyor.com/docs/environment-variables/
    if(NOT "$ENV{APPVEYOR_REPO_TAG_NAME}" STREQUAL "v${PROJECT_VERSION}")
      string(REGEX REPLACE "^v" "" expected_project_version "$ENV{APPVEYOR_REPO_TAG_NAME}")
      message(
          FATAL_ERROR
          "Inconsistent tag/version:\n"
          " APPVEYOR_REPO_TAG_NAME = $ENV{APPVEYOR_REPO_TAG_NAME}\n"
          " PROJECT_VERSION = ${PROJECT_VERSION}\n"
          "Expected PROJECT_VERSION value is '${expected_project_version}'\n"
          "CMake code:\n"
          "project(${PROJECT_NAME} VERSION ${expected_project_version})\n"
      )
    endif()
  endif()
endfunction()
