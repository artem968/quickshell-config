import QtQuick
import QtQuick.Layouts

FocusScope {
    id: root
    width: 250
    height: 150
    visible: false
    property var parentWindow: null

    // This MouseArea covers the entire window to detect outside clicks
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: root.close()
    }

    Rectangle {
        id: menuContent
        width: 250
        height: 150
        color: "#2E2E2E"
        radius: 12

        // This MouseArea prevents clicks inside the menu from closing it
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            WifiSwitch {
                id: wifiSwitch
                Layout.fillWidth: true
                Layout.preferredHeight: 50
            }

            BluetoothSwitch {
                id: bluetoothSwitch
                Layout.fillWidth: true
                Layout.preferredHeight: 50
            }
        }
    }

    function open(x, y) {
        if (parentWindow) {
            menuContent.x = x
            menuContent.y = y
            root.visible = true;
            root.forceActiveFocus();
        }
    }

    function close() {
        root.visible = false;
    }
}