import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls/TextTypes"
import "../Config"

Popup {
    id: rootr
    anchors.centerIn: Overlay.overlay
    modal: true

    Overlay.modal: Rectangle {
        color: Qt.rgba(14/255, 14/255, 17/255, 0.5)
    }

    background: Rectangle {
        anchors.fill: parent

        color: CC.colorPrimary
        radius: 4
    }

    contentItem: Item {
        implicitWidth: content.implicitWidth
        implicitHeight: content.implicitHeight

        anchors.fill: parent

        RowLayout {
            id: content

            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16

            CaptionTextType {
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true

                text: "wwrwrer"
            }
        }
    }

}
