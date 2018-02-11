import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Drawer {
    id: individualDrawer

    property int currentGeneration: 0
    property int currentIndividual: 0
    property int lifetime: 0
    property int performance: 0
    property int nbMutations: 0
    property int nbCrossovers: 0
    property int cluster: 0

    edge: Qt.RightEdge
    width: 400
    height: parent.height - vizPage.header.height
    y: vizPage.header.height
    interactive: true
    modal: false

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
        anchors.fill: parent

        Frame {
            Layout.leftMargin: 20
            Layout.topMargin: 30
            padding: 8

            background: Rectangle {
                anchors.fill: parent
                color: "black"
                border.color: "white"
            }

            Label {
                text: "DETAILS"
                color: "white"
                font.pixelSize: 30
            }
        }

        Label {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.topMargin: 30

            text: "GENERATION " + currentGeneration + "\nINDIVIDUAL " + currentIndividual
            color: "white"
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        DrawerInfo {
            infoTitle: "Lifetime"
            value: lifetime
        }

        DrawerInfo {
            infoTitle: "Performance"
            value: performance
        }

        DrawerInfo {
            infoTitle: "Mutations"
            value: nbMutations
        }

        DrawerInfo {
            infoTitle: "Crossovers"
            value: nbCrossovers
        }

        DrawerInfo {
            infoTitle: "Cluster"
            value: cluster
        }

        Item { Layout.fillHeight: true }
    }
}
