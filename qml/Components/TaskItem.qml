import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import "../Config"
import "../Controls"
import "../Popups"

SwipeDelegate {
    id: root

    // Required properties from parent ListView
    required property ListView listView
    required property int index
    required property string taskName
    required property string description
    required property bool completed

    swipe.transition: Transition {
        SmoothedAnimation { velocity: 3; easing.type: Easing.InOutCubic }
    }

    height: background.height

    ListView.onRemove: removeAnimation

    background: Rectangle {
        id: background
        color: CC.colorTaskItemBackground
        border.width: 1
        radius: 10
        width: parent.width
        height: childrenRect.height

        CheckBoxType {
            id: checkBox
            text: taskName
            checked: completed
            width: parent.width
            descriptionText: description

        }
    }

    swipe.right: Label {
        id: deleteLabel
        text: qsTr("Delete")
        color: CC.colorText
        verticalAlignment: Label.AlignVCenter
        padding: 12
        height: parent.height
        anchors.right: parent.right

        SwipeDelegate.onClicked: listView.model.removeTask(index)

        background: Rectangle {
            radius: 10
            color: deleteLabel.SwipeDelegate.pressed ? Qt.darker(CC.colorTaskItemDeleteBackground, 1.1) : CC.colorTaskItemDeleteBackground
        }
    }

    SequentialAnimation {
        id: removeAnimation
        PropertyAction {
            target: root
            property: "ListView.delayRemove"
            value: true
        }
        NumberAnimation {
            target: root
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: root
            property: "ListView.delayRemove"
            value: false
        }
    }

    TapHandler {
        onTapped: {
            checkBox.checked = !checkBox.checked

        }

        onLongPressed: {
            taskItemPopup.open()
        }
    }

    TaskItemPopup {
        id: taskItemPopup

        width: parent.width * 0.6
        height: width
    }

}
