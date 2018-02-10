import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {

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
                text: 'Generation number - Individual number'
                font.pointSize: 12
            }

            Text {
                anchors.centerIn: parent
                color: "white"
                text: 'Individu'
            }

            MouseArea {
                id: trigger
                anchors.fill: parent
                onClicked: console.log("prout")
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
                    ctx.strokeStyle = populationModel.getColor(1, 1, 0);
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

            Text {
                anchors.centerIn: parent
                color: "white"
                text: 'score'
            }
        }
    }
}
