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

            width : parent.width - individualDrawer.position * individualDrawer.width
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

                        /*Text
                        {
                            text : showSlider.valueAt(showSlider.position)
                            color: "yellow"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 15
                            anchors.bottom: parent
                        }*/
                    }

                    Filter {
                        id: perfFilter
                        filterName: "Performance"

                        FilterSlider {
                            id: perfSlider
                            parent: perfFilter.filterLayout

                            from: 0
                            to: 1

                            background: Rectangle {
                                x: perfSlider.leftPadding
                                y: perfSlider.topPadding + perfSlider.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: perfSlider.availableWidth
                                height: implicitHeight
                                radius: 2
                                color: "transparent"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: parent.height
                                    height: parent.width
                                    rotation: 90
                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: "cyan" }
                                        GradientStop { position: 1.0; color: Qt.lighter("black", 1.5) }
                                    }
                                }
                            }

                            onValueChanged: {

                            }
                        }

                        /*Text
                        {
                            text : perfSlider.valueAt(perfSlider.position)
                            color: "yellow"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 15
                            anchors.bottom: parent
                        }*/
                    }

                    Filter {
                        id: mutationFilter
                        filterName: "Mutations"

                        FilterSlider {
                            id: mutationSlider
                            parent: mutationFilter.filterLayout

                            from: 0
                            to: 30
                        }

                        /*Text
                        {
                            text : mutationSlider.valueAt(mutationSlider.position)
                            color: "yellow"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 15
                            anchors.bottom: parent
                        }*/
                    }

                    Filter {
                        id: crossingFilter
                        filterName: "Crossing-overs"

                        FilterSlider {
                            id: crossingSlider
                            parent: crossingFilter.filterLayout

                            from: 0
                            to: 30
                        }

                        /*Text
                        {
                            text : crossingSlider.valueAt(crossingSlider.position)
                            color: "yellow"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 15
                            anchors.bottom: parent
                        }*/
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

        PopulationDrawer {
            id: populationDrawer
        }

        GenerationDrawer {
            id: generationDrawer
        }

        IndividualDrawer {
            id: individualDrawer
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

