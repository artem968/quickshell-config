// SystemTrayWidget.qml
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Rectangle {
    id: root

    // Optional overrides; will fallback to actual window/screen
    property var parentWindow: null
    property var parentScreen: null

    property real widgetHeight: 24
    property real iconSize: 16
    property real padding: 4
    property real cornerRadius: 4
    property color hoverColor: "#333333"
    property color backgroundColor: "transparent"

    readonly property int calculatedWidth:
        SystemTray.items.values.length > 0
        ? SystemTray.items.values.length * (iconSize + padding) + padding * 2
        : 0

    width: calculatedWidth
    height: widgetHeight
    radius: cornerRadius
    color: SystemTray.items.values.length > 0 ? backgroundColor : "transparent"
    visible: SystemTray.items.values.length > 0

    // Detect window/screen once the component is attached
    Component.onCompleted: {
        if (!parentWindow) parentWindow = root.window
        if (!parentScreen && root.window) parentScreen = root.window.screen
    }

    Row {
        id: systemTrayRow
        anchors.centerIn: parent
        spacing: padding

        Repeater {
            model: SystemTray.items.values

            delegate: Item {
                property var trayItem: modelData
                width: iconSize + padding
                height: iconSize + padding

                Rectangle {
                    anchors.fill: parent
                    radius: cornerRadius
                    color: trayItemArea.containsMouse ? hoverColor : "transparent"
                }

                IconImage {
                    anchors.centerIn: parent
                    width: iconSize
                    height: iconSize
                    source: trayItem && trayItem.icon ? trayItem.icon : ""
                    asynchronous: true
                    smooth: true
                    mipmap: true
                }

                MouseArea {
                    id: trayItemArea
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: (mouse) => {
                        if (!trayItem) return

                        if (mouse.button === Qt.LeftButton && !trayItem.onlyMenu) {
                            trayItem.activate()
                        } else if (trayItem.hasMenu) {
                            const menu = trayItem.menu
                            // ✅ guard both menu and parentWindow
                            if (menu && parentWindow) {
                                const globalPos = mapToGlobal(0, 0)
                                const screenX = parentScreen ? parentScreen.x : 0
                                const relativeX = globalPos.x - screenX

                                menuAnchor.menu = menu
                                menuAnchor.anchor.window = parentWindow
                                menuAnchor.anchor.rect = Qt.rect(relativeX, root.height, parent.width, 1)
                                menuAnchor.open()
                            }
                        }
                    }
                }
            }
        }
    }

    QsMenuAnchor {
        id: menuAnchor
    }
}