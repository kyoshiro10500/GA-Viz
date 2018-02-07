import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Frame {
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    property double scoreFilter: perfSlider.valueAt(perfSlider.position);
    property int index_gen: -1 ;

    padding: 10

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ListView {
        id: listView
        anchors.fill: parent

        clip: true
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        model: generationModel.rowCount()

        contentWidth: generationModel.columnCount() * (cellSize + verticalSpacing)

        delegate: Row {
            id: rowDelegate
            property int row: index

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

                        Canvas {
                            id: generationCanvas
                            width: calculateCellSize(rowDelegate.row, column)
                            height: calculateCellSize(rowDelegate.row, column)
                            property bool isNew: generationModel.getNew(rowDelegate.row,column)
                            property bool isMutated: generationModel.getMutation(rowDelegate.row,column)
                            property bool isCrossing: generationModel.getCrossing(rowDelegate.row,column)
                            onPaint: {
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

        ScrollIndicator.horizontal: ScrollIndicator { id: hScrollIndicator }
        ScrollIndicator.vertical: ScrollIndicator { id: vScrollIndicator }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollIndicator.position*generationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
    }

}
