import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Services.Mpris

ShellRoot {
    PanelWindow {
        id: media
        property int playerIndex: 0
        property var player: Mpris.players.values[Math.min(playerIndex, Mpris.players.values.length - 1)]

        WlrLayershell.layer: WlrLayer.Bottom
        anchors.bottom: true
        anchors.right: true
        margins.bottom: 10
        margins.right: 10
        implicitHeight: 90
        implicitWidth: 350
        color: "transparent"

        Rectangle {
            id: mediabox
            anchors.fill: parent
            color: "#2b2733"
            radius: 20
            opacity: 0.9

            // keeps position fresh while playing
            Timer {
                running: media.player?.isPlaying ?? false
                interval: 500
                repeat: true
                onTriggered: media.player?.positionChanged()
            }

            // album art
            Image {
                id: artbox
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                width: 70; height: 70
                fillMode: Image.PreserveAspectCrop
                source: media.player?.trackArtUrl ?? ""
                visible: false
            }

            Rectangle {
                id: artmask
                width: 70; height: 70
                radius: 12
                layer.enabled: true
                visible: false
            }

            MultiEffect {
                anchors.fill: artbox
                source: artbox
                maskEnabled: true
                maskSource: artmask
            }

            // title
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.top: parent.top
                anchors.topMargin: 12
                font.pixelSize: 17
                color: "white"
                elide: Text.ElideRight
                text: media.player?.trackTitle ?? "nothing is playing"
            }

            // switch player
            Text {
                text: "⇄"
                color: "white"
                font.pixelSize: 20
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 8
                MouseArea {
                    anchors.fill: parent
                    onClicked: media.playerIndex = (media.playerIndex + 1) % Math.max(1, Mpris.players.values.length)
                }
            }

            // buttons
            Row {
                anchors.left: parent.left
                anchors.leftMargin: 100
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 18
                spacing: 19

                Text {
                    text: "⏮"; color: "white"; font.pixelSize: 22
                    MouseArea { anchors.fill: parent; onClicked: media.player?.previous() }
                }
                Text {
                    text: media.player?.isPlaying ? "⏸" : "▶"; color: "white"; font.pixelSize: 22
                    MouseArea { anchors.fill: parent; onClicked: media.player?.togglePlaying() }
                }
                Text {
                    text: "⏭"; color: "white"; font.pixelSize: 22
                    MouseArea { anchors.fill: parent; onClicked: media.player?.next() }
                }
            }

            // progress bar (by claude :) )
            Rectangle {
                id: bar
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 100
                anchors.rightMargin: 15
                anchors.bottomMargin: 10
                height: 8
                radius: 4
                color: "#4a4458"

                Rectangle {
                    width: media.player && media.player.length > 0
                        ? parent.width * Math.min(1, media.player.position / media.player.length)
                        : 0
                    height: parent.height
                    radius: 4
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.topMargin: -6
                    anchors.bottomMargin: -6
                    onClicked: mouse => {
                        if (media.player?.canSeek && media.player.length > 0)
                            media.player.position = (mouse.x / width) * media.player.length
                    }
                }
            }
        }
    }
}