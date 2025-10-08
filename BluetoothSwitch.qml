import QtQuick
import Quickshell.Core

Item {
    id: root
    width: 200
    height: 50

    property bool isBluetoothEnabled: false

    Process {
        id: bluetoothStatusProcess
        command: "bluetoothctl show | grep 'Powered:'"
        onFinished: {
            var output = readAllStandardOutput().trim();
            root.isBluetoothEnabled = output.endsWith("yes");
        }
    }

    Process {
        id: bluetoothToggleProcess
        onFinished: {
            // After toggling, refresh the status to get the true state
            bluetoothStatusProcess.start();
        }
    }

    Component.onCompleted: {
        bluetoothStatusProcess.start();
    }

    Text {
        id: label
        text: "Bluetooth"
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
        color: root.isBluetoothEnabled ? "#4CAF50" : "#BDBDBD"

        Rectangle {
            id: switchHandle
            width: 28
            height: 28
            radius: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: root.isBluetoothEnabled ? parent.left : undefined
            anchors.right: root.isBluetoothEnabled ? undefined : parent.right
            anchors.leftMargin: root.isBluetoothEnabled ? 1 : 0
            anchors.rightMargin: root.isBluetoothEnabled ? 0 : 1
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var command_str = "bluetoothctl power " + (root.isBluetoothEnabled ? "off" : "on");
                bluetoothToggleProcess.command = command_str;
                bluetoothToggleProcess.start();
            }
        }
    }
}