import QtQuick 2.15
import QtQuick.Controls

import "../Config"

Drawer {
    id: root

    width: parent.width * 0.7
    height: parent.height
    edge: Qt.LeftEdge
    dim: true

    Connections {
        target: PageController
        function onOpenMenu() {
            root.open()
        }
    }

    contentItem: Rectangle {
        color: CC.colorPrimary
        anchors.fill: parent

        Text {
            id: title
            text: "Menu"
            color: CC.colorText
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.topMargin: 16

            font {
                pixelSize: 26
                bold: true
                family: TC.fontFamily
            }
        }

        ListView {
            id: listView
            anchors.top: title.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 16
            anchors.leftMargin: 16
            anchors.rightMargin: 16

            model: ListModel {
                ListElement { name: "Home"; icon: "home"; page: "home" }
                ListElement { name: "Settings"; icon: "settings"; page: "settings" }
                ListElement { name: "About"; icon: "info"; page: "about" }
            }

            delegate: Item {
                width: listView.width
                height: 48

                Rectangle {
                    color: listView.currentIndex === index ? CC.colorPrimary : "transparent"
                    anchors.fill: parent

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            PageController.openPage(page)
                            root.close()
                        }
                    }

                    Text {
                        text: name
                        color: CC.colorText
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter

                        font {
                            pixelSize: 18
                            family: TC.fontFamily
                        }
                    }

                    // Image {
                    //     source: "qrc:/icons/ic_" + icon + ".png"
                    //     anchors.right: parent.right
                    //     anchors.rightMargin: 16
                    //     anchors.verticalCenter: parent.verticalCenter
                    // }
                }
            }


        }
    }

}
