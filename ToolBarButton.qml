import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ToolButton {
    id: button
    property string buttonText : ""

    Layout.preferredWidth: 150
    Layout.fillHeight: true

    background: Rectangle {
        id: backgroundRect
        anchors.fill: parent

        color: Qt.lighter("#112627", button.hovered ? 2.0 : 1.0)
        border.color: "white"
    }

    Label {
        anchors.fill: parent

        text: buttonText
        font.pixelSize: 15
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
