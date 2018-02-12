import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

/**
  * \brief QML instance : ClusterView
  * Create the cluster view according to clusterModel
  */
Frame {
    id: clusterView /** clusterView : the id to identify the view in the applicatio hierarchy*/

    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 40 * showSlider.valueAt(showSlider.position) /** cellSize : the size of an individual in the view */
    property int verticalSpacing : 5 * showSlider.valueAt(showSlider.position) /** verticalSpacing : the space between individual in a row*/
    property int horizontalSpacing : 10 * showSlider.valueAt(showSlider.position) /** horizontalSpacing : the space between rows */
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1 /** verticalVisibleItemCount : the number of generation displayed on screen */
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1 /** horizontalVisibleItemCount : the number of individual displayed on screen in a row */

    property alias vScrollBar: vScrollBar /** vScrollBar : the vertical scrollbar of the view*/
    property alias hScrollBar: hScrollBar /** hScrollBar : the horizontal scrollbar of the view */

    padding: 10
    leftPadding: 70
    bottomPadding: 50

   //Define the background of the view
    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    /** clusterListView : The first ListView representing the generations */
    ListView {
        id: clusterListView
        model: clusterModel.rowCount() /** model : set to the number of generations inside clusterModel */
        orientation: ListView.Vertical
        contentWidth: clusterModel.columnCount() * (cellSize + horizontalSpacing) /**contentWidth : the width of all elements in the generation*/
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        interactive: clusterView.visible
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        /** rowDelegate : The second listview representing cluster inside a generation */
        delegate: ListView {
            id: rowDelegate
            model:  clusterModel.columnCount() /** model : set to the number of cluster inside clusterModel*/
            orientation: ListView.Horizontal
            width:  parent.width /** width : display elements that are on screen*/
            height : cellSize + verticalSpacing /** height : the height of the cell*/
            property int rowIndex: index /** rowIndex : the index of the row inside clusterModel */
            interactive: false
            /** columnDelegate : Item representing the cluster */
            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing
                property int columnIndex: index /** columnIndex : the index of the column inside clusterModel*/

                /** cell : the rectangle we will draw inside*/
                Rectangle {
                    id: cell
                    width: cellSize /** width : adapted wether the cluster is on the border of the screen */
                    /** The text of the cluster. Displayed depending of the size of the cluster*/
                    Text {
                            text: (parent.width <= 150) ? clusterModel.data(clusterModel.index(rowDelegate.rowIndex, columnDelegate.columnIndex), 0) : ""
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex) / 4
                            color: (parent.width <= 150) ? "white" : "transparent"
                    }

                    //TODO : add the listView for the individual inside the cluster

                    color: clusterModel.data(clusterModel.index(rowDelegate.rowIndex, columnDelegate.columnIndex), 8) /** color : get the color of the cluster. Grey by default*/

                    height: width

                    /** clusterCanvas : used to draw shape on the cluster*/
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

    // Label used to name the listview showing the row index
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

    // Label used to name the listview showing the column index
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

    // Listview used to display the row index
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

    // ListView used to dispay the column index
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

    //MouseArea used to open the drawer of the cluster view
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








