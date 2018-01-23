Simple CMake utility to check consistency between PROJECT_VERSION declaration
and release tag provided by CI systems (AppVeyor, Travis).

Usage
-----

.. code-block:: cmake

  check_minimum_required(VERSION 3.0)

  include("cmake/HunterGate.cmake")
  HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.19.234.tar.gz"
    SHA1 "3deec1041bd01c91e78269522b901fbab3a765e5"
  )

  project(foo VERSION 1.2.3)

  hunterhunter_add_package(check_ci_tag)
  find_package(check_ci_tag CONFIG REQUIRED)

  check_ci_tag()

Workflow
--------

Update VERSION:

.. code-block:: none

  > grep 'project.*VERSION' CMakeLists.txt
  project(check_ci_tag VERSION 1.0.0)

Commit it:

.. code-block:: none

  > git add CMakeLists.txt
  > git commit -m 'Version 1.0.0'

Create tag:

.. code-block:: none

  > git tag v1.0.0

Push changes:

.. code-block:: none

  > git push

Push new tag

.. code-block:: none

  > git push --tags
