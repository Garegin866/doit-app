import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"
import "../Config"
import "../Components"

import PageEnum 1.0

PageType {
    id: root

    defaultActiveFocusItem: focusItem

    FocusItem {
        id: focusItem
        nextItem: buttonStart
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 40

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 30
            Layout.alignment: Qt.AlignVCenter

            SwipeView {
                id: view
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Timer {
                    interval: 4000
                    running: root.visible
                    repeat: true
                    onTriggered: {
                        if (view.currentIndex < view.count - 1) {
                            view.currentIndex++
                        } else {
                            view.currentIndex = 0
                        }
                    }
                }

                ColumnLayout {

                    Image {
                        Layout.maximumWidth: implicitHeight * 0.6
                        Layout.preferredHeight: 250
                        Layout.maximumHeight: 250
                        Layout.alignment: Qt.AlignHCenter

                        source: "qrc:/images/banner1.png"
                    }

                    Text {
                        text: qsTr("DoIt")
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorText
                        font {
                            pixelSize: 36
                            bold: true
                            family: "Roboto"
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTr("Get organized, get productive. <b>DoIt.</b>")
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorTextSecondary
                        font.pixelSize: 18
                        font.weight: 400
                        font.family: "Roboto"
                    }
                }
                ColumnLayout {

                    Image {
                        Layout.maximumWidth: implicitHeight * 0.6
                        Layout.preferredHeight: 250
                        Layout.maximumHeight: 250
                        Layout.alignment: Qt.AlignHCenter

                        source: "qrc:/images/banner2.png"
                    }

                    Text {
                        text: qsTr("DoIt")
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorText
                        font {
                            pixelSize: 36
                            bold: true
                            family: "Roboto"
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTr("Don't just dream it, <b>DoIt!</b>")
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorTextSecondary
                        font.pixelSize: 18
                        font.weight: 400
                        font.family: "Roboto"
                    }
                }
                ColumnLayout {

                    Image {
                        Layout.maximumWidth: implicitHeight * 0.6
                        Layout.preferredHeight: 250
                        Layout.maximumHeight: 250
                        Layout.alignment: Qt.AlignHCenter

                        source: "qrc:/images/banner3.png"
                    }

                    Text {
                        text: qsTr("DoIt")
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorText
                        font {
                            pixelSize: 36
                            bold: true
                            family: "Roboto"
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: qsTr("<b>DoIt:</b> Turn your \"to-do\"s into \"done\"s.")
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        color: CC.colorTextSecondary
                        font.pixelSize: 18
                        font.weight: 400
                        font.family: "Roboto"
                    }
                }

            }

            PageIndicator {
                id: indicator

                count: view.count
                currentIndex: view.currentIndex
                Layout.alignment: Qt.AlignHCenter

                delegate: Rectangle {
                      implicitWidth: 8
                      implicitHeight: 8

                      radius: width / 2
                      color: index === indicator.currentIndex ? "#525298" : "#7B8085"

                      Behavior on color {
                          ColorAnimation {
                              duration: 200
                          }
                      }

                      MouseArea {
                          anchors.fill: parent
                          onClicked: view.currentIndex = index
                          cursorShape: Qt.PointingHandCursor
                      }
                  }
            }


        }

        BasicButtonType {
            id: buttonStart
            implicitHeight: 56
            implicitWidth: 56
            rightImageSource: "qrc:/images/arrow_right.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            defaultColor: CC.colorText
            textColor: (buttonStart.hovered || buttonStart.pressed ) ? Qt.darker(CC.colorSecondary, 1.5) : CC.colorSecondary

            KeyNavigation.tab: focusItem
            clickedFunc: function () {
                PageController.goToPage(PageEnum.PageSetup)
            }
        }

    }
}
