#
# See CMake/ctkFunctionGetTargetLibraries.cmake
#
# This file should list the libraries required to build the current CTK libraries
#

set(target_libraries
  VTK_LIBRARIES
  CTKWidgets
  CTKVisualizationVTKCore
  )
if(CTK_QT_VERSION VERSION_EQUAL "6")
  list(APPEND target_libraries Qt6Network_LIBRARIES Qt6WebKit_LIBRARIES)
else()
  message(FATAL_ERROR "Support for this Qt is not implemented")
endif()
