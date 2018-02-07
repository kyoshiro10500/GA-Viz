import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {
    property string filterName: ""

    Layout.preferredWidth: 200
    Layout.fillHeight: true

    padding: 2

    background: Rectangle {
        color: "black"
        border.color: "black"
    }

    Label {
        text: filterName
        color: "yellow"
        font.pixelSize: 15
        font.underline: true
    }
}
