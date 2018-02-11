import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Frame {

    property int generationNumber: 0
    property int individualNumber: 0
    property double individualDistanceScore : generationModel.getScoreDistance(generationNumber, individualNumber)
    property double individualBusesScore : generationModel.getScoreBus(generationNumber, individualNumber)
    property double totalDistance : generationModel.getDistance(generationNumber, individualNumber)
    property int numberBuses : generationModel.getNumberBuses(generationNumber, individualNumber)


    contentHeight: parent.height

    id: individualView

    Layout.preferredWidth: parent.width
    Layout.fillHeight: true




    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            color: "black"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                color: "white"
                text: generationNumber + " - " + individualNumber
                font.pointSize: 25
            }

            Frame {

                width: parent.width
                height: parent.height
                z: 100
                anchors.centerIn: parent

                background:Rectangle{
                    color: "transparent"
                    border.color: "black"
                }

                Column{
                    id:rankingColumn
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -0.07*parent.height
                    spacing:0.07*parent.height

                    Text{
                        id:rankingText
                        font.pointSize: 20
                        text: "Ranking"
                        font.underline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                    Text{
                        id:averageText
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "Average:" + " / "
                        color: "white"
                    }
                    Text{
                        id:distanceText
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "Distance:" + " / "
                        color: "white"
                    }
                    Text{
                        id:vehiclesText
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "Vehicles:" + " / "
                        color: "white"
                    }
                }
                Column{
                    x: rankingColumn.x -0.8*parent.height
                    y: rankingColumn.y
                    spacing:0.07*parent.height
                    Text{
                        opacity: 0.0
                        font.pointSize: 20
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "void"
                        color: "white"
                    }
                    Text{
                        opacity: 0.0
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: "void"
                        color: "white"
                    }
                    Text{
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: totalDistance
                        color: "white"
                    }
                    Text{
                        font.pointSize: 15
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: numberBuses
                        color: "white"
                    }

                }

                Canvas {
                    id: scoreCanvas
                    width: parent.width
                    height: parent.height

                    property bool change: false
                    states: State {
                        when: individualView.visible == true
                        PropertyChanges { change: true; target: scoreCanvas }
                    }

                    onChangeChanged: requestPaint()

                    onPaint: {
                        var ctx = getContext('2d')
                        ctx.reset();

                        var left = rankingColumn.x -0.8*parent.height
                        var right = width * 0.6
                        var vCenter = height * 0.5

                        ctx.lineCap = "square"
                        ctx.lineWidth = height*0.02

                        ctx.strokeStyle = populationModel.getColor(generationNumber, individualNumber, 0)
                        ctx.beginPath()
                        ctx.moveTo(width/2 - 0.43*parent.height, rankingColumn.y + averageText.y + 35)
                        ctx.lineTo(right, rankingColumn.y + averageText.y + 35)
                        ctx.stroke()
                        ctx.strokeStyle = "#85cdde";
                        ctx.beginPath()
                        ctx.moveTo(left, rankingColumn.y + distanceText.y + 35)
                        ctx.lineTo(right, rankingColumn.y + distanceText.y + 35)
                        ctx.stroke()
                        ctx.beginPath()
                        ctx.strokeStyle = "#2e94cc";
                        ctx.moveTo(left, rankingColumn.y + vehiclesText.y + 35)
                        ctx.lineTo(right, rankingColumn.y + vehiclesText.y + 35)
                        ctx.stroke()
                    }
                }
            }

            Canvas {
                id: mycanvas
                anchors.centerIn: parent
                width: parent.width
                height: parent.height

                property real animationProgress: 0

                states: State {
                    when: individualView.visible == true
                    PropertyChanges { animationProgress: 1; target: mycanvas }
                }
                transitions: Transition {
                    NumberAnimation {
                        property: "animationProgress"
                        easing.type: Easing.InOutCubic
                        duration: 1000
                    }
                }

                onAnimationProgressChanged: requestPaint()

                onPaint: {
                    var radius = 0.4*parent.height;
                    var lineWidth = 0.2*radius;
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.beginPath();
                    ctx.lineWidth= lineWidth;
                    ctx.strokeStyle = populationModel.getColor(generationNumber, individualNumber, 0);
                    ctx.arc(width/2, height/2, radius, 1.5*Math.PI, 1.5*Math.PI-Math.PI*animationProgress, true);
                    ctx.stroke();
                    ctx.beginPath();
                    ctx.lineWidth = lineWidth/2;
                    ctx.strokeStyle = "#85cdde";
                    ctx.arc(width/2, height/2, radius-0.5*lineWidth/2, 1.5*Math.PI, 1.5*Math.PI-Math.PI*animationProgress, true);
                    ctx.stroke();
                    ctx.beginPath();
                    ctx.strokeStyle = "#2e94cc";
                    ctx.arc(width/2, height/2, radius-1.5*lineWidth/2, 1.5*Math.PI, 1.5*Math.PI-Math.PI*animationProgress, true);
                    ctx.stroke();
                }
            }
        }
        Rectangle {
            color: "black"
            Layout.fillWidth: true
            Layout.preferredHeight: 0.2 * parent.height

            Column{

                spacing: 20
                anchors.top: parent.top
                anchors.topMargin: 0.2 * parent.height
                anchors.right: parent.right
                anchors.rightMargin: 0.45 * parent.width

                Frame{
                    background: Rectangle {
                        color: "black"
                        border.color: "black"
                    }
                    Label {
                        text: "Distance"
                        color: "yellow"
                        font.pixelSize: 15
                        anchors.right: distanceBar.left
                        anchors.rightMargin: 20
                    }
                    ProgressBar {
                        id:distanceBar
                        value: 0.5
                        width: 500
                        transform: Translate { y: 5 }
                    }
                }

                Frame{
                    background: Rectangle {
                        color: "black"
                        border.color: "black"
                    }
                    Label {
                        text: "Trucks"
                        color: "yellow"
                        font.pixelSize: 15
                        anchors.right: trucksBar.left
                        anchors.rightMargin: 20
                    }
                    ProgressBar {
                        id:trucksBar
                        value: 0.5
                        width: 500
                        transform: Translate { y: 5 }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton) {
                individualDrawer.currentGeneration = generationNumber
                individualDrawer.currentIndividual = individualNumber
                individualDrawer.lifetime = 0
                individualDrawer.performance = 0
                individualDrawer.nbMutations = 0
                individualDrawer.nbCrossovers = 0
                individualDrawer.cluster = 0
                individualDrawer.open()
            }
        }
    }
}
