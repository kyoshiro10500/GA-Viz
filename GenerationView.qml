import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

/**
  * \brief QML instance : GenerationView
  * Create the generation view according to generationModel
  */
Frame {
    id: generationView /** generationView : the id of the view in the hierarchy */

    Layout.fillWidth: true
    Layout.fillHeight: true

    property int cellSize : 20 * showSlider.valueAt(showSlider.position) /** cellSize : the size of an individual */
    property int verticalSpacing : 10 * showSlider.valueAt(showSlider.position) /** verticalSpacing : the space between rows */
    property int horizontalSpacing : 5 * showSlider.valueAt(showSlider.position) /** horizontalSpacing : the space between individuals in a row */
    property int verticalVisibleItemCount : Math.ceil(height / (cellSize + verticalSpacing)) - 1 /** verticalVisibleItemCount : number of individual on screen vertically*/
    property int horizontalVisibleItemCount : Math.ceil(width / (cellSize + horizontalSpacing)) - 1 /** horizontalVisibleItemCount : number of generatiosn on screen */

    property double scoreFilter: perfSlider.valueAt(perfSlider.position) /** scoreFilter : the value of the filter on the global score */
    property double mutationFilter: mutationSlider.valueAt(mutationSlider.position); /** mutationFilter : the value of the filter on the number of mutations */
    property double crossingFilter: crossingSlider.valueAt(crossingSlider.position); /** crossingFilter : the value of the filter on the number of crossing over*/
    property int index_gen: -1 /** index_gen : the value of the selected generation */

    property alias vScrollBar: vScrollBar /** vscrollBar : the vertical ScrollBar*/
    property alias hScrollBar: hScrollBar /** hScrollBar : the horizontal ScrollBar*/

    property alias generationListView: generationListView

    property double zoomScale: 0.8 * 0.8 * parent.height / cellSize /** zoomScale :  the value of the zoom */
    property double zoomX: 0 /** zoomX : the coordinate where the zoom will happen*/
    property double zoomY: 0 /** zoomX : the coordinate where the zoom will happen*/

    padding: 10
    leftPadding: 70
    bottomPadding: 50

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    //The scale of the view
    transform: Scale {
        id: viewScale
        xScale: 1.0
        yScale: 1.0
    }

    //The first listview corresponding of the generations
    ListView {
        id: generationListView
        model: generationModel.rowCount() //Number of generations from generationModel
        orientation: ListView.Vertical
        contentWidth: generationModel.columnCount() * (cellSize + horizontalSpacing) // the size of the content of the listview
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        interactive: generationView.visible
        ScrollBar.vertical: vScrollBar
        ScrollBar.horizontal: hScrollBar
        clip: true

        anchors.fill: parent

        //The second listview corresponding to the individuals inside a generation
        delegate: ListView {
            id: rowDelegate
            model: generationModel.columnCount() //Number of individuals per generation according to generationModel
            orientation: ListView.Horizontal

            width: parent.width //Only render what is on screen
            height: cellSize + verticalSpacing

            property int rowIndex: index /**rowIndex : The index of the generation*/

            //The individual itself
            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing

                property int columnIndex: index /**columnIndex : The index of the individual inside a generation*/

                //Used to draw on the circle of the individual
                Rectangle {
                    id: cell

                    width: cellSize
                    height: width
                    radius: 0.5 * width
                    anchors.centerIn: parent
                    color: generationModel.getColor(rowDelegate.rowIndex, columnDelegate.columnIndex, index_gen, scoreFilter, mutationFilter, crossingFilter)

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if (mouse.button == Qt.LeftButton)
                            {
                                if((cell.color.r != 0 || cell.color.g != 0 || cell.color.b != 0) && index_gen == rowDelegate.rowIndex)
                                {
                                    generationToIndividualTransition(columnDelegate)
                                    individualView.generationNumber = rowDelegate.rowIndex
                                    individualView.individualNumber = columnDelegate.columnIndex
                                }
                            }
                        }
                    }

                    property bool isNew: generationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isMutated: generationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                    property bool isCrossing: generationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)

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

    //The vertical scrollbar itself
    ScrollBar {
        id: vScrollBar

        anchors.right: generationListView.left
        anchors.top: generationListView.top
        anchors.rightMargin: 10

        width: 15
        height: generationListView.height

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

    //The horizontal scrollbar itself
    ScrollBar {
        id: hScrollBar

        anchors.left: generationListView.left
        y: generationListView.y + generationListView.height + 10

        width: generationListView.width
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

    //Name of the listview displaying the number of generation
    Label {
        id: rowHeader
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

    //Name of the listview displaying the number of individual
    Label {
        id: columnHeader
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

    //Display the name of the row
    ListView {
        id: rowIndicator

        anchors.right: vScrollBar.left
        width: 40
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

    //Display the name of the column
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

    //MouseArea used to open the drawer corresponding to the view
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.RightButton) {
                //We access to all the infos needed for the individualView and send them to the next view
                if(index_gen != -1)
                {
                    generationDrawer.currentGeneration = index_gen
                    generationDrawer.globalPerformance = generationModel.getMeanScore(index_gen) ;
                    generationDrawer.nbIndividuals = populationModel.columnCount()
                    generationDrawer.nbMutations = generationModel.getGenNumberMutations(index_gen) ;
                    generationDrawer.nbCrossovers = generationModel.getGenNumberCrossover(index_gen) ;
                    generationDrawer.nbClusters = populationModel.get_number_cluster()
                    generationDrawer.open()
                }
                else
                {
                    generationDrawer.currentGeneration = -1
                    generationDrawer.globalPerformance = -1
                    generationDrawer.nbIndividuals = -1
                    generationDrawer.nbMutations = -1
                    generationDrawer.nbCrossovers = -1
                    generationDrawer.nbClusters = -1
                    generationDrawer.open()
                }

            }
        }
    }

    //All the animation to go to the individualView
    ParallelAnimation {
        id: zoomIn
        NumberAnimation {
            target: generationView
            property: "x"
            to: zoomX
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: generationView
            property: "y"
            to: zoomY
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: viewScale
            property: "xScale"
            from: 1.0
            to: zoomScale
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: viewScale
            property: "yScale"
            from: 1.0
            to: zoomScale
            duration: 2000
            easing.type: Easing.InOutQuad
        }
    }

    ParallelAnimation {
        id: zoomOut
        NumberAnimation {
            target: generationView
            property: "x"
            to: 0
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: generationView
            property: "y"
            to: title.height + viewLayout.spacing + filters.height + viewLayout.spacing
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: viewScale
            property: "xScale"
            from: zoomScale
            to: 1.0
            duration: 2000
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: viewScale
            property: "yScale"
            from: zoomScale
            to: 1.0
            duration: 2000
            easing.type: Easing.InOutQuad
        }
    }

    NumberAnimation {
        id: generationViewFadeOut
        target: generationView
        property: "opacity"
        to: 0.0
        duration: 400
        easing.type: Easing.InOutQuad
    }

    Timer {
        id: individualViewTimer
        interval: 2000
        onTriggered: {
            filters.visible = false
            generationView.visible = false
            individualView.visible = true
            filters.opacity = 1.0
        }
    }

    Timer {
        id: generationViewTimer
        interval: 2000
        onTriggered: {
            filtersFadeIn.start()
            vScrollBar.visible = true
            hScrollBar.visible = true
            rowIndicator.visible = true
            columnIndicator.visible = true
            rowHeader.visible = true
            columnHeader.visible = true
        }
    }

    function resetGenerationView() {
        populationView.visible = false
        clusterView.visible = false
        filters.visible = true
        filters.opacity = 1.0
        individualView.visible = false
        generationView.visible = true
        viewScale.xScale = 1.0
        viewScale.yScale = 1.0
        vScrollBar.visible = true
        hScrollBar.visible = true
        rowIndicator.visible = true
        columnIndicator.visible = true
        rowHeader.visible = true ;
        columnHeader.visible = true ;
        generationView.x = 0
        generationView.y = title.height + viewLayout.spacing + filters.height + viewLayout.spacing

    }

    function generationToIndividualTransition(item) {
        filtersFadeOut.start()
        vScrollBar.visible = false
        hScrollBar.visible = false
        rowIndicator.visible = false
        columnIndicator.visible = false
        rowHeader.visible = false ;
        columnHeader.visible = false ;
        zoomX = vizPage.width/2 - vizPage.padding - item.mapToItem(generationView, 0, 0).x - (item.mapToItem(generationView, 0, 0).x) * (zoomScale-1) - zoomScale * item.width/2
        zoomY = vizPage.height/2 - vizPage.padding - item.mapToItem(generationView, 0, 0).y - (item.mapToItem(generationView, 0, 0).y) * (zoomScale-1) - zoomScale * item.height/2 - filters.height
        zoomIn.start()
        individualViewTimer.start()
    }

    function individualToGenerationTransition() {
        filters.opacity = 0.0
        filters.visible = true
        individualView.visible = false
        generationView.visible = true
        generationViewTimer.start()
        zoomOut.start()
    }

    function calculateCellSize(rowIndex, columnIndex) {
        return Math.min(cellSize - (cellSize * (Math.abs(columnIndex - hScrollBar.position*generationModel.columnCount() - horizontalVisibleItemCount/2) - horizontalVisibleItemCount/2)), cellSize);
    }
}
