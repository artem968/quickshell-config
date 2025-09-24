import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    id: root
    spacing: 8

    Repeater {
        model: Hyprland.workspaces
        delegate: Text {
            text: modelData.id.toString()
            color: modelData.id === Hyprland.focusedWorkspace.id ? "white" : "gray"
            font.pixelSize: 14

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Hyprland.dispatch("workspace " + modelData.id)
                }
            }
        }
    }
}