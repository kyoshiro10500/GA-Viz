import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

/**
  * \brief QML instance :LoadingScreen
  * Create random simili individual on the main page
  */
Frame {
    id: loadingScreen

    property int cellSize : 20
    property int verticalSpacing : 10
    property int horizontalSpacing : 5
    property int rowCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int columnCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ListView {
        id: populationListView
        model: rowCount
        orientation: ListView.Vertical
        contentWidth: columnCount * (cellSize + horizontalSpacing)
        interactive: false

        anchors.fill: parent

        delegate: ListView {
            id: rowDelegate
            model: columnCount
            orientation: ListView.Horizontal
            interactive: false

            width: parent.width
            height: cellSize + verticalSpacing

            property int rowIndex: index

            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing

                property int columnIndex: index

                Rectangle {
                    id: cell

                    width: cellSize
                    height: width
                    radius: 0.5 * width
                    anchors.centerIn: parent
                    color: randomColor()

                    property double alpha: 0.4

                    function randomColor() {
                        var score = Math.random()
                        return Qt.rgba(0, score, score, alpha)
                    }

                    property bool isNew: Math.random() >= 0.5;
                    property bool isMutated: Math.random() >= 0.5;
                    property bool isCrossing: Math.random() >= 0.5;

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
            }
        }
    }
}
