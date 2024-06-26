import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

import "Config"
import "Controls"
import "Drawers"
import "Components"

import PageEnum 1.0

Window  {
    id: appWindow
    objectName: "mainWindow"
    visible: true
    width: GC.screenWidth
    height: GC.screenHeight
    minimumWidth: GC.isDesktop() ? 360 : 0
    minimumHeight: GC.isDesktop() ? 640 : 0
    maximumWidth: 600
    maximumHeight: 800

    color: CC.colorPrimary
    title: "DoIt"

    property real cornerMargin: 16

    Settings {
        id: settings
    }

    StackViewType {
        id: rootStackView

        width: appWindow.width
        height: appWindow.height
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: cornerMargin
        }

        focus: true

        Component.onCompleted: {
            let userName = settings.value("name", "")

            if (userName === "") {
                var pagePath = PageController.getInitialPage()
                rootStackView.push(pagePath, { "objectName" : pagePath })
            } else {
                PageController.goToPage(PageEnum.PageHome)
            }
        }

        Keys.onEscapePressed: {
            var currentPage = rootStackView.currentItem
            if (currentPage && (currentPage.previousPage != undefined)) {
                var pagePath = PageController.getPagePath(currentPage.previousPage)
                rootStackView.clear()
                rootStackView.push(pagePath, { "objectName" : pagePath }, StackView.PushTransition)
            }
        }

    }

    Connections {
        target: PageController
        function onGoToPage(page, slide) {
            rootStackView.clear()
            var pagePath = PageController.getPagePath(page)
            if (slide) {
                rootStackView.push(pagePath, { "objectName" : pagePath }, StackView.PushTransition)
            } else {
                rootStackView.push(pagePath, { "objectName" : pagePath }, StackView.Immediate)
            }
        }
        function onActiveFocusCurrentPage() {
            rootStackView.currentItem.forceActiveFocus()
        }
    }

}
