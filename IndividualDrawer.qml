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

    Frame {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 30
        padding: 8
        z: 100

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
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 250
        anchors.topMargin: 150
        z:100

        text: "G" + "\nI"
        color: "yellow"
        font.pixelSize: 30
        font.underline: true
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 300
        anchors.topMargin: 150
        z:100

        text: currentGeneration + "\n" + currentIndividual
        color: "white"
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
    }

    Rectangle {
        id: cell

        width: 150
        visible : true
        height: width
        radius: 0.5 * width
        anchors.top: parent.top
        anchors.topMargin: 120
        anchors.left: parent.left
        anchors.leftMargin: 50
        color: populationModel.getColor(currentGeneration, currentIndividual, 0)

        property bool isNew: populationModel.getNew(currentGeneration, currentIndividual)
        property bool isMutated: populationModel.getMutation(currentGeneration, currentIndividual)
        property bool isCrossing: populationModel.getCrossing(currentGeneration, currentIndividual)

        Rectangle {
            id: newRectangle
            visible: cell.isNew
            anchors.centerIn: parent
            width: parent.width * 0.2
            height: width
            radius: width
            color: "black"
        }

        Rectangle {
            id: mutationRectangle
            visible: cell.isMutated
            x: width/2 * (1/Math.sqrt(2) + 0.5)
            y: -x
            width: parent.width
            height: width
            rotation: 45
            color: "black"
        }

        Rectangle {
            id: crossingOverRectangle
            visible: cell.isCrossing
            x: width/2 * (1/Math.sqrt(2) + 0.5)
            y: x
            width: parent.width
            height: width
            rotation: 45
            color: "black"
        }

    }


    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 300

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
