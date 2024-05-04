import QtQuick

import "../../Config"

Text {
    lineHeight: 24
    lineHeightMode: Text.FixedHeight

    color: CC.colorText
    font.pixelSize: 16
    font.weight: 800
    font.family: "Roboto"

    leftPadding: 16
    rightPadding: 16
    topPadding: 8
    bottomPadding: 8

    wrapMode: Text.WordWrap
}
