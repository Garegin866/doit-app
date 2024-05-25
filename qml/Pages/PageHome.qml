import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"
import "../Config"
import "../Components"

PageType {
    id: root
    defaultActiveFocusItem: focusItem

    FocusItem {
        id: focusItem
        nextItem: plusButton
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            visible: false
            Layout.fillWidth: true
            Layout.minimumWidth: parent.width
            Layout.alignment: Qt.AlignTop

            BasicButtonType {
                id: menuButton
                textColor: CC.colorText
                imageSource: "qrc:/images/menu.svg"
                defaultColor: "transparent"
                Layout.alignment: Qt.AlignVCenter
                clickedFunc: function() {
                    PageController.openMenu()
                }
            }

            Text {
                text: "Do it!"
                color: CC.colorText
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font {
                    pixelSize: 25
                    bold: true
                    family: TC.fontFamily
                }
            }

            BasicButtonType {
                textColor: CC.colorText
                imageSource: "qrc:/images/notificatoin-default.svg"
                defaultColor: "transparent"
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: {

                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            Text {
                text: "Tasks 🚀"
                color: CC.colorText
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
                topPadding: 20
                bottomPadding: 20

                font {
                    pixelSize: 36
                    family: TC.fontFamily
                    bold: true
                }
            }

            BasicButtonType {
                id: plusButton

                textColor: CC.colorPrimary
                implicitHeight: 56
                implicitWidth: 56
                imageSource: "qrc:/images/plus.svg"
                defaultColor: CC.colorBackground
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                clickedFunc: function () {
                    createTaskDrawer.open()
                }

                KeyNavigation.tab: focusItem
            }
        }


        ListView {
            id: taskList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 10
            model: TaskListModel
            delegate: TaskItem {
                width: taskList.width
                listView: taskList
            }
        }
    }


    DrawerType {
        id: createTaskDrawer

        parent: root.parent.parent
        anchors.fill: parent
        expandedHeight: parent.height * 0.5

        onClosed: {
            if (!GC.isMobile()) {
                PageController.activeFocusCurrentPage()
            }
        }

        expandedContent: Item {
            id: configContentContainer
            implicitHeight: createTaskDrawer.expandedHeight

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: cornerMargin
            }

            Connections {
                target: createTaskDrawer

                function onClosed() {
                    taskTitle.textField.text = ""
                    taskDescription.textField.text = ""

                    taskTitle.textField.focus = false
                    taskDescription.textField.focus = false

                    Qt.inputMethod.hide()
                }
            }

            Connections {
                target: createTaskDrawer
                enabled: !GC.isMobile()
                function onOpened() {
                     taskTitle.textField.forceActiveFocus()
                }
            }

            ColumnLayout {
                width: parent.width
                height: parent.implicitHeight - 2 * cornerMargin

                FocusItem {
                    id: focusItem1
                    nextItem: taskTitle.textField
                }

                Text {
                    text: qsTr("Add new task")
                    color: CC.colorText
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    font {
                        pixelSize: 25
                        bold: true
                        family: TC.fontFamily
                    }
                }

                TextFieldType {
                    id: taskTitle

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter

                    textFieldPlaceholderText: qsTr("Enter task title")
                    checkEmptyText: true

                    KeyNavigation.tab: taskDescription.textField
                }


                TextFieldType {
                    id: taskDescription

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter

                    textFieldPlaceholderText: qsTr("Enter task description")
                    checkEmptyText: true

                    KeyNavigation.tab: createTaskButton.enabled ? createTaskButton : focusItem1
                }


                BasicButtonType {
                    id: createTaskButton
                    y: Math.abs(parent.height) - createTaskButton.height
                    text: qsTr("Create Task")

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter

                    enabled: taskTitle.textField.text.length > 0 && taskDescription.textField.text.length > 0

                    KeyNavigation.tab: focusItem1

                    clickedFunc: function() {
                        TaskListModel.addTask(taskTitle.textField.text, taskDescription.textField.text)
                        createTaskDrawer.close()
                    }
                }
            }

        }
    }

}
