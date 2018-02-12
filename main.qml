import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id: window
    visible: true
    visibility: "Maximized"

    minimumWidth: 800
    minimumHeight: 600


    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: menuPage

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
