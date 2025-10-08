import QtQuick
import Quickshell
import QtQuick.Layouts

PanelWindow {
    id: root

    // Anchoring for a floating, centered bar
    anchors.top: parent.top
    anchors.topMargin: 8
    anchors.horizontalCenter: parent.horizontalCenter

    implicitWidth: 600
    implicitHeight: 48

    // Styling for the Android-like appearance
    color: "#222222"
    radius: 24

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 16

        // Left: WorkspacesIndicator
        WorkspacesIndicator {
            Layout.alignment: Qt.AlignVCenter
        }

        // Spacer
        Item { Layout.fillWidth: true }

        // Center: Clock
        Clock {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        // Spacer
        Item { Layout.fillWidth: true }

        // Right: SystemTray and new SystemControls
        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            spacing: 10

            SystemTray {
                id: systemTray
                parentWindow: root
                parentScreen: root.screen
            }

            SystemControls {
                id: systemControls
                parentWindow: root
                parentScreen: root.screen
            }
        }
    }
}