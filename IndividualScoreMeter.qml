import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Frame {

    property string text: ""
    property double score: 0.0
    property int    rank:0

    Layout.fillWidth: true
    Layout.fillHeight: true

    background:Rectangle{
        color: "#ff0000"
        Layout.fillHeight: parent.height
        Layout.fillWidth: parent.width
    }

    Column{
        spacing: 20

        Text{
            id:rankingText
            font.pointSize: 25
            text: "Rankinnng"
            font.underline: true
            color: "white"
        }
        Text{
            font.pointSize: 20
            anchors.centerIn: parent
            text: "Average:" + " / "
            color: "white"
        }
    }

    Canvas {
        id: mycanvas
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        property real animationProgress: 0

        states: State {
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

        }
    }
}
