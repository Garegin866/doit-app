import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"
import "../Config"
import "../Components"

PageType {

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.minimumWidth: parent.width
            Layout.alignment: Qt.AlignTop

            BasicButtonType {
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
                textColor: CC.colorText
                implicitHeight: 56
                implicitWidth: 56
                imageSource: "qrc:/images/plus.svg"
                defaultColor: CC.colorButtonBackground
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: {
                    TaskListModel.addTask("dssdfsdf", "sdfsdfsdf")
                }
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
}
