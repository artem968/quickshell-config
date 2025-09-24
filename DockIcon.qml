import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    id: root
    width: 48
    height: 48

    property string appName: ""
    property bool isActive: false

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Image {
            id: iconImage
            anchors.fill: parent
            source: Theme.lookupIcon(appName)
            fillMode: Image.PreserveAspectFit
        }

        // Placeholder for when an icon is not found
        Text {
            visible: iconImage.status !== Image.Ready
            anchors.centerIn: parent
            text: appName.length > 0 ? appName.substring(0, 1).toUpperCase() : "?"
            color: "white"
            font.pixelSize: 24
        }
    }

    // Indicator for active (focused) window
    Rectangle {
        width: 6
        height: 6
        radius: 3
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -8
        visible: isActive
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            let client = Hyprland.clients ? Hyprland.clients.values.find(c => c.class === root.appName) : null;
            if (client) {
                Hyprland.dispatch(`focuswindow address:${client.address}`);
            } else {
                Hyprland.dispatch(`exec ${root.appName}`);
            }
        }
    }
}