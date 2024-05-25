import QtQuick
import QtQuick.Layouts
import QtCore

import "../Controls"
import "../Config"
import "../Components"

import PageEnum 1.0

PageType {
    id: root

    defaultActiveFocusItem: textField.textField
    previousPage: PageEnum.PageStart

    ColumnLayout {
        width: parent.width
        height: parent.height

        FocusItem {
            id: focusItem
            nextItem: textField.textField
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 40

            Text {
                text: qsTr("What is your name?")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: CC.colorText
                font {
                    pixelSize: 30
                    bold: true
                    family: TC.fontFamily
                }
            }

            TextFieldType {
                id: textField

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                textFieldPlaceholderText: qsTr("Enter your name")
                checkEmptyText: true

                KeyNavigation.tab: button.enabled ? button : focusItem
            }
        }

        Settings {
            id: settings
        }

        BasicButtonType {
            id: button
            text: qsTr("Continue")

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            enabled: textField.valid

            KeyNavigation.tab: focusItem
            clickedFunc: function () {
                // add name to Settings
                settings.setValue("name", textField.textField.text)

                PageController.goToPage(PageEnum.PageHome)
            }
        }
    }

}
