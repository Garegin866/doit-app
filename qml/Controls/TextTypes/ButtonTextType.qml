import QtQuick

import "../../Config"

Text {
    lineHeight: 24
    lineHeightMode: Text.FixedHeight

    color: CC.colorText

    font {
        family: TC.fontFamily
        weight: 800
        pixelSize: 16
    }

    leftPadding: 16
    rightPadding: 16
    topPadding: 8
    bottomPadding: 8

    wrapMode: Text.WordWrap
}
