import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 10

    // The dock will resize based on its content
    width: iconRow.implicitWidth + 20
    height: 60

    color: "#222222CC" // Dark, semi-transparent background
    radius: 15

    // These properties make the window float on top of other windows
    WlrLayershell.layer: Layer.Overlay
    exclusionMode: ExclusionMode.Ignore

    RowLayout {
        id: iconRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        Repeater {
            model: {
                let openApps = Hyprland.clients ? Hyprland.clients.values.map(client => client.class) : [];
                let pinnedApps = ["firefox", "kitty"];
                let allApps = [...new Set([...pinnedApps, ...openApps])];
                return allApps;
            }

            delegate: DockIcon {
                appName: modelData
                isActive: Hyprland.activeClient && Hyprland.activeClient.class === modelData
            }
        }
    }
}