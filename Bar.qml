// Bar.qml
import Quickshell
import QtQuick

Scope {
  // the Time type we just created
  Bat { id: batSource }
  Resource { id: resourceSource}

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
          anchors.fill: parent
          color: "black"
      }

      implicitHeight: 30

      WorkspacesIndicator {
          id: wsindicator
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.margins: 6
      }

      ResourceWidget {
        time: resourceSource.time
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: wsindicator.right
        anchors.margins: 6
      }

      Text {
          id: clockText
          color: "white"
          font.pixelSize: 14
          anchors.centerIn: parent
      
          SystemClock {
              id: clock
          }
      
          text: Qt.formatDateTime(clock.date, "hh:mm:ss")
      }

      SystemTray {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: batWidget.left
        anchors.margins: 6
      }

      BatWidget {
          id: batWidget
          time: batSource.time
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.margins: 6
      }
    }
  }
}
