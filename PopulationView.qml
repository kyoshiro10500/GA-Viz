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
            model:  populationModel.columnCount()
            orientation: ListView.Horizontal
            width:  (index >= (vScrollBar.position)*populationModel.rowCount() - 1 && index <= (vScrollBar.position)*populationModel.rowCount() +verticalVisibleItemCount+ 1) ? parent.width : 0
            height : cellSize + verticalSpacing
            property int rowIndex: index

            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing
                property int columnIndex: index

                Rectangle {
                    id: cell

                    width: (index >= (hScrollBar.position)*populationModel.columnCount() - 1 && index <= (hScrollBar.position)*populationModel.columnCount() +horizontalVisibleItemCount+ 1) ? calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex) : 0
                    visible : (index >= (hScrollBar.position)*populationModel.columnCount() - 1 && index <= (hScrollBar.position)*populationModel.columnCount() +horizontalVisibleItemCount+ 1)
                    height: width
                    radius: 0.5 * width
                    anchors.centerIn: parent
                    color: populationModel.getColor(rowDelegate.rowIndex, columnDelegate.columnIndex, scoreFilter)

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        onClicked: {
                            if (mouse.button == Qt.LeftButton) {
                                generationModel.setGeneration(rowDelegate.rowIndex)
                                generationView.resetGenerationView()
                                generationView.index_gen = rowDelegate.rowIndex
                            }
                        }
                    }

                    property bool isNew: populationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isMutated: populationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isCrossing: populationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool showGenealogy: populationModel.getGenealogy()
                    property int parent1: populationModel.getParent1(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property int parent2: populationModel.getParent2(rowDelegate.rowIndex, columnDelegate.columnIndex)

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

    ScrollBar {
        id: vScrollBar

        anchors.right: populationListView.left
        anchors.top: populationListView.top
        anchors.rightMargin: 10

        width: 15
        height: populationListView.height

        active: true

        contentItem: Rectangle {
            opacity: 1
            width: 5
            radius: width / 2
            color: vScrollBar.pressed ? Qt.darker("#ffffff", 1.5) : Qt.darker("#ffffff", 1.2)
        }

        background: Rectangle {
            anchors.horizontalCenter: vScrollBar.horizontalCenter
            anchors.verticalCenter: vScrollBar.verticalCenter
            width: 1
            height: vScrollBar.height - 10
            color: Qt.darker("#ffffff", 2.0)
        }

        onPositionChanged: {
            if (populationView.visible)
                generationView.vScrollBar.position = position
        }
    }

    ScrollBar {
        id: hScrollBar

        anchors.left: populationListView.left
        y: populationListView.y + populationListView.height + 10

        width: populationListView.width
        height: 15

        active: true

        contentItem: Rectangle {
            opacity: 1
            height: 5
            radius: width / 2
            color: hScrollBar.pressed ? Qt.darker("#ffffff", 1.5) : Qt.darker("#ffffff", 1.2)
        }

        background: Rectangle {
            anchors.horizontalCenter: hScrollBar.horizontalCenter
            anchors.verticalCenter: hScrollBar.verticalCenter
            width: hScrollBar.width - 10
            height: 1
            color: Qt.darker("#ffffff", 2.0)
        }

        onPositionChanged: {
            if (populationView.visible)
                generationView.hScrollBar.position = position
        }
    }

    ListView {
        id: rowIndicator

        anchors.right: vScrollBar.left
        anchors.rightMargin: 10
        width: 20
        height: vScrollBar.height

        model: populationModel.rowCount()
        orientation: ListView.Vertical
        interactive: false
        ScrollBar.vertical: vScrollBar
        clip: true

        delegate: Label {
            width: parent.width
            height: cellSize + verticalSpacing
            text: index
            font.pixelSize: Math.min(10 + showSlider.value, 20)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }

    ListView {
        id: columnIndicator

        anchors.top: hScrollBar.bottom
        anchors.topMargin: 10
        width: hScrollBar.width
        height: 20

        model: populationModel.columnCount()
        orientation: ListView.Horizontal
        interactive: false
        ScrollBar.horizontal: hScrollBar
        clip: true

        delegate: Label {
            width: cellSize + horizontalSpacing
            height: parent.height
            text: index
            font.pixelSize: Math.min(10 + showSlider.value, 20)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton) {
                populationDrawer.globalPerformance = 0
                populationDrawer.nbIndividuals = populationModel.rowCount() * populationModel.columnCount()
                populationDrawer.nbMutations = 0
                populationDrawer.nbCrossovers = 0
                populationDrawer.nbClusters = 0
                populationDrawer.open()
            }
        }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*populationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
