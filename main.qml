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
            model: 16
            delegate :
                Rectangle {
                id: cell
                height: 100
                width: 100
                color: "lightblue"
                border.color: "cadetblue"
                border.width: 2
                radius: 10
                Text {
                    id:txt
                    text: func.randomNumber()
                    font.pixelSize: 10
                    anchors.centerIn: parent
                }
                visible: (txt.text === "0") ? false : true
            }
        }
    }
    Item {
        id: func
        property var array : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        function randomNumber(){
            var index;
            var tmp;
            index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
            while (array[index] === 16)
                index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
            tmp = array[index];
            array[index] = 16;
            return tmp;
        }
    }
}
