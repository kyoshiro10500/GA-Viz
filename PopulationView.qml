import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {
    id: populationView

    Layout.preferredWidth: parent.width
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    property double scoreFilter: perfSlider.valueAt(perfSlider.position);

    property alias vScrollBar: vScrollBar
    property alias hScrollBar: hScrollBar

    padding: 10
    leftPadding: 70
    bottomPadding: 50

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ListView {
        id: populationListView
        model: populationModel.rowCount()
        orientation: ListView.Vertical
        contentWidth: populationModel.columnCount() * (cellSize + horizontalSpacing)
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        delegate: ListView {
            id: rowDelegate
            model: populationModel.columnCount()
            orientation: ListView.Horizontal

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

                    width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    height: width
                    radius: 0.5 * width
                    anchors.centerIn: parent
                    color: populationModel.getColor(rowDelegate.rowIndex, columnDelegate.columnIndex, scoreFilter)

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if (mouse.button == Qt.RightButton) {
                                generationModel.setGeneration(rowDelegate.rowIndex)
                                populationView.visible = false
                                generationView.visible = true
                                generationView.index_gen = rowDelegate.rowIndex
                            }
                            else if (mouse.button == Qt.LeftButton) {
                                populationInfoDrawer.open()
                            }
                        }
                    }

                    Canvas {
                        id: populationCanvas
                        width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        height: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isNew: populationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isMutated: populationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isCrossing: populationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool showGenealogy: populationModel.getGenealogy()
                        property int parent1: populationModel.getParent1(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property int parent2: populationModel.getParent2(rowDelegate.rowIndex, columnDelegate.columnIndex)

                        onPaint: {
                            if (populationView.visible &&
                                    rowDelegate.rowIndex >= Math.ceil(vScrollBar.position*populationModel.rowCount()) - 1 &&
                                    rowDelegate.rowIndex <= Math.ceil(vScrollBar.position*populationModel.rowCount()) + verticalVisibleItemCount + 1 &&
                                    columnDelegate.columnIndex >= Math.ceil(hScrollBar.position*populationModel.columnCount()) - 1 &&
                                    columnDelegate.columnIndex <= Math.ceil(hScrollBar.position*populationModel.columnCount()) + horizontalVisibleItemCount + 1)
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

    ScrollBar {
        id: vScrollBar

        anchors.right: populationListView.left
        anchors.top: populationListView.top

        width: 15
        height: populationListView.height

        active: true
        contentItem.opacity: 1

        onPositionChanged: {
            generationView.vScrollBar.position = position
        }
    }

    ScrollBar {
        id: hScrollBar

        anchors.left: populationListView.left
        y: populationListView.y + populationListView.height

        width: populationListView.width
        height: 15

        active: true
        contentItem.opacity: 1

        onPositionChanged: {
            generationView.hScrollBar.position = position
        }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*populationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
