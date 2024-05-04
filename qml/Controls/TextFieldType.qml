import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "TextTypes"
import "../Config"

Item {
    id: root

    property alias errorText: errorField.text
    property bool checkEmptyText: false
    property string errotTextColor: "#EB5757"

    property bool valid: checkEmptyText ? textFieldText !== "" : true

    property var clickedFunc

    property alias textField: textField
    property alias textFieldText: textField.text
    property string textFieldTextColor: "#d7d8db"
    property string textFieldTextDisabledColor: "#878B91"

    property string placeholderTextColor: "#92939b"
    property string textFieldPlaceholderText
    property bool textFieldEditable: true

    property string borderColor: "#2C2D30"
    property string borderFocusedColor: "#d7d8db"

    property string backgroundColor: "#252836"
    property string backgroundDisabledColor: "transparent"
    property string backgroundBorderHoveredColor: "#494B50"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    ColumnLayout {
        id: content
        anchors.fill: parent

        Rectangle {
            id: backgroud
            Layout.fillWidth: true
            Layout.preferredHeight: input.implicitHeight
            color: root.enabled ? root.backgroundColor : root.backgroundDisabledColor
            radius: 16
            border.color: getBackgroundBorderColor(root.borderColor)
            border.width: 1

            Behavior on border.color {
                PropertyAnimation { duration: 200 }
            }

            RowLayout {
                id: input
                anchors.fill: backgroud
                ColumnLayout {
                    Layout.margins: 16

                    TextField {
                        id: textField
                        activeFocusOnTab: false

                        enabled: root.textFieldEditable
                        color: root.enabled ? root.textFieldTextColor : root.textFieldTextDisabledColor

                        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText

                        placeholderText: root.textFieldPlaceholderText
                        placeholderTextColor: root.placeholderTextColor

                        selectionColor:  CC.colorSecondary
                        selectedTextColor: "#D7D8DB"

                        font.pixelSize: 16
                        font.weight: 400
                        font.family: "Roboto"

                        height: 24
                        Layout.fillWidth: true

                        topPadding: 0
                        rightPadding: 0
                        leftPadding: 0
                        bottomPadding: 0

                        background: Rectangle {
                            anchors.fill: parent
                            color: root.enabled ? root.backgroundColor : root.backgroundDisabledColor
                        }

                        onTextChanged: {
                            root.errorText = ""
                        }

                        onActiveFocusChanged: {
                            if (checkEmptyText && textFieldText === "") {
                                errorText = qsTr("The field can't be empty")
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            onClicked: contextMenu.open()
                            enabled: true
                        }

                        onFocusChanged: {
                            backgroud.border.color = getBackgroundBorderColor(root.borderColor)
                        }
                    }
                }
            }
        }

        Text {
            id: errorField
            // lineHeight: 20 + LanguageModel.getLineHeightAppend()
            lineHeightMode: Text.FixedHeight

            font.pixelSize: 14
            font.weight: 400
            font.family: "Roboto"

            wrapMode: Text.WordWrap

            text: root.errorText
            visible: root.errorText !== ""
            color: root.errotTextColor
        }
    }

    MouseArea {
        anchors.fill: root
        cursorShape: Qt.IBeamCursor

        hoverEnabled: true

        onPressed: function(mouse) {
            textField.forceActiveFocus()
            mouse.accepted = false

            backgroud.border.color = getBackgroundBorderColor(root.borderColor)
        }

        onEntered: {
            backgroud.border.color = getBackgroundBorderColor(root.backgroundBorderHoveredColor)
        }

        onExited: {
            backgroud.border.color = getBackgroundBorderColor(root.borderColor)
        }
    }

    function getBackgroundBorderColor(noneFocusedColor) {
        return textField.focus ? root.borderFocusedColor : noneFocusedColor
    }

    Keys.onEnterPressed: {
        if (root.clickedFunc && typeof root.clickedFunc === "function") {
            clickedFunc()
        }

        if (KeyNavigation.tab) {
            KeyNavigation.tab.forceActiveFocus();
        }
    }

    Keys.onReturnPressed: {
        if (root.clickedFunc && typeof root.clickedFunc === "function") {
            clickedFunc()
        }

        if (KeyNavigation.tab) {
            KeyNavigation.tab.forceActiveFocus();
        }
    }
}
