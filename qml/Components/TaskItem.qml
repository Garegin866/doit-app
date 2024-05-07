import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

import "../Config"
import "../Controls"
import "../Popups"

ItemDelegate {
    id: root

    // Required properties from parent ListView
    required property ListView listView
    required property int index
    required property string taskName
    required property string description
    required property bool completed

    // swipe.transition: Transition {
    //     SmoothedAnimation { velocity: 3; easing.type: Easing.InOutCubic }
    // }

    height: background.height

    // ListView.onRemove: removeAnimation

    background: Rectangle {
        id: background
        color: CC.colorTaskItemBackground
        border.width: 1
        radius: 10
        width: parent.width
        height: childrenRect.height

        CheckBoxType {
            id: checkBox
            // Layout.alignment: Qt.AlignLeft
            text: taskName
            checked: completed
            // Layout.fillWidth: true
            width: parent.width
            descriptionText: description

        }

        // RowLayout {
        //     width: parent.width
        //     spacing: 0

        //     CheckBoxType {
        //         id: checkBox
        //         Layout.alignment: Qt.AlignLeft
        //         text: taskName
        //         Layout.fillWidth: true
        //         descriptionText: "#Sport"

        //     }
        // }
    }

    // swipe.right: Label {
    //     id: deleteLabel
    //     text: qsTr("Delete")
    //     color: "white"
    //     verticalAlignment: Label.AlignVCenter
    //     padding: 12
    //     height: parent.height
    //     anchors.right: parent.right

    //     SwipeDelegate.onClicked: listView.model.remove(index)

    //     background: Rectangle {
    //         color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
    //     }
    // }

    // SequentialAnimation {
    //     id: removeAnimation
    //     PropertyAction {
    //         target: root
    //         property: "ListView.delayRemove"
    //         value: true
    //     }
    //     NumberAnimation {
    //         target: root
    //         property: "height"
    //         to: 0
    //         easing.type: Easing.InOutQuad
    //     }
    //     PropertyAction {
    //         target: root
    //         property: "ListView.delayRemove"
    //         value: false
    //     }
    // }

    TapHandler {
        onTapped: {
            checkBox.checked = !checkBox.checked

        }

        onLongPressed: {
            taskItemPopup.open()
        }
    }

    // MouseArea {
    //     anchors.fill: parent
    //     cursorShape: Qt.PointingHandCursor
    //     onClicked: (mouse) => {
    //                    checkBox.checked = !checkBox.checked
    //     }
    // }

    TaskItemPopup {
        id: taskItemPopup

        width: parent.width * 0.6
        height: width
    }

}
