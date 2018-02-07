import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Frame {
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 40 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1

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

        model: clusterModel.rowCount()

        contentWidth: clusterModel.columnCount() * (cellSize + verticalSpacing)

        delegate: Row {
            id: rowDelegate
            property int row: index

            Repeater {
                model: clusterModel.columnCount()
                ItemDelegate {
                    id: cellDelegate
                    property int column: index
                    width: cellSize + verticalSpacing
                    height: cellSize + horizontalSpacing
                    Rectangle {
                        id: cell
                        width: calculateCellSize(rowDelegate.row, column)
                        Text {
                                text: (parent.width <= 150) ? clusterModel.data(clusterModel.index(rowDelegate.row, column), 0) : ""
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: calculateCellSize(rowDelegate.row, column) / 4
                                color: (parent.width <= 150) ? "white" : "transparent"
                        }
                        color: clusterModel.data(clusterModel.index(rowDelegate.row, column), 8)

                        height: width

                        Canvas {
                            id: clusterCanvas
                            width: calculateCellSize(rowDelegate.row, column)
                            height: calculateCellSize(rowDelegate.row, column)
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.fillStyle = Qt.rgba(0, 0, 0, 1);
                                ctx.beginPath();
                                ctx.moveTo(0, 0);
                                ctx.lineTo(width/4, 0);
                                ctx.lineTo(0, height/2);

                                ctx.moveTo(width, 0);
                                ctx.lineTo(3*width/4, 0);
                                ctx.lineTo(width, height/2);

                                ctx.moveTo(width, height);
                                ctx.lineTo(3*width/4, height);
                                ctx.lineTo(width, height/2);

                                ctx.moveTo(0, height);
                                ctx.lineTo(width/4, height);
                                ctx.lineTo(0, height/2);
                                ctx.fill();
                            }
                        }

                        anchors.centerIn: parent
                    }
                }
            }
        }

        ScrollIndicator.horizontal: ScrollIndicator { id: hScrollIndicator }
        ScrollIndicator.vertical: ScrollIndicator { id: vScrollIndicator }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*clusterModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}








