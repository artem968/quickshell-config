import Quickshell
import QtQuick

PanelWindow {
  anchors {
      top: true
      left: true
      right: true
  }
  implicitHeight: 30
  color: "black"

  SystemClock {
      id: clock
  }

  Text {
      anchors.centerIn: parent
      text: Qt.formatDateTime(clock.date, "hh:mm")
      color: "white"
  }

  WorkspaceIndicator {
    id: wsIndicator
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.margins: 6
  }
}
