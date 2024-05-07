import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "TextTypes"
import "../Config"

Button {
    id: root

    property string hoveredColor: Qt.darker(defaultColor, 1.5)
    property string defaultColor: "white"
    property string disabledColor: Qt.darker(defaultColor, 1.5)
    property string pressedColor: hoveredColor

    property string borderColor: "#D7D8DB"
    property string borderFocusedColor: "#D7D8DB"
    property int borderWidth: 0
    property int borderFocusedWidth: 1

    property string textColor: (root.hovered || root.pressed || !root.enabled) ? Qt.darker("#2F3142", 1.5) : "#2F3142"

    property string imageSource
    property string rightImageSource
    property string imageColor: textColor

    property var clickedFunc

    implicitHeight: 56

    background: Rectangle {
        id: focusBorder

        color: "transparent"
        border.color: root.activeFocus ? root.borderFocusedColor : "transparent"
        border.width: root.activeFocus ? root.borderFocusedWidth : 0

        anchors.fill: parent

        radius: 16

        Rectangle {
            id: background
            anchors.fill: focusBorder
            anchors.margins: root.activeFocus ? 2 : 0

            radius: root.activeFocus ? 14 : 16
            color: {
                if (root.enabled) {
                    if (root.pressed) {
                        return pressedColor
                    }
                    return root.hovered ? hoveredColor : defaultColor
                } else {
                    return disabledColor
                }
            }

            Behavior on color {
                PropertyAnimation { duration: 200 }
            }
        }
    }

    MouseArea {
        anchors.fill: focusBorder
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }

    contentItem: Item {
        anchors.fill: focusBorder

        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        RowLayout {
            id: content
            anchors.centerIn: parent

            Image {
                Layout.preferredHeight: 20
                Layout.preferredWidth: 20

                source: root.imageSource
                visible: root.imageSource === "" ? false : true

                layer {
                    enabled: true
                    effect: ColorOverlay {
                        color: imageColor
                    }
                }
            }

            ButtonTextType {
                color: textColor
                text: root.text
                visible: root.text === "" ? false : true

                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Image {
                Layout.preferredHeight: 20
                Layout.preferredWidth: 20

                source: root.rightImageSource
                visible: root.rightImageSource === "" ? false : true

                layer {
                    enabled: true
                    effect: ColorOverlay {
                        color: textColor
                    }
                }
            }
        }
    }

    Keys.onEnterPressed: {
        if (root.clickedFunc && typeof root.clickedFunc === "function") {
            root.clickedFunc()
        }
    }

    Keys.onReturnPressed: {
        if (root.clickedFunc && typeof root.clickedFunc === "function") {
            root.clickedFunc()
        }
    }

    onClicked: {
        if (root.clickedFunc && typeof root.clickedFunc === "function") {
            root.clickedFunc()
        }
    }
}
