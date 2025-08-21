import Quickshell // for PanelWindow
import Quickshell.Io // for process
import QtQuick // for Text

Variants {
    model: Quickshell.screens

    delegate: Component {
        PanelWindow {
            // the screen from the screens list will be injected into this property
            property var modelData // aka receive the model information (the screen data)

            // set the window's screen to the injected property
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30

            Text {
                // give text an id so we can refer to it
                id: clock

                // center the bar in its parent component (the window)
                anchors.centerIn: parent

                // create a process
                Process {
                    id: dateProc
                    //command it will run
                    command: ["date"]

                    // run immediately
                    running: true

                    // tldr on launch, run the date process, then collect the stdout information and display it as our text

                    // process stdout using StdioCollector
                    stdout: StdioCollector {
                        onStreamFinished: clock.text = this.text // this is optional
                    }
                }
            }

            // add a timer object to rerun the process at an interval
            Timer {
                interval: 1000 // every 1 sec
                running: true // start immediately
                repeat: true // run on loop

                onTriggered: dateProc.running = true // when trigged, set the process to running (aka tell it to run)
            }
        }
    }
}
