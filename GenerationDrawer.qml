import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

/**
  * \brief QML instance : GenerationDrawer
  * The drawer corresponding to the generation view
  */
Drawer {
    id: generationDrawer /** generationDrawer : the id of the drawer in the hierarchy */

    property int currentGeneration: 0 /** currentGeneration : the current generation selected in the view */
    property double globalPerformance: 0 /** globalPerformance : the mean score of the generation */
    property int nbIndividuals: 0 /** nbIndividuals : the number of individuals inside the generation */
    property int nbMutations: 0 /** nbMutations : the number of mutations inside the generation */
    property int nbCrossovers: 0 /** nbCrossovers : the number of crossing over inside the generation */
    property int nbClusters: 0 /** nbClusters : the number of clusters inside the generation*/

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
            Layout.bottomMargin: 20

            text: currentGeneration == -1 ? "NO GENERATION SELECTED" : "GENERATION " + currentGeneration
            color: "white"
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
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
