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

        SystemTray {
            Layout.alignment: Qt.AlignLeft
            parentWindow: root
            parentScreen: root.screen
        }

        Clock {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
        }

        WorkspacesIndicator {
            Layout.alignment: Qt.AlignRight
            Layout.maximumWidth: root.width / 3
        }
    }
}