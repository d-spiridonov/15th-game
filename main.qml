import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    title: qsTr("15 Puzzle")
    width: 600
    height: 400
    Rectangle {
        id: rec
        width: parent.width - 200
        height: parent.height
        border.width: 2
    GridView {
        width: parent.width
        height: parent.height
        model: MyDel{}
        delegate :
            Rectangle {
            id: cell
            height: 100
            width: 100
            color: "lightblue"
            border.color: "cadetblue"
            border.width: 2
            radius: 10
            visible: (name == 0) ? false : true
            Text {
                text: name
                font.pixelSize: 10
                anchors.centerIn: parent
            }
        }
    }
    }
}
