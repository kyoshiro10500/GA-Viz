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

    FontLoader { id: titleFont; source: "/Mont-HeavyDEMO.otf" }

    ColumnLayout {
        anchors.fill: parent

        spacing: 30

        LoadingScreen {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                anchors.centerIn: parent

                text: "GA-VIZ"
                color: "white"
                font { family: titleFont.name; pixelSize: 80; capitalization: Font.Capitalize }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30

            ToolBarButton {
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredHeight: 50
                Layout.fillHeight: false
                buttonText: "Load file"
                onClicked: fileDialog.open()
            }

            ToolBarButton {
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredHeight: 50
                Layout.fillHeight: false
                buttonText: "Quit"
                onClicked: Qt.quit()
            }
        }

        Item { Layout.preferredHeight: 30 }
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
