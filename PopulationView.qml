import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

/**
  * \brief QML instance : populationView
  * Create the population view according to populationModel
  */
Frame {
    id: populationView

    Layout.preferredWidth: parent.width
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position) /** cellSize : the size of individual in the view */
    property int verticalSpacing : 10 * showSlider.valueAt(showSlider.position) /** verticalSpacing : the space between generations */
    property int horizontalSpacing : 5 * showSlider.valueAt(showSlider.position) /** horizontalSpacing : the space between individuals inside a generation */
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1 /** verticalVisibleItemCount : the number of row visible on screen */
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1 /** horizontalVisibleItemCount : the number of column visible on screen */

    property double scoreFilter: perfSlider.valueAt(perfSlider.position); /** scoreFilter : the value of the score filter */
    property double mutationFilter: mutationSlider.valueAt(mutationSlider.position); /** mutationFilter : the value of the mutation filter */
    property double crossingFilter: crossingSlider.valueAt(crossingSlider.position); /** crossingFilter: the value of the crossing over filter */

    property alias vScrollBar: vScrollBar /** vScrollBar : the vertical scrollbar */
    property alias hScrollBar: hScrollBar /** hScrollBar : the horizontal scrollbar */

    padding: 10
    leftPadding: 70
    bottomPadding: 50

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    // The first listView containing generations according to populationModel
    ListView {
        id: populationListView
        model: populationModel.rowCount() //The number of row inside the model
        orientation: ListView.Vertical
        contentWidth: populationModel.columnCount() * (cellSize + horizontalSpacing) //The width of the content of the listview
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        //The second listview containing the individuals of a generation
        delegate: ListView {
            id: rowDelegate
            model:  populationModel.columnCount()
            orientation: ListView.Horizontal
            width:  populationView.visible && (index >= (vScrollBar.position)*populationModel.rowCount() - 1 && index <= (vScrollBar.position)*populationModel.rowCount() +verticalVisibleItemCount+ 1) ? parent.width : 0 //render only visible item
            height : cellSize + verticalSpacing
            property int rowIndex: index //the index of the generation

            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing
                property int columnIndex: index //the index of the individual inside the generation

                //The individual itself
                Rectangle {
                    id: cell

                    width: populationView.visible && (index >= (hScrollBar.position)*populationModel.columnCount() - 1 && index <= (hScrollBar.position)*populationModel.columnCount() +horizontalVisibleItemCount+ 1) ? calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex) : 0 //Render only what is visible
                    visible : populationView.visible && (index >= (hScrollBar.position)*populationModel.columnCount() - 1 && index <= (hScrollBar.position)*populationModel.columnCount() +horizontalVisibleItemCount+ 1) //Render only what is visible
                    height: width
                    radius: 0.5 * width
                    anchors.centerIn: parent
                    color: populationModel.getColor(rowDelegate.rowIndex, columnDelegate.columnIndex, scoreFilter, mutationFilter, crossingFilter)

                    //The mouseArea to change view
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

                    //Property of the individual to draw the shapes
                    property bool isNew: populationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isMutated: populationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isCrossing: populationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool showGenealogy: populationModel.getGenealogy()
                    property int parent1: populationModel.getParent1(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property int parent2: populationModel.getParent2(rowDelegate.rowIndex, columnDelegate.columnIndex)

                    Rectangle {
                        id: newRectangle
                        visible: cell.isNew || rowDelegate.rowIndex == 0
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

    //The vertical scrollBar
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

        //Scrollbars are linked
        onPositionChanged: {
            if (populationView.visible)
                generationView.vScrollBar.position = position
        }
    }

    //the horizontal scrollbar
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

        //The scrollbar are linked
        onPositionChanged: {
            if (populationView.visible)
                generationView.hScrollBar.position = position
        }
    }

    //Display the name of the listview to disply number of row/column
    Label {
        width: rowIndicator.width
        anchors.bottom: rowIndicator.top
        anchors.left: rowIndicator.left
        anchors.bottomMargin: 10
        text: "G"
        font.pixelSize: Math.min(20 + showSlider.value, 30)
        font.underline: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "yellow"
    }

    Label {
        height: columnIndicator.height
        anchors.top: rowIndicator.bottom
        anchors.right: rowIndicator.right
        text: "I"
        anchors.topMargin: 10
        font.pixelSize: Math.min(20 + showSlider.value, 30)
        font.underline: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "yellow"
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
                populationDrawer.nbIndividuals = populationModel.get_number_generation()*populationModel.get_number_cluster()*populationModel.get_number_individuals()
                populationDrawer.nbMutations = populationModel.get_number_mutation()
                populationDrawer.nbCrossovers = populationModel.get_number_crossover()
                populationDrawer.nbClusters = populationModel.get_number_cluster()
                populationDrawer.globalPerformance = populationModel.get_mean_score()
                populationDrawer.open()
            }
        }
    }

    /**
      * calculate the size depending of where the cluster is
      * @param rowIndex : the row of the cluster
      * @param columnIndex : the column of the cluster
      */
    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*populationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
    }
}
