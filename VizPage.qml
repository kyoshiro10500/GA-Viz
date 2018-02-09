import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Page {
    id: vizPage

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    header: ToolBar {
        height: 40

        background: Rectangle {
            color: "#112627"
        }

        RowLayout {
            anchors.fill: parent

            spacing: 0

            Label {
                Layout.preferredWidth: 150
                Layout.fillHeight: true

                text: "GA-Viz"
                font.pixelSize: 20
                color: "yellow"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            ToolBarButton {
                buttonText: "Population"
                onClicked: {
                    populationView.visible = true ;
                    generationView.visible = false ;
                    clusterView.visible = false ;
                    individualView.visible = false;
                    filters.visible = true;
                }
            }

            ToolBarButton {
                buttonText: "Generation"
                onClicked:
                {
                    populationView.visible = false ;
                    generationView.visible = true ;
                    clusterView.visible = false ;
                    individualView.visible = false;
                    filters.visible = true;
                }
            }

            ToolBarButton {
                buttonText: "Cluster"
                onClicked:
                {
                    populationView.visible = false ;
                    generationView.visible = false ;
                    clusterView.visible = true ;
                    individualView.visible = false;
                    filters.visible = true;
                }
            }

            ToolBarButton {
                buttonText: "Individual"
                onClicked:
                {
                    populationView.visible = false ;
                    generationView.visible = false ;
                    clusterView.visible = false ;
                    individualView.visible = true;
                    filters.visible = false;
                }
            }

            ToolBarButton
            {
                buttonText : "New Viz"
                onClicked: stackView.pop()
            }

            ToolBarButton
            {
                buttonText : "Exit"
                onClicked: Qt.quit()
            }

            Item {
                Layout.fillWidth: true
            }
        }
    }

    padding: 10

    RowLayout {
        anchors.fill: parent
        id: view
        property int view: 1
        ColumnLayout {
            width : parent.width
            height: parent.height

            spacing: 10

            Frame {
                Label {
                    id: test
                    text: afficheText()
                    font.pixelSize: 20
                    color: "white"
                }
            }

            Frame {
                id: filters
                Layout.fillWidth: true
                Layout.preferredHeight: 100

                background: Rectangle {
                    color: "black"
                    border.color: "black"
                }

                RowLayout {
                    spacing: 10

                    Label {
                        Layout.preferredWidth: 100
                        Layout.fillHeight: true

                        text: "FILTERS"
                        font.pixelSize: 20
                        color: "yellow"
                    }

                    Filter {
                        id: showFilter
                        filterName: "Show"

                        FilterSlider {
                            id: showSlider
                            parent: showFilter.filterLayout

                            from: 1
                            to: 10
                        }
                    }

                    Filter {
                        id: perfFilter
                        filterName: "Performance"

                        FilterSlider {
                            id: perfSlider
                            parent: perfFilter.filterLayout

                            from: 0
                            to: 1

                            onValueChanged: {

                            }
                        }
                    }

                    Filter {
                        filterName: "Lifetime"
                    }
                }
            }


            PopulationView {
                id: populationView
                visible: true
            }

            GenerationView {
                id: generationView
                visible: false
            }

            ClusterView {
                id: clusterView
                visible: false
            }

            IndividualView {
                id: individualView
                visible: false
            }
        }

        Drawer {
            id: infoDrawer
            edge: Qt.RightEdge
            width: 400
            height: parent.height - vizPage.header.height
            y: vizPage.header.height
            interactive: true
            modal: false

            Rectangle {
                width: 1
                height: parent.height
                x: parent.x - 2
                color: "grey"
            }

            background: Rectangle {
                anchors.fill: parent
                color: "black"
                border.color: "black"
            }

            ColumnLayout {
                anchors.fill: parent

                Label {
                    id: drawerTitle
                    Layout.fillWidth: true

                    text: "DETAILS"
                    color: "white"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                }

                DrawerInfo {
                    id: info1
                }

                Item {
                    Layout.fillHeight: true
                }
            }

            function updateIndividualInfo(rowIndex, columnIndex) {
                info1.infoTitle = "Lifetime"
                // add more info and edit it depending on indexes

                if (position != 1.0)
                    open()
            }

            function updateGenerationInfo(rowIndex) {

            }
        }
    }

    function afficheText()
    {
        if(populationView.visible)
        {
            return "POPULATION" ;
        }
        else if(generationView.visible)
        {
            return "GENERATION" ;
        }
        else if(clusterView.visible)
        {
            return "CLUSTER"
        }
        else if(individualView.visible)
        {
            return "INDIVIDUAL"
        }
    }
}

