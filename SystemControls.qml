import QtQuick
import Quickshell

Item {
    id: root
    width: 48
    height: 24

    property var parentWindow: null
    property var parentScreen: null

    property var controlCenterMenu: null

    Component.onCompleted: {
        if (!parentWindow) parentWindow = root.window
        if (!parentScreen && root.window) parentScreen = root.window.screen
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                if (controlCenterMenu === null) {
                    var component = Qt.createComponent("ControlCenterMenu.qml");
                    if (component.status === Component.Ready) {
                        controlCenterMenu = component.createObject(parentWindow, { "parentWindow": root.parentWindow, "visible": false });
                    } else {
                        console.error("Error loading ControlCenterMenu.qml:", component.errorString());
                        return;
                    }
                }

                if (controlCenterMenu) {
                    var globalPos = mapToGlobal(0, 0);
                    var screenX = parentScreen ? parentScreen.x : 0;
                    var relativeX = globalPos.x - screenX;

                    // Position the menu below the control icon
                    controlCenterMenu.open(relativeX, root.height + 5);
                }
            }
        }
    }

    // Icon for the controls
    Text {
        id: icon
        text: "\uf013" // Gear icon from Font Awesome
        font.family: "Font Awesome 6 Free"
        font.pixelSize: 20
        color: "white"
        anchors.centerIn: parent
    }
}