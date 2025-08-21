import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

ShellRoot {
    FloatingWindow {
        id: audioWindow

        // width: audio.implicitWidth
        implicitWidth: 600
        implicitHeight: 400
        // height: audio.implicitHeight
        title: "Quickshell Audio Menu"

        visible: true

        flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint

        AudioMenu {
            id: audio
        }
    }

    GlobalShortcut {
        appid: "quickshell_audio_menu"
        name: "audio_menu_toggle"

        onPressed: {
            audioWindow.visible = !audioWindow.visible;
        }
    }
}
