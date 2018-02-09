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

            Canvas {
                id: mycanvas
                anchors.centerIn: parent
                width: parent.height
                height: parent.width
                onPaint: {
                    var ctx = getContext("2d");
                    var radius = 300;

                          ctx.beginPath();
                          ctx.arc(width/2, height/2, radius, 0, 2 * Math.PI, false);
                          ctx.fillStyle = populationModel.getColor(1, 1, 0);
                          ctx.fill();
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
