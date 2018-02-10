import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Frame {
    id: generationView

    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    property double scoreFilter: perfSlider.valueAt(perfSlider.position)
    property int index_gen: -1

    property alias vScrollBar: vScrollBar
    property alias hScrollBar: hScrollBar

    property double targetScale: 1.0
    property int targetX: 0
    property int targetY: 0

    padding: 10
    leftPadding: 70

    background: Rectangle {
        color: "red"
        border.color: "black"
    }

    ListView {
        id: generationListView
        anchors.fill: parent

        clip: true
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        model: generationModel.rowCount()

        contentWidth: generationModel.columnCount() * (cellSize + verticalSpacing)

        delegate: Row {
            id: rowDelegate
            property int row: index

            leftPadding: 20

            Repeater {
                model: generationModel.columnCount()
                ItemDelegate {
                    id: cellDelegate
                    property int column: index
                    width: cellSize + verticalSpacing
                    height: cellSize + horizontalSpacing
                    Rectangle {
                        id: cell
                        width: calculateCellSize(rowDelegate.row, column)
                        Text {
                            //text: verticalVisibleItemCount
                            font.pixelSize: 20
                            color: "white"
                        }

                        height: width
                        radius: 0.5 * width
                        anchors.centerIn: parent
                        color: generationModel.getColor(rowDelegate.row, column, index_gen,scoreFilter)

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button == Qt.LeftButton)
                                {
                                    //filtersFadeOut.start()
                                    targetScale = parent.height / 0.8 * cellSize
                                    targetX = vizPage.width/2 - cellDelegate.mapToItem(vizPage, 0, 0).x - cellDelegate.width/2
                                    console.log(cellDelegate.width/2)
                                    //scaleUp.start()
                                    xMoveIn.start()

                                    // generationView x y -> calc
                                    // generationView fade out
                                }
                            }
                        }

                        Canvas {
                            id: generationCanvas
                            width: calculateCellSize(rowDelegate.row, column)
                            height: calculateCellSize(rowDelegate.row, column)
                            property bool isNew: generationModel.getNew(rowDelegate.row,column)
                            property bool isMutated: generationModel.getMutation(rowDelegate.row,column)
                            property bool isCrossing: generationModel.getCrossing(rowDelegate.row,column)
                            onPaint: {
                                if(generationView.visible &&
                                        rowDelegate.row >= Math.ceil(vScrollBar.position*generationModel.rowCount()) - 1 &&
                                        rowDelegate.row <= Math.ceil(vScrollBar.position*generationModel.rowCount()) + verticalVisibleItemCount + 1 &&
                                        column >= Math.ceil(hScrollBar.position*generationModel.columnCount()) - 1 &&
                                        column <= Math.ceil(hScrollBar.position*generationModel.columnCount()) + horizontalVisibleItemCount + 1)
                                {
                                    var ctx = generationCanvas.getContext("2d");
                                    ctx.fillStyle = Qt.rgba(0, 0, 0, 1);
                                    //New Individual
                                    if(isNew && 0.1 * width >= 0.001)
                                    {
                                        ctx.beginPath() ;
                                        ctx.arc(width/2.0, height/2.0, 0.1*width, 0, 2 * Math.PI, false);
                                        ctx.fill();
                                    }

                                    //Mutation
                                    if(isMutated)
                                    {
                                        ctx.beginPath();
                                        ctx.moveTo(width, 0);
                                        ctx.lineTo(width, height/2.0);
                                        ctx.lineTo(width/2.0, 0);
                                        ctx.fill();
                                    }

                                    //Crossing over
                                    if(isCrossing)
                                    {
                                        ctx.beginPath();
                                        ctx.moveTo(width, height);
                                        ctx.lineTo(width/2.0, height);
                                        ctx.lineTo(width, height/2.0);
                                        ctx.fill();
                                    }
                                }
                         }
                    }
                }
            }
            }
        }

        ScrollBar.vertical: ScrollBar {
            id: vScrollBar

            anchors.left: generationListView.left
            anchors.leftMargin: 1
            width: 15

            active: true
            contentItem.opacity: 1
        }

        ScrollBar.horizontal: ScrollBar {
            id: hScrollBar

            height: 15

            active: true
            contentItem.opacity: 1
        }
    }

    ScaleAnimator {
        id: scaleUp
        target: generationView
        from: 1.0
        to: targetScale
        duration: 200
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: xMoveIn
        target: generationView
        property: "x"
        to: targetX
        duration: 200
        easing.type: Easing.InOutQuad
    }

    function calculateCellSize(rowIndex, columnIndex) {
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*generationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
    }

}
