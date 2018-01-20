import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2

Window {
    visible: true
    title: qsTr("15 Puzzle")
    width: 600
    height: 400
    Rectangle {
        width: parent.width - 200
        height: parent.height
        border.width: 2
        ListModel{
            id: appModel
        }
        GridView {

            id: gw
            width: parent.width
            height: parent.height
            model: appModel
            delegate :
                Rectangle {
                id: rect
                height: 100
                width: 100
                color: "lightblue"
                border.color: "cadetblue"
                border.width: 2
                radius: 10
                state: ''
                Text {
                    id:txt1
                    text: txt
                    font.pixelSize: 10
                    anchors.centerIn: parent
                }
                visible: (txt1.text === "0") ? false : true
                MouseArea {
                    onClicked: {
                        check.swap(index)
                    }
                    id: mouseArea
                    anchors.fill: parent
                }
            }
        }
        focus: true;
    }
    Item {
        id: check//TODO Cheange indexes and search by index!
        function swap(index){
            console.log(appModel.get(gw.indexAt(gw.contentItem.children[index].x + 100, gw.contentItem.children[index].y)).index)
//             if (index !== 3 && index !== 7 && index !== 11 && index !== 15 && appModel.get(index + 1).txt === 0)
//             {
//                 console.log("moved")
//                 appModel.move(gw.currentIndex + index, gw.currentIndex + index + 1, 1)
//             }
//             else if (index < 12 && appModel.get(index + 4).txt === 0)
//             {
//                 console.log("moved")
//                 appModel.move(gw.currentIndex + index, gw.currentIndex + index + 4, 1)
//                 appModel.move(gw.currentIndex + index + 3, gw.currentIndex + index, 1)
//             }
//             else if (index !== 1 && index !== 9 && index !== 13 && appModel.get(index - 1).txt === 0)
//             {
//                 console.log("moved")
//                 appModel.move(gw.currentIndex + index + 1, gw.currentIndex + index, 1)
//             }
//             else if (index > 3 && appModel.get(index + 4).txt === 0)
//             {
//                 console.log("moved")
//                 appModel.move(gw.currentIndex + index + 4, gw.currentIndex + index, 1)
//                 appModel.move(gw.currentIndex + index, gw.currentIndex + index + 3, 1)
//             }
        }
    }
    Item {
        id: shuff
        function shuffle(){
            for (var i = 0; i < 16; i++)
                appModel.append({"index": i, "txt": func.randomNumber()})
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

    Button {
        id: button
        x: 453
        y: 21
        text: qsTr("New Game")
        MouseArea {
            onClicked: {
                shuff.shuffle()
                console.log("shuffled")
            }
            anchors.fill: parent
        }
    }
}
