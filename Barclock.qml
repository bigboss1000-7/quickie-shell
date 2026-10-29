import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Services.Mpris

ShellRoot {
    PanelWindow {
        WlrLayershell.layer: WlrLayer.Top
        anchors.top: true
        implicitWidth: 500
        implicitHeight: 500
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        // only the pill receives mouse input, the rest is click-through
        mask: Region { item: pill }

        SystemClock {
            id: sysClock
            precision: SystemClock.Seconds
        }

        Rectangle {
            id: pill
            HoverHandler { id: hover }
            property bool expanded: hover.hovered
  
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#2b2733"
            radius: 18
            clip: true

            width: expanded ? 350 : 150
            height: expanded ? 140 : 40

            Behavior on width { NumberAnimation { duration: 450; easing.type: Easing.OutBack } }
            Behavior on height { NumberAnimation { duration: 450; easing.type: Easing.OutBack } }
            MouseArea{
                anchors.fill: pill
                onClicked:{ parent.height = 350; parent.width = 400}
            }


            // flat top: covers the rounded top corners
            Rectangle {
                width: parent.width
                height: parent.radius
                color: parent.color
            }

            // clock, pinned to the top
            Text {
                id: clock
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: Qt.formatDateTime(sysClock.date, "HH:mm:ss")
                font.pixelSize: 18
                opacity: pill.expanded ? 0 : 1
                Behavior on opacity { NumberAnimation { duration: 450; easing.type: Easing.OutQuint } }
            }

            Text {
                anchors.top: parent.top
                anchors.topMargin: 7
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                text: Qt.formatDateTime(sysClock.date, "dddd, MMMM d | HH:mm:ss")
                font.pixelSize: 18
                opacity: pill.expanded ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 450; easing.type: Easing.OutBack } }
            }

            // media controls, fade in when expanded
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 45
                spacing: 6
                opacity: pill.expanded ? 1 : 0
                Behavior on opacity { NumberAnimation { duration: 1000; easing.type: Easing.OutQuint } }

                
            }
        }
    }
}
