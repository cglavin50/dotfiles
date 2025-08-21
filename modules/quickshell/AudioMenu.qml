import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Quickshell

Item {
    id: root
    focus: true

    implicitWidth: root.calculatedWidth > 0 ? root.calculatedWidth : 600
    implicitHeight: root.calculatedHeight > 0 ? root.calculatedHeight : 400

    width: implicitWidth
    height: implicitHeight

    Material.theme: Material.Dark
    Material.accent: Material.Green

    // system palette for automatic color detection?
    SystemPalette {
        id: systemPalette
        colorGroup: SystemPalette.Active
    }

    Keys.onEscapePressed: {
        audioWindow.visible = false;
    }

    property string title: "Audio Menu"

    // main content
    Rectangle {
        anchors.fill: parent
        color: Material.backgroundColor

        Text {
            text: root.title
            color: Material.foreground
            font.bold: true
            font.pixelSize: 24
            padding: 10
        }
    }
}
