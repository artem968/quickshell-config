// WorkspaceIndicator.qml
import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland

Rectangle {
    id: root
    color: "transparent"
    height: 30
    width: workspaceRow.implicitWidth + 20

    property int currentWorkspace: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
    property var workspaceList: {
        var workspaces = (Hyprland.workspaces ? Hyprland.workspaces.values : []).filter(w => w.id !== -98)
        if (workspaces.length === 0) {
            return [{id: 1, name: "1"}]
        }
        return workspaces.slice().sort((a, b) => a.id - b.id)
    }

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 6

        Repeater {
            model: root.workspaceList

            Rectangle {
                width: modelData.id === root.currentWorkspace ? 32 : 16
                height: 12
                radius: 8
                color: modelData.id === root.currentWorkspace ? "white" : "#444444"  // active = white, inactive = dark grey

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        Hyprland.dispatch(`workspace ${modelData.id}`)
                    }
                }

                Behavior on width {
                    NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                }
            }
        }
    }

    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() {
            var workspaces = (Hyprland.workspaces ? Hyprland.workspaces.values : []).filter(w => w.id !== -98)
            if (workspaces.length === 0) {
                root.workspaceList = [{id: 1, name: "1"}]
            } else {
                root.workspaceList = workspaces.slice().sort((a, b) => a.id - b.id)
            }
        }
    }
}