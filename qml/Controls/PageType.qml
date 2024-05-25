import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Config"

Item {
    id: root

    property var defaultActiveFocusItem: null

    property var previousPage: null

    onVisibleChanged: {
        if (visible && !GC.isMobile()) {
            timer.start()
        }
    }

    onActiveFocusChanged: {
        if (activeFocus) {
            if (defaultActiveFocusItem) {
                defaultActiveFocusItem.forceActiveFocus()
            }
        }
    }

    // function lastItemTabClicked(focusItem) {
    //     if (GC.isMobile()) {
    //         return
    //     }

    //     if (focusItem) {
    //         focusItem.forceActiveFocus()
    //         PageController.forceTabBarActiveFocus()
    //     } else {
    //         if (defaultActiveFocusItem) {
    //             defaultActiveFocusItem.forceActiveFocus()
    //         }
    //         PageController.forceTabBarActiveFocus()
    //     }
    // }

   // MouseArea {
   //     id: globalMouseArea
   //     z: 99
   //     anchors.fill: parent

   //     enabled: true

   //     onPressed: function(mouse) {
   //         forceActiveFocus()
   //         mouse.accepted = false
   //     }
   // }

    // Set a timer to set focus after a short delay
    Timer {
        id: timer
        interval: 100 // Milliseconds
        onTriggered: {
            if (defaultActiveFocusItem) {
                defaultActiveFocusItem.forceActiveFocus()
            }
        }
        repeat: false // Stop the timer after one trigger
        running: !GC.isMobile()  // Start the timer
    }
}
