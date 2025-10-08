import QtQuick
import Quickshell

Text {
    id: clockText
    color: "white"
    font.pixelSize: 14

    SystemClock {
        id: clock
    }

    text: Qt.formatDateTime(clock.date, "hh:mm")
}