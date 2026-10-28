import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Wayland
import QtMultimedia
ShellRoot{
    PanelWindow{
        WlrLayershell.layer: WlrLayer.Bottom
        property var height : 200
        property var width: 200
        implicitHeight: height
        implicitWidth: width
        color: "transparent"
        anchors.right: true
        anchors.bottom: true
        margins.right: 50
        margins.bottom: 50
        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: parent.height
            color: "transparent"
            Video{
                source:"file:/home/bigbossdev/Downloads/images/tal5mc01oahh1_small.mp4"
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectFit 
                autoPlay: true
                loops: MediaPlayer.Infinite
                muted: true
    
        
                
            }
        }
    }
}