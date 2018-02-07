import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {
    Layout.preferredWidth: parent.width
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    property double scoreFilter: perfSlider.valueAt(perfSlider.position);

    padding: 10

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ListView {

        id: populationListView
        anchors.fill: parent

        clip: true ;
        flickableDirection: Flickable.HorizontalAndVerticalFlick

        model: populationModel.rowCount() ;

        contentWidth: populationModel.columnCount() * (cellSize + verticalSpacing)

        delegate: Row {
            id: rowDelegate
            property int row: index

            Repeater {
                model: populationModel.columnCount()
                ItemDelegate {
                    id: cellDelegate
                    property int column: index
                    width: cellSize + verticalSpacing
                    height: cellSize + horizontalSpacing
                    Rectangle {
                        id: cell
                        width: calculateCellSize(rowDelegate.row, column)
                        Text {
                            font.pixelSize: 20
                            color: "white"
                        }
                        color: populationModel.getColor(rowDelegate.row, column, scoreFilter)
                        height: width
                        radius: 0.5 * width
                        anchors.centerIn: parent

                        MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.RightButton
                                onClicked: {
                                    if (mouse.button == Qt.RightButton)
                                    {
                                        generationModel.setGeneration(rowDelegate.row) ;
                                        population.visible = false ;
                                        generation.visible = true ;
                                        generation.index_gen = rowDelegate.row ;
                                    }

                                }
                            }

                        Canvas {
                            id: populationCanvas
                            width: calculateCellSize(rowDelegate.row, column)
                            height: calculateCellSize(rowDelegate.row, column)
                            property bool isNew: populationModel.getNew(rowDelegate.row,column)
                            property bool isMutated: populationModel.getMutation(rowDelegate.row,column)
                            property bool isCrossing: populationModel.getCrossing(rowDelegate.row,column)
                            property bool showGenealogy: populationModel.getGenealogy()
                            property int parent1: populationModel.getParent1(rowDelegate.row,column)
                            property int parent2: populationModel.getParent2(rowDelegate.row,column)
                            property double vScrollposition: vScrollIndicator.position
                            property double hScrollposition: hScrollIndicator.position
                            onPaint: {
                                console.log(Math.ceil(vScrollposition*populationModel.rowCount()) - 1) ;
                                console.log(Math.ceil(vScrollposition*populationModel.rowCount()) + verticalVisibleItemCount + 1) ;
                                console.log(Math.ceil(hScrollposition*populationModel.columnCount()) - 1) ;
                                console.log(Math.ceil(hScrollposition*populationModel.columnCount()) + horizontalVisibleItemCount + 1);
                                if(rowDelegate.row >= Math.ceil(vScrollposition*populationModel.rowCount()) - 1 &&
                                        rowDelegate.row <= Math.ceil(vScrollposition*populationModel.rowCount()) + verticalVisibleItemCount + 1 &&
                                        column >= Math.ceil(hScrollposition*populationModel.columnCount()) - 1 &&
                                        column <= Math.ceil(hScrollposition*populationModel.columnCount()) + horizontalVisibleItemCount + 1)
                                {
                                    var ctx = populationCanvas.getContext("2d");
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

                                    //Genealogy
                                    if(true && isNew)
                                    {
                                        /*var genealogyctx = canvasGenealogy.getContext("2d");
                                        genealogyctx.fillStyle = Qt.rgba(255, 255, 0, 1);
                                        if(parent1 != -1)
                                        {
                                            var generation1 = parent1 / populationModel.columnCount() ;
                                            var individual1 = parent1 % populationModel.columnCount() ;
                                            var generation_gap1 =  generation1 - rowDelegate.row ;
                                            var individual_gap1 = individual1 - column ;
                                            genealogyctx.beginPath();
                                            genealogyctx.moveTo(width/2, height/2);
                                            genealogyctx.lineTo(width/2 + individual_gap1*cellSize + 0.25 * width, height/2 + generation_gap1*cellSize);
                                            genealogyctx.lineTo(width/2 + individual_gap1*cellSize -0.25 * width, height/2 + generation_gap1*cellSize);
                                            genealogyctx.fill();
                                        }
                                        if(parent2 != -1)
                                        {
                                            var generation2 = parent2 / populationModel.columnCount() ;
                                            var individual2 = parent2 % populationModel.columnCount() ;
                                            var generation_gap2 =  generation2 - rowDelegate.row ;
                                            var individual_gap2 = individual2 - column ;
                                            genealogyctx.beginPath();
                                            genealogyctx.moveTo(width/2, height/2);
                                            genealogyctx.lineTo(width/2 + individual_gap2*cellSize + 0.25 * width, height/2 + generation_gap2*cellSize);
                                            genealogyctx.lineTo(width/2 + individual_gap2*cellSize -0.25 * width, height/2 + generation_gap2*cellSize);
                                            genealogyctx.fill();
                                        }*/
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        ScrollBar.horizontal: ScrollBar { id: hScrollIndicator }

        ScrollBar.vertical: ScrollBar {
            id: vScrollIndicator
            active: true
        }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollIndicator.position*generationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
