import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {
    id: generationView

    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

    property double scoreFilter: perfSlider.valueAt(perfSlider.position)
    property int index_gen: -1

    property alias vScrollBar: vScrollBar
    property alias hScrollBar: hScrollBar

    property double zoomScale: 1.0
    property int zoomX: 0
    property int zoomY: 0

    padding: 10
    leftPadding: 70

    background: Rectangle {
        color: "transparent"
        border.color: "black"
    }

    transform: Scale {
        id: scale
    }

    ListView {
        id: generationListView
        model: generationModel.rowCount()
        orientation: ListView.Vertical
        contentWidth: generationModel.columnCount() * (cellSize + horizontalSpacing)
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        delegate: ListView {
            id: rowDelegate
            model: generationModel.columnCount()
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
                    color: generationModel.getColor(rowDelegate.rowIndex, columnDelegate.columnIndex, index_gen, scoreFilter)

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if (mouse.button == Qt.LeftButton)
                            {
                                //filtersFadeOut.start()
                                zoomScale = parent.height / 0.8 * cellSize
                                zoomX = vizPage.width/2 - vizPage.padding - columnDelegate.mapToItem(generationView, 0, 0).x - columnDelegate.width/2
                                zoomY = vizPage.height/2 - vizPage.padding - columnDelegate.mapToItem(generationView, 0, 0).y - columnDelegate.height/2
                                generationView.transformOrigin = Item.Center
                                zoomIn.start()
                                // generationView fade out
                            }
                        }
                    }

                    Canvas {
                        id: generationCanvas
                        width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        height: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isNew: generationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isMutated: generationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isCrossing: generationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        onPaint: {
                            if(generationView.visible &&
                                    rowDelegate.rowIndex >= Math.ceil(vScrollBar.position*generationModel.rowCount()) - 1 &&
                                    rowDelegate.rowIndex <= Math.ceil(vScrollBar.position*generationModel.rowCount()) + verticalVisibleItemCount + 1 &&
                                    columnDelegate.columnIndex >= Math.ceil(hScrollBar.position*generationModel.columnCount()) - 1 &&
                                    columnDelegate.columnIndex <= Math.ceil(hScrollBar.position*generationModel.columnCount()) + horizontalVisibleItemCount + 1)
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

    ScrollBar {
        id: vScrollBar

        anchors.right: generationListView.left
        anchors.top: generationListView.top

        width: 15
        height: generationListView.height

        active: true
        contentItem.opacity: 1
    }

    ScrollBar {
        id: hScrollBar

        anchors.left: generationListView.left
        y: generationListView.y + generationListView.height

        width: generationListView.width
        height: 15

        active: true
        contentItem.opacity: 1
    }

    SequentialAnimation {
        id: zoomIn

        ParallelAnimation {
            id: moveIn
            NumberAnimation {
                id: xMoveIn
                target: generationView
                property: "x"
                to: zoomX
                duration: 2000
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                id: yMoveIn
                target: generationView
                property: "y"
                to: zoomY
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }


        ParallelAnimation {
            id: scaleUp

            NumberAnimation {
                id: xScaleUp
                target: scale
                property: "xScale"
                from: 1.0
                to: 1.5
                duration: 2000
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                id: yScaleUp
                target: scale
                property: "yScale"
                from: 1.0
                to: 1.5
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*generationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
