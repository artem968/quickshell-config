import QtQuick
import Quickshell
import QtQuick.Layouts

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 40
    color: "black"

    GridLayout {
        anchors.fill: parent
        columns: 3

        WorkspacesIndicator {
            Layout.alignment: Qt.AlignLeft
        }

        Clock {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
        }

        SystemTray {
            Layout.alignment: Qt.AlignRight
        }
    }
}