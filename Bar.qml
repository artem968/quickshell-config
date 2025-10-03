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

        // WorkspacesIndicator on the far left with margin
        WorkspacesIndicator {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 6
            Layout.maximumWidth: root.width / 3
        }

        // Spacer to push Clock to center
        Item { Layout.fillWidth: true }

        // Clock in the middle
        Clock {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        // Spacer to push SystemTray to the far right
        Item { Layout.fillWidth: true }

        // SystemTray on the far right with margin
        SystemTray {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: 6
        }
    }
}
