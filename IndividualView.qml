import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Frame {

    id: individualView

    Layout.preferredWidth: parent.width
    Layout.fillHeight: true

    background: Rectangle {
        color: "black"
        border.color: "black"
    }
      ColumnLayout {
          anchors.fill: parent

          RowLayout {

              Layout.fillWidth: true
              Layout.fillHeight: true
                    Rectangle {
                        color: 'green'
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Text {
                            anchors.centerIn: parent
                            text: 'Individu'
                        }
                    }
          }

          RowLayout {

              Layout.fillWidth: true
              Layout.preferredHeight: 0.2
                    Rectangle {
                        color: "red"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Text {
                            anchors.centerIn: parent
                            text: 'score'
                        }
                    }
          }
      }
  }
