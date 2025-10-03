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

    WorkspacesIndicator {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

        // Spacer to push Clock to center
        Item { Layout.fillWidth: true }

    SystemTray {
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        parentWindow: root
        parentScreen: root.screen
    }
}
