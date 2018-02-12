import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

/**
  * \brief QML instance : individualDrawer
  * Create the drawer for the individualView
  */
Drawer {
    id: individualDrawer

    property int currentGeneration: 0 /** currentGeneration : the current generation of the selected individual*/
    property int currentIndividual: 0 /** currentIndividual : the current individual inside the generation*/
    property int lifetime: 0 /** lifetime : the lifetime of the individual. TODO implement lifetime*/
    property double performance: 0 /** performance : the global performance of the individual */
    property int nbMutations: 0 /** nbMutations : the number of mutations of the individuam */
    property int nbCrossovers: 0 /** nbCrossovers : the number of crossing over of the individual */
    property int cluster: 0 /** cluster : the cluster in which the individual is*/

    edge: Qt.RightEdge
    width: 400
    height: parent.height - vizPage.header.height
    y: vizPage.header.height
    interactive: true
    modal: false

<<<<<<< HEAD
    background: Rectangle {
        anchors.fill: parent
        color: "black"
        border.color: "black"
=======
    //Draw the individual like in any other view
    Rectangle{
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 400
        width: 100
        height: 90
        z:100
        color: "white"

        Label {
            anchors.centerIn: parent
            id:textNumberCluster
            text: cluster
            color: "black"
            font.pixelSize: 20
        }


        Canvas{
            id: clusterDrawer
            width: parent.width
            height: parent.height
            onPaint: {
                var ctx = getContext("2d");
                ctx.fillStyle = "black";
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(width/4, 0);
                ctx.lineTo(0, height/2);

                ctx.moveTo(width, 0);
                ctx.lineTo(3*width/4, 0);
                ctx.lineTo(width, height/2);

                ctx.moveTo(width, height);
                ctx.lineTo(3*width/4, height);
                ctx.lineTo(width, height/2);

                ctx.moveTo(0, height);
                ctx.lineTo(width/4, height);
                ctx.lineTo(0, height/2);
                ctx.fill();
            }
        }
>>>>>>> 6a7be71ca35c3ebc883dbe466b7d892b0ceb4027
    }

    Rectangle {
        width: 1
        height: parent.height
        x: parent.x - 2
        color: "grey"
    }

    Flickable {
        anchors.fill: parent
        contentHeight: infos.implicitHeight

        clip:true

        ColumnLayout {
            id: infos
            anchors.fill: parent

            spacing: 15

<<<<<<< HEAD
            Frame {
                Layout.topMargin: 15
                Layout.leftMargin: 20
=======
    //We print all the details of the individual
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
>>>>>>> 6a7be71ca35c3ebc883dbe466b7d892b0ceb4027

                padding: 8
                z: 5

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

            RowLayout {
                Layout.fillWidth: true
                Layout.minimumHeight: 100

                Layout.topMargin: 10
                Layout.bottomMargin: 10

                Rectangle {
                    id: cell

                    width: 150
                    visible : true
                    height: width
                    radius: 0.5 * width
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    color: populationModel.getColor(currentGeneration, currentIndividual, 0,0,0)

                    property bool isNew: populationModel.getNew(currentGeneration, currentIndividual)
                    property bool isMutated: populationModel.getMutation(currentGeneration, currentIndividual)
                    property bool isCrossing: populationModel.getCrossing(currentGeneration, currentIndividual)

                    Rectangle {
                        id: newRectangle
                        visible: cell.isNew || currentGeneration == 0
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

                Label {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 250
                    anchors.topMargin: 30
                    z:2

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
                    anchors.topMargin: 30
                    z:2

                    text: currentGeneration + "\n" + currentIndividual
                    color: "white"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                }
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

                Rectangle{
                    anchors.centerIn: parent
                    anchors.topMargin: 50
                    width: 100
                    height: 90
                    z:2
                    color: "white"

                    Label {
                        anchors.centerIn: parent
                        id:textNumberCluster
                        text: cluster
                        color: "black"
                        font.pixelSize: 20
                    }


                    Canvas{
                        id: clusterDrawer
                        width: parent.width
                        height: parent.height
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = "black";
                            ctx.beginPath();
                            ctx.moveTo(0, 0);
                            ctx.lineTo(width/4, 0);
                            ctx.lineTo(0, height/2);

                            ctx.moveTo(width, 0);
                            ctx.lineTo(3*width/4, 0);
                            ctx.lineTo(width, height/2);

                            ctx.moveTo(width, height);
                            ctx.lineTo(3*width/4, height);
                            ctx.lineTo(width, height/2);

                            ctx.moveTo(0, height);
                            ctx.lineTo(width/4, height);
                            ctx.lineTo(0, height/2);
                            ctx.fill();
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

}
