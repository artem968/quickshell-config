import QtQuick
import QtQuick.Layouts
import Quickshell.SystemInfo

RowLayout {
    id: root
    spacing: 10

    property real cpuUsage: SystemInfo.cpu.usage
    property real cpuTemp: SystemInfo.cpu.temperature
    property real gpuUsage: SystemInfo.gpu.usage
    property real gpuTemp: SystemInfo.gpu.temperature
    property real ramUsage: SystemInfo.memory.usage

    Timer {
        interval: 1000 // 1 second
        running: true
        repeat: true
        onTriggered: {
            root.cpuUsage = SystemInfo.cpu.usage
            root.cpuTemp = SystemInfo.cpu.temperature
            root.gpuUsage = SystemInfo.gpu.usage
            root.gpuTemp = SystemInfo.gpu.temperature
            root.ramUsage = SystemInfo.memory.usage
        }
    }

    Text {
        text: `CPU: ${Math.round(root.cpuUsage * 100)}% ${Math.round(root.cpuTemp)}°C`
        color: "white"
        font.pixelSize: 14
    }
    Text {
        text: `GPU: ${Math.round(root.gpuUsage * 100)}% ${Math.round(root.gpuTemp)}°C`
        color: "white"
        font.pixelSize: 14
    }
    Text {
        text: `RAM: ${Math.round(root.ramUsage * 100)}%`
        color: "white"
        font.pixelSize: 14
    }
}