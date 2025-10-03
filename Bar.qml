//@ pragma UseQApplication
import QtQuick
import Quickshell
import QtQuick.Layouts

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 35
    color: "black"

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Left: WorkspacesIndicator
        WorkspacesIndicator {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 10
        }

        // Spacer to center Clock
        Item { Layout.fillWidth: true }

        // Center: Clock
        Clock {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        // Spacer to push SystemTray to right
        Item { Layout.fillWidth: true }

        // Right: SystemTray
        SystemTray {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: 10
            parentWindow: root
            parentScreen: root.screen
        }
    }
}
