import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Services.Mpris

PanelWindow {
    WlrLayershell.layer: WlrLayer.Top
    anchors.top: true
    implicitWidth: 500
    implicitHeight: 200
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

        property bool expanded: hover.hovered
        property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#2b2733"
        radius: 18
        clip: true

        width: expanded ? 400 : 200
        height: expanded ? 140 : 32

        Behavior on width  { NumberAnimation { duration: 450; easing.type: Easing.OutQuint } }
        Behavior on height { NumberAnimation { duration: 450; easing.type: Easing.OutQuint } }

        HoverHandler { id: hover }

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
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: Qt.formatDateTime(sysClock.date, "HH:mm:ss")
            opacity: pill.expanded ? 0 : 1
            Behavior on opacity { NumberAnimation { duration: 450; easing.type: Easing.OutQuint } }
}
Text {
    anchors.top: parent.top
    anchors.topMargin: 7
    anchors.horizontalCenter: parent.horizontalCenter
    color: "white"
    text: Qt.formatDateTime(sysClock.date, "dddd, MMMM d | HH:mm:ss")
    opacity: pill.expanded ? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 450; easing.type: Easing.OutQuint } }
}
        // media controls, fade in when expanded
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 45
            spacing: 6
            opacity: pill.expanded ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 1000; easing.type: Easing.OutQuint } }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: pill.player ? pill.player.trackTitle : "Nothing playing"
                color: "white"
                font.bold: true
                elide: Text.ElideRight
                width: Math.min(implicitWidth, 360)
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: pill.player ? pill.player.trackArtist : ""
                color: "#aaaaaa"
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Text {
                    text: "⏮"
                    color: "white"
                    font.pixelSize: 20
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (pill.player) pill.player.previous()
                    }
                }
                Text {
                    text: pill.player && pill.player.isPlaying ? "⏸" : "▶"
                    color: "white"
                    font.pixelSize: 20
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (pill.player) pill.player.togglePlaying()
                    }
                }
                Text {
                    text: "⏭"
                    color: "white"
                    font.pixelSize: 20
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (pill.player) pill.player.next()
                    }
                }
            }
        }
    }
}