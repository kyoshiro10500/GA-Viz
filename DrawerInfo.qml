import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

/**
  * \brief QML instance : DrawerInfo
  * Basic information inside a drawer
  */
Frame {
    property string infoTitle: "" /** infoTitle : the title of the drawer */
    property string value: "" /** value : the value inside the drawer */

    Layout.fillWidth: true
    Layout.minimumHeight: 100
    Layout.leftMargin: 20
    Layout.topMargin: 15

    padding: 2

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    ColumnLayout {
        Label {
            text: infoTitle
            color: "yellow"
            font.pixelSize: 15
            font.underline: true
        }

        Label {
            text: value
            color: "white"
            font.pixelSize: 30
        }
    }
}
