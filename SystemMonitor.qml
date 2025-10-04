import QtQuick
import QtQuick.Layouts
import Quickshell.Core

RowLayout {
    id: root
    spacing: 10

    property real cpuUsage: 0
    property real cpuTemp: 0
    property real gpuUsage: 0
    property real gpuTemp: 0
    property real ramUsage: 0

    // Note: The following commands are specific to certain system configurations.
    // You may need to adjust them for your hardware and OS setup.
    // For example, `nvidia-smi` is for NVIDIA GPUs, and the path for CPU temperature
    // might differ between systems.

    Timer {
        id: refreshTimer
        interval: 2000 // 2 seconds
        running: true
        repeat: true
        onTriggered: {
            cpuUsageProcess.start()
            cpuTempProcess.start()
            gpuUsageProcess.start()
            gpuTempProcess.start()
            ramUsageProcess.start()
        }
    }

    Component.onCompleted: {
        // Trigger once immediately on startup
        refreshTimer.triggered()
    }

    Text {
        text: `CPU: ${Math.round(cpuUsage)}% ${Math.round(cpuTemp)}°C`
        color: "white"
        font.pixelSize: 14
    }
    Text {
        text: `GPU: ${Math.round(gpuUsage)}% ${Math.round(gpuTemp)}°C`
        color: "white"
        font.pixelSize: 14
    }
    Text {
        text: `RAM: ${Math.round(ramUsage)}%`
        color: "white"
        font.pixelSize: 14
    }

    Process {
        id: cpuUsageProcess
        command: "sh -c \"top -bn1 | grep '%Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'\""
        onFinished: (exitCode, exitStatus) => {
            if (exitStatus === Process.NormalExit && exitCode === 0) {
                const output = readAllStandardOutput().trim()
                if (output) {
                    root.cpuUsage = parseFloat(output)
                }
            }
        }
    }

    Process {
        id: cpuTempProcess
        command: "sh -c \"cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo 0\""
        onFinished: (exitCode, exitStatus) => {
            if (exitStatus === Process.NormalExit && exitCode === 0) {
                const output = readAllStandardOutput().trim()
                if (output) {
                    root.cpuTemp = parseFloat(output) / 1000
                }
            }
        }
    }

    Process {
        id: gpuUsageProcess
        command: "sh -c \"nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo 0\""
        onFinished: (exitCode, exitStatus) => {
            if (exitStatus === Process.NormalExit && exitCode === 0) {
                const output = readAllStandardOutput().trim()
                if (output) {
                    root.gpuUsage = parseFloat(output)
                }
            }
        }
    }

    Process {
        id: gpuTempProcess
        command: "sh -c \"nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null || echo 0\""
        onFinished: (exitCode, exitStatus) => {
            if (exitStatus === Process.NormalExit && exitCode === 0) {
                const output = readAllStandardOutput().trim()
                if (output) {
                    root.gpuTemp = parseFloat(output)
                }
            }
        }
    }

    Process {
        id: ramUsageProcess
        command: "sh -c \"free | grep Mem | awk '{print $3/$2 * 100.0}'\""
        onFinished: (exitCode, exitStatus) => {
            if (exitStatus === Process.NormalExit && exitCode === 0) {
                const output = readAllStandardOutput().trim()
                if (output) {
                    root.ramUsage = parseFloat(output)
                }
            }
        }
    }
}