import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Wayland
import QtQuick.Effects



PanelWindow{

    SystemClock {
        id: sysClock
        precision: SystemClock.Seconds
    }

    property var number: 370
    WlrLayershell.layer: WlrLayer.Bottom
    implicitHeight: 250
    implicitWidth: number
    color: "transparent"
    anchors.top: true
    anchors.left: true
    margins.top : 40
    margins.left : 30
    
    Rectangle{
        id: clock_space
        anchors.horizontalCenter: parent.horizontalCenter
        width: 370
        height: 200
    MouseArea {
        id:hoverArea
        anchors.fill: clock_space
        hoverEnabled: true
    }

        
    Image {
        id: cool_anime_photo
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "/home/bigbossdev/Pictures/Wallpapers/lsa.png"
        opacity: 0
}
    Item {
        id: photoMask
        anchors.fill: parent
        visible: false
        layer.enabled: true
        Rectangle { anchors.fill: parent; radius: clock_space.radius }
    }

    MultiEffect {
        source: cool_anime_photo
        anchors.fill: cool_anime_photo
        opacity: hoverArea.containsMouse ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 400;easing.type: Easing.InOutQuart}}
        blurEnabled: true
        blur: 0.5
        autoPaddingEnabled: false   //
        maskEnabled: true        // NEW
        maskSource: photoMask    // NEW
    }

        radius: 18
        color: '#2b2733'
        
        Text {
            id: clock
            anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: Qt.formatDateTime(sysClock.date, "HH:mm")
            font.pixelSize: 130            
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
        }


}
