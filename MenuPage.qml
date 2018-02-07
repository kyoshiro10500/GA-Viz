import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.0

Page {
    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ColumnLayout {
        anchors.fill: parent

        Button {
            text: "Load File"
            anchors.centerIn: parent
            onClicked: fileDialog.open()
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        modality: Qt.NonModal

        onAccepted: {
            if (gaviz.parse(fileDialog.fileUrl)) {
                stackView.openVizPage()
            }
        }
        onRejected: {
            console.log("Canceled")
        }
    }
}
