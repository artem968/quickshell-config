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

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        WorkspacesIndicator {
            id: workspaces
        }

        Item {
            Layout.fillWidth: true
        }

        Clock {
            id: clock
            Layout.alignment: Qt.AlignCenter
        }

        Item {
            Layout.fillWidth: true
        }
    }
}