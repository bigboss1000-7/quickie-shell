import Quickshell
import QtQuick
import Quickshell.Wayland

PanelWindow {
    WlrLayershell.layer: WlrLayer.Background
    exclusionMode: ExclusionMode.Ignore
    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"

    Image {
        anchors.fill: parent
        source: "/home/bigbossdev/Pictures/Wallpapers/748657.jpg"
        fillMode: Image.PreserveAspectCrop
    }
}