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

        Item {
            Layout.fillWidth: true
        }

        Clock {
            Layout.alignment: Qt.AlignCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight

            SystemTray {
                parentWindow: root
                parentScreen: root.screen
            }

            WorkspacesIndicator {
            }
        }
    }
}