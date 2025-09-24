import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Layouts

RowLayout {
    id: root
    spacing: 8

    Repeater {
        model: SystemTray.items

        delegate: Item {
            width: 24
            height: 24

            Image {
                anchors.fill: parent
                source: modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            QsMenu {
                id: contextMenu
                handle: modelData.menu
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton) {
                        contextMenu.open()
                    } else {
                        modelData.activate()
                    }
                }
            }
        }
    }
}