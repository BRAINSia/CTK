###########################################################################
#
#  Library:   CTK
#
#  Copyright (c) Kitware Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0.txt
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
###########################################################################

#! \ingroup CMakeUtilities
macro(ctkMacroSetupQt)

  if(CTK_QT_VERSION VERSION_EQUAL "6")
    cmake_minimum_required(VERSION 3.16.3)
    find_package(Qt6 COMPONENTS Core Core5Compat StateMachine)

    set(CTK_QT6_COMPONENTS Core Core5Compat StateMachine)

    # See https://github.com/commontk/CTK/wiki/Maintenance#updates-of-required-qt-components

    if(CTK_LIB_Widgets
      OR CTK_LIB_DICOM/Widgets
      )
      list(APPEND CTK_QT6_COMPONENTS Svg)
    endif()

    if(CTK_LIB_Widgets
      OR CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTXML
      )
      list(APPEND CTK_QT6_COMPONENTS Xml)
    endif()

    # Need to use other xml library like, qt6 no longer provides xml 
    # if(CTK_APP_ctkCommandLineModuleExplorer
    #  OR CTK_LIB_QtTesting
    #  OR CTK_LIB_CommandLineModules/Core
    #  OR CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTXMLPATTERNS
    #  )
    #  list(APPEND CTK_QT6_COMPONENTS XmlPatterns)
    #endif()

    if(CTK_APP_ctkCommandLineModuleExplorer
      OR CTK_LIB_CommandLineModules/Core
      OR CTK_LIB_PluginFramework
      OR CTK_PLUGIN_org.commontk.eventadmin
      )
      list(APPEND CTK_QT6_COMPONENTS Concurrent)
    endif()

    if(CTK_LIB_DICOM/Core
      OR CTK_LIB_DICOM/Widgets
      OR CTK_LIB_PluginFramework
      )
      list(APPEND CTK_QT6_COMPONENTS Sql)
    endif()

    if(BUILD_TESTING)
      list(APPEND CTK_QT6_COMPONENTS Test)
    endif()

    if(CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTMULTIMEDIA)
      list(APPEND CTK_QT6_COMPONENTS Multimedia)
    endif()

    if(CTK_ENABLE_Widgets
      OR CTK_LIB_Widgets
      OR CTK_LIB_CommandLineModules/Frontend/QtGui
      OR CTK_LIB_QtTesting
      )
      list(APPEND CTK_QT6_COMPONENTS Widgets)
    endif()

    if(CTK_LIB_Widgets)
      list(APPEND CTK_QT6_COMPONENTS OpenGL)
    endif()

    if(CTK_APP_ctkCommandLineModuleExplorer
      OR CTK_LIB_CommandLineModules/Frontend/QtGui
      OR CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTUITOOLS
      )
      list(APPEND CTK_QT6_COMPONENTS UiTools)
    endif()

    if(CTK_LIB_CommandLineModules/Frontend/QtWebKit
      OR CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTWEBKIT
      OR CTK_LIB_Scripting/Python/Core_PYTHONQT_WRAP_QTWEBKITWIDGETS
      )
      if(TARGET Qt6::WebKitWidgets)
        list(APPEND CTK_QT6_COMPONENTS WebKitWidgets)
      else()
        list(APPEND CTK_QT6_COMPONENTS WebEngineWidgets)
      endif()
    endif()

    if(CTK_LIB_XNAT/Core)
      list(APPEND CTK_QT6_COMPONENTS Script)
    endif()

    if(CTK_BUILD_QTDESIGNER_PLUGINS)
      list(APPEND CTK_QT6_COMPONENTS Designer)
    endif()

    if(CTK_LIB_XNAT/Core
      OR CTK_PLUGIN_org.commontk.dah.core
      OR CTK_PLUGIN_org.commontk.dah.host
      OR CTK_PLUGIN_org.commontk.dah.hostedapp
      )
      list(APPEND CTK_QT6_COMPONENTS Network)
    endif()

    find_package(Qt6 COMPONENTS ${CTK_QT6_COMPONENTS} REQUIRED)

    mark_as_superbuild(Qt6_DIR) # Qt 6

    # XXX Backward compatible way
    if(DEFINED CMAKE_PREFIX_PATH)
      mark_as_superbuild(CMAKE_PREFIX_PATH) # Qt 6
    endif()

    set(_major ${Qt6_VERSION_MAJOR})
    set(_minor ${Qt6_VERSION_MINOR})
    set(_patch ${Qt6_VERSION_PATCH})

    ctk_list_to_string(", " "${CTK_QT6_COMPONENTS}" comma_separated_module_list)
    message(STATUS "Configuring CTK with Qt ${_major}.${_minor}.${_patch} (using modules: ${comma_separated_module_list})")
    set(CTK_QT6_COMPONENTS ${CTK_QT6_COMPONENTS} PARENT_SCOPE)
  else()
    message(FATAL_ERROR "Support for Qt${CTK_QT_VERSION} is not implemented")
  endif()
endmacro()
