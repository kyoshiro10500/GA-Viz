import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Page {

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
                onClicked:
                {
                    population.visible = true ;
                    generation.visible = false ;
                    cluster.visible = false ;
                }
            }

            ToolBarButton {
                buttonText: "Generation"
                onClicked:
                {
                    population.visible = false ;
                    generation.visible = true ;
                    cluster.visible = false ;
                }
            }

            ToolBarButton {
                buttonText: "Cluster"
                onClicked:
                {
                    population.visible = false ;
                    generation.visible = false ;
                    cluster.visible = true ;
                }
            }

            ToolBarButton {
                buttonText: "Individual"
                onClicked:
                {

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
                        filterName: "Show"
                        Slider {
                            id: showSlider
                            width: parent.width
                            height: 50
                            from: 1
                            to: 10
                        }
                    }

                    Filter {
                        filterName: "Performance"
                        Slider {
                            id: perfSlider
                            width: parent.width
                            height: 50
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


            PopulationView {id: population
                            visible: true}
            /*PopulationPanel{
                id: populationPanel
                visible: true
            }*/

            GenerationView{id: generation
                            visible: false}
            /*GenerationPanel{
                id: populationPanel
                visible: false
            }*/

            ClusterView{id:cluster
                        visible: false}
            /*ClusterPanel{
              id:clusterPanel
              visible: false
              }*/

        }
    }

    function afficheText()
    {
        if(population.visible)
        {
            return "POPULATION" ;
        }
        else if(generation.visible)
        {
            return "GENERATION" ;
        }
        else if(cluster.visible)
        {
            return "CLUSTER"
        }
    }
}

