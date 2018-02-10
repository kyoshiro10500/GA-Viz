import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Frame {

    property int generationNumber: 0
    property int individualNumber: 0
    property double individualDistanceScore : generationModel.getScoreDistance(generationNumber, individualNumber)
    property double individualBusesScore : generationModel.getScoreBuses(generationNumber, individualNumber)


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

            Text{
                id:rankingText
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -0.2*parent.height
                font.pointSize: 25
                text: "Ranking"
                font.underline: true
                color: "white"
            }
            Text{
                font.pointSize: 20
                anchors.centerIn: parent
                text: "Average:" + " / "
                color: "white"
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
                    ctx.beginPath();
                    ctx.strokeStyle = "#142424";
                    ctx.arc(width/2, height/2, radius-2.5*lineWidth/2, 1.5*Math.PI, 1.5*Math.PI-Math.PI*animationProgress, true);
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
}
