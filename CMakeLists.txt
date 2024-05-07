cmake_minimum_required(VERSION 3.16)

project(DoIt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Widgets QuickControls2 Sql)

qt_standard_project_setup()

qt_add_executable(DoIt
    src/main.cpp
)

qt_add_qml_module(DoIt
    URI DoIt
    VERSION 1.0
    QML_FILES
        RESOURCES qml/qml.qrc
        RESOURCES resources/resources.qrc
        SOURCES src/doitapplication.h src/doitapplication.cpp
        SOURCES src/pagecontroller.h src/pagecontroller.cpp
        SOURCES src/TaskListModel/tasklistmodel.h src/TaskListModel/tasklistmodel.cpp
        SOURCES src/TaskListModel/task.h src/TaskListModel/task.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(DoIt PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.DoIt
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(DoIt
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Widgets
    PRIVATE Qt6::QuickControls2
    PRIVATE Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS DoIt
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
