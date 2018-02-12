import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.0

/**
  * \brief QML instance : main
  * The main view of the app.
  * Begin on the selection menu then go to the visualization
  */
ApplicationWindow {
    id: window
    visible: true
    visibility: "Maximized"

    minimumWidth: 800
    minimumHeight: 600


    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: menuPage //We begin on the menu

        Component {
            id: menuPage
            MenuPage {}
        }

        Component {
            id: vizPage
            VizPage {}
        }

        function openVizPage() {
            stackView.push(vizPage)
        }
    }
}
