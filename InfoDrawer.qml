import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Drawer {
    id: infoDrawer

    edge: Qt.RightEdge
    width: 400
    height: parent.height - vizPage.header.height
    y: vizPage.header.height
    interactive: true
    modal: false

    property string drawerTitle: "DETAILS"
    property alias drawerContent: drawerContent

    Rectangle {
        width: 1
        height: parent.height
        x: parent.x - 2
        color: "grey"
    }

    background: Rectangle {
        anchors.fill: parent
        color: "black"
        border.color: "black"
    }

    ColumnLayout {
        id: drawerContent

        anchors.fill: parent

        Label {
            Layout.fillWidth: true

            text: drawerTitle
            color: "white"
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
