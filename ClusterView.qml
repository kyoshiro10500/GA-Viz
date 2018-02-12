import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


Frame {
    id: clusterView

    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 40 * showSlider.valueAt(showSlider.position)
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position)
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position)
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1

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
        id: clusterListView
        model: clusterModel.rowCount()
        orientation: ListView.Vertical
        contentWidth: clusterModel.columnCount() * (cellSize + horizontalSpacing)
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        delegate: ListView {
            id: rowDelegate
            model:  clusterModel.columnCount()
            orientation: ListView.Horizontal
            width:  (index >= (vScrollBar.position)*clusterModel.rowCount() - 1 && index <= (vScrollBar.position)*clusterModel.rowCount() +verticalVisibleItemCount+ 1) ? parent.width : 0
            height : cellSize + verticalSpacing
            property int rowIndex: index

            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing
                property int columnIndex: index

                Rectangle {
                    id: cell
                    width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    Text {
                            text: (parent.width <= 150) ? clusterModel.data(clusterModel.index(rowDelegate.rowIndex, columnDelegate.columnIndex), 0) : ""
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex) / 4
                            color: (parent.width <= 150) ? "white" : "transparent"
                    }
                    color: clusterModel.data(clusterModel.index(rowDelegate.rowIndex, columnDelegate.columnIndex), 8)

                    height: width

                    Canvas {
                        id: clusterCanvas
                        width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        height: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
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

    ScrollBar {
        id: vScrollBar

        anchors.right: clusterListView.left
        anchors.top: clusterListView.top
        anchors.rightMargin: 10

        width: 15
        height: clusterListView.height

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
    }

    ScrollBar {
        id: hScrollBar

        anchors.left: clusterListView.left
        y: clusterListView.y + clusterListView.height + 10

        width: clusterListView.width
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
    }

    ListView {
        id: rowIndicator

        anchors.right: vScrollBar.left
        width: 40
        height: vScrollBar.height

        model: clusterModel.rowCount()
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

        model: clusterModel.columnCount()
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
                populationDrawer.nbIndividuals = populationModel.get_number_generation()*populationModel.get_number_cluster()*populationModel.get_number_individuals()
                populationDrawer.nbMutations = populationModel.get_number_mutation()
                populationDrawer.nbCrossovers = populationModel.get_number_crossover()
                populationDrawer.nbClusters = populationModel.get_number_cluster()
                populationDrawer.globalPerformance = populationModel.get_mean_score()
                populationDrawer.open()
            }
        }
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*populationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}








