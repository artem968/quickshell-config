import QtQuick
import Quickshell.Core

Item {
    id: root
    width: 200
    height: 50

    property bool isWifiEnabled: false

    Process {
        id: wifiStatusProcess
        command: "nmcli radio wifi"
        onFinished: {
            var output = readAllStandardOutput().trim();
            root.isWifiEnabled = (output === "enabled");
        }
    }

    Process {
        id: wifiToggleProcess
        onFinished: {
            // After toggling, refresh the status to get the true state
            wifiStatusProcess.start();
        }
    }

    Component.onCompleted: {
        wifiStatusProcess.start();
    }

    Text {
        id: label
        text: "Wi-Fi"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 16
        color: "white"
    }

    Rectangle {
        id: switchFrame
        width: 60
        height: 30
        radius: 15
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        color: root.isWifiEnabled ? "#4CAF50" : "#BDBDBD"

        Rectangle {
            id: switchHandle
            width: 28
            height: 28
            radius: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: root.isWifiEnabled ? parent.left : undefined
            anchors.right: root.isWifiEnabled ? undefined : parent.right
            anchors.leftMargin: root.isWifiEnabled ? 1 : 0
            anchors.rightMargin: root.isWifiEnabled ? 0 : 1
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var command_str = "nmcli radio wifi " + (root.isWifiEnabled ? "off" : "on");
                wifiToggleProcess.command = command_str;
                wifiToggleProcess.start();
            }
        }
    }
}