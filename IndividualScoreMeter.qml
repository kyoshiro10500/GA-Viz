import QtQuick 2.0

Item {

    property string text: ""
    property double score: 0.0
    property int    rank:0

    Text {
        id: scoreName
        text: text
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
