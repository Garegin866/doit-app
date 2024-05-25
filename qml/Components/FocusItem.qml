import QtQuick 2.15

Item {
    property var nextItem

    id: focusItem
    Keys.onTabPressed: {
        if (nextItem) {
            nextItem.forceActiveFocus()
        }
    }
}
