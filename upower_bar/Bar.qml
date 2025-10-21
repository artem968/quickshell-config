// upower_bar/Bar.qml
import Quickshell
import QtQuick

Scope {
    Quickshell.Core.Process {
        id: upowerProcess
        command: "upower -i /org/freedesktop/UPower/devices/battery_BAT0"

        function reload() {
            start()
        }

        onFinished: {
            var output = readAllStandardOutput();
            var lines = output.split('\n');
            for (var i = 0; i < lines.length; i++) {
                if (lines[i].trim().startsWith("time to empty:")) {
                    timeToEmptyText.text = lines[i].trim();
                    break;
                }
            }
        }
    }

    Timer {
        interval: 30000 // 30 seconds
        running: true
        repeat: true
        onTriggered: upowerProcess.reload()
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                color: "black"
            }

            implicitHeight: 30

            Text {
                id: timeToEmptyText
                color: "white"
                font.pixelSize: 14
                anchors.centerIn: parent
                text: "Loading..."
            }
        }
    }

    Component.onCompleted: {
        upowerProcess.reload()
    }
}
