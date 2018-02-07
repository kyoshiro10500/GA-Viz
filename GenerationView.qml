import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Frame {
    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : parent.width /21
    property int verticalSpacing : 5
    property int horizontalSpacing : 10
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1

    padding: 40

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ListView {
        id: listView
        anchors.fill: parent

        flickableDirection: Flickable.HorizontalAndVerticalFlick

        model: generationModel.rowCount()

        contentWidth: generationModel.columnCount() * (cellSize + horizontalSpacing)

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
                        color: generationModel.data(generationModel.index(rowDelegate.row, column), 8)
                    }
                }
            }
        }

        ScrollIndicator.horizontal: ScrollIndicator { id: hScrollIndicator }
        ScrollIndicator.vertical: ScrollIndicator { id: vScrollIndicator }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
