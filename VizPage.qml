import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Page {
    id: vizPage

    property string viewTitle: "POPULATION"

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
                id: popButton
                buttonText: "Population"
                selected: true
                onClicked: {
                    populationView.visible = true ;
                    generationView.visible = false ;
                    clusterView.visible = false ;
                    individualView.visible = false;
                    filters.visible = true;
                }
            }

            ToolBarButton {
                id: genButton
                buttonText: "Generation"
                onClicked:
                {
                    if (individualView.visible) {
                        generationView.individualToGenerationTransition()
                    }
                    else {
                        generationView.resetGenerationView()
                    }
                }
            }

            ToolBarButton {
                id: clusterButton
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
                id: indivButton
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

        ColumnLayout {
            id: viewLayout

            width : parent.width
            height: parent.height

            spacing: 10

            Frame {
                id: title
                z: 1

                Label {
                    text: viewTitle
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

                onVisibleChanged: {
                    if (visible) {
                        viewTitle = "POPULATION"
                        popButton.selected = true
                    }
                    else
                        popButton.selected = false
                }
            }

            GenerationView {
                id: generationView
                visible: false
                onVisibleChanged: {
                    if (visible) {
                        viewTitle = "GENERATION"
                        genButton.selected = true
                    }
                    else
                        genButton.selected = false
                }
            }

            ClusterView {
                id: clusterView
                visible: false
                onVisibleChanged: {
                    if (visible) {
                        viewTitle = "CLUSTER"
                        clusterButton.selected = true
                    }
                    else
                        clusterButton.selected = false
                }
            }

            IndividualView {
                id: individualView
                visible: false
                onVisibleChanged: {
                    if (visible) {
                        viewTitle = "INDIVIDUAL"
                        indivButton.selected = true
                    }
                    else
                        indivButton.selected = false
                }
            }
        }

        InfoDrawer {
            id: populationInfoDrawer

            Item {
                parent: populationInfoDrawer.drawerContent

                Layout.fillHeight: true
            }

            DrawerInfo {
                parent: populationInfoDrawer.drawerContent

                infoTitle: "Global performance"
            }


        }
    }

    NumberAnimation {
        id: filtersFadeOut
        target: filters
        property: "opacity"
        to: 0.0
        duration: 200
        easing.type: Easing.InOutQuad
    }

    NumberAnimation {
        id: filtersFadeIn
        target: filters
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 200
        easing.type: Easing.InOutQuad
    }
}

