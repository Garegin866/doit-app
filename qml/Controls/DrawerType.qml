import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "TextTypes"
import "../Config"

Item {
    id: root

    readonly property string drawerExpanded: "expanded"
    readonly property string drawerCollapsed: "collapsed"

    readonly property bool isOpened: drawerContent.state === root.drawerExpanded || (drawerContent.state === root.drawerCollapsed && dragArea.drag.active === true)
    readonly property bool isClosed: drawerContent.state === root.drawerCollapsed && dragArea.drag.active === false

    readonly property bool isExpanded: drawerContent.state === root.drawerExpanded
    readonly property bool isCollapsed: drawerContent.state === root.drawerCollapsed

    property Component collapsedContent
    property Component expandedContent

    property string defaultColor: CC.colorPrimary
    property string borderColor: "white"//Qt.darker(CC.colorPrimary, 2)

    property real expandedHeight
    property real collapsedHeight: 0

    property int depthIndex: 0

    signal entered
    signal exited
    signal pressed(bool pressed, bool entered)

    signal aboutToHide
    signal aboutToShow
    signal close
    signal open
    signal closed
    signal opened


    Connections {
        target: root

        function onClose() {
            if (isCollapsed) {
                return
            }

            aboutToHide()

            drawerContent.state = root.drawerCollapsed
            depthIndex = 0
            closed()
        }

        function onOpen() {
            if (isExpanded) {
                return
            }

            aboutToShow()

            drawerContent.state = root.drawerExpanded
            opened()
        }
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: root.isCollapsed ? "transparent" : Qt.rgba(14/255, 14/255, 17/255, 0.8)

        Behavior on color {
            PropertyAnimation { duration: 200 }
        }
    }

    MouseArea {
        id: emptyArea
        anchors.fill: parent
        enabled: root.isExpanded
        visible: enabled
        onClicked: {
            root.close()
        }
    }

    MouseArea {
        id: dragArea

        anchors.fill: drawerContentBackground
        cursorShape: root.isCollapsed ? Qt.PointingHandCursor : Qt.ArrowCursor
        hoverEnabled: true

        enabled: drawerContent.implicitHeight > 0

        drag.target: drawerContent
        drag.axis: Drag.YAxis
        drag.maximumY: root.height - root.collapsedHeight
        drag.minimumY: root.height - root.expandedHeight

        /** If drag area is released at any point other than min or max y, transition to the other state */
        onReleased: {
            if (root.isCollapsed && drawerContent.y < dragArea.drag.maximumY) {
                root.open()
                return
            }
            if (root.isExpanded && drawerContent.y > dragArea.drag.minimumY) {
                root.close()
                return
            }
        }

        onEntered: {
            root.entered()
        }
        onExited: {
            root.exited()
        }
        onPressedChanged: {
            root.pressed(pressed, entered)
        }

        onClicked: {
            if (root.isCollapsed) {
                root.open()
            }
        }
    }

    Rectangle {
        id: drawerContentBackground

        anchors { left: drawerContent.left; right: drawerContent.right; top: drawerContent.top }
        height: root.height
        radius: 16
        color: root.defaultColor
        border.color: root.borderColor
        border.width: 1

        Rectangle {
            width: parent.radius
            height: parent.radius
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            color: parent.color
        }
    }

    Item {
        id: drawerContent

        Drag.active: dragArea.drag.active
        anchors.right: root.right
        anchors.left: root.left
        y: root.height - drawerContent.height
        state: root.drawerCollapsed

        implicitHeight: root.isCollapsed ? collapsedHeight : expandedHeight

        states: [
            State {
                name: root.drawerCollapsed
                PropertyChanges {
                    target: drawerContent
                    y: root.height - root.collapsedHeight
                }
            },
            State {
                name: root.drawerExpanded
                PropertyChanges {
                    target: drawerContent
                    y: dragArea.drag.minimumY

                }
            }
        ]

        transitions: [
            Transition {
                from: root.drawerCollapsed
                to: root.drawerExpanded
                PropertyAnimation {
                    target: drawerContent
                    properties: "y"
                    duration: 200
                }
            },
            Transition {
                from: root.drawerExpanded
                to: root.drawerCollapsed
                PropertyAnimation {
                    target: drawerContent
                    properties: "y"
                    duration: 200
                }
            }
        ]

        Loader {
            id: collapsedLoader

            sourceComponent: root.collapsedContent

            anchors.right: parent.right
            anchors.left: parent.left
        }

        Loader {
            id: expandedLoader

            visible: root.isExpanded
            sourceComponent: root.expandedContent

            anchors.right: parent.right
            anchors.left: parent.left
        }
    }
}
