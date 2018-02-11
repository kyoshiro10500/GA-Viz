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

    property double zoomScale: 0.8 * 0.8 * parent.height / cellSize
    property double zoomX: 0
    property double zoomY: 0

    padding: 10
    leftPadding: 70
    bottomPadding: 50

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    transform: Scale {
        id: viewScale
        xScale: 1.0
        yScale: 1.0
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

            width: (index >= (vScrollBar.position)*generationModel.rowCount() - 1 && index <= (vScrollBar.position)*generationModel.rowCount() +verticalVisibleItemCount+ 1) ? parent.width : 0
            visible : (index >= (vScrollBar.position)*generationModel.rowCount() - 1 && index <= (vScrollBar.position)*generationModel.rowCount() +verticalVisibleItemCount+ 1)
            height: cellSize + verticalSpacing

            property int rowIndex: index

            delegate: Item {
                id: columnDelegate

                width: cellSize + horizontalSpacing
                height: cellSize + verticalSpacing

                property int columnIndex: index

                Rectangle {
                    id: cell

                    width: (index >= (hScrollBar.position)*generationModel.columnCount() - 1 && index <= (hScrollBar.position)*generationModel.columnCount() +horizontalVisibleItemCount+ 1) ? calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex) : 0
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
                                if(index_gen == rowDelegate.rowIndex)
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

                    /*Canvas {
                        id: generationCanvas
                        width: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        height: calculateCellSize(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isNew: generationModel.getNew(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isMutated: generationModel.getMutation(rowDelegate.rowIndex, columnDelegate.columnIndex)
                        property bool isCrossing: generationModel.getCrossing(rowDelegate.rowIndex, columnDelegate.columnIndex)

                        onPaint: {
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
                    }*/
                }
            }
        }
    }

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

        onPositionChanged: {
            if (generationView.visible)
                populationView.vScrollBar.position = position
        }
    }

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

        onPositionChanged: {
            if (generationView.visible)
                populationView.hScrollBar.position = position
        }
    }

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
                generationDrawer.currentGeneration = index_gen
                generationDrawer.globalPerformance = 0
                generationDrawer.nbIndividuals = populationModel.columnCount()
                generationDrawer.nbMutations = 0
                generationDrawer.nbCrossovers = 0
                generationDrawer.nbClusters = 0
                generationDrawer.open()
            }
        }
    }

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
        generationView.x = 0
        generationView.y = title.height + viewLayout.spacing + filters.height + viewLayout.spacing

    }

    function generationToIndividualTransition(item) {
        filtersFadeOut.start()
        vScrollBar.visible = false
        hScrollBar.visible = false
        rowIndicator.visible = false
        columnIndicator.visible = false
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
        //return Math.min(cellSize - (cellSize * (Math.abs(rowIndex - vScrollIndicator.position*generationModel.rowCount() - verticalVisibleItemCount/2) - verticalVisibleItemCount/2)), cellSize);
    }
}
