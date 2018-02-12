import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Drawer {
    id: populationInfoDrawer

    property double globalPerformance: 0
    property int nbIndividuals: 0
    property int nbMutations: 0
    property int nbCrossovers: 0
    property int nbClusters: 0

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
            Layout.bottomMargin: 20
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

        DrawerInfo {
            infoTitle: "Global Performance"
            value: globalPerformance
        }

        DrawerInfo {
            infoTitle: "Total no. individuals"
            value: nbIndividuals
        }

        DrawerInfo {
            infoTitle: "Total no. mutations"
            value: nbMutations
        }

        DrawerInfo {
            infoTitle: "Total no. crossovers"
            value: nbCrossovers
        }

        DrawerInfo {
            infoTitle: "Total no. clusters"
            value: nbClusters
        }

        Item { Layout.fillHeight: true }
    }
}
