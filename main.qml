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
            id: gw
            width: parent.width
            height: parent.height
            model: 16
            delegate :
                Rectangle {
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
                MouseArea {
                    onClicked: {
                            checksides.checksides(index + 1)
                    }
                    id: mouseArea
                    anchors.fill: parent
                }
            }
        }
    }
    Item {
        id:checksides
        function checksides(index){
//            var a = gw.contentItem.children[index].children[0].text
//            console.log(index)
//            console.log(a)
            if (index === 1 && gw.contentItem.children[2].children[0].text === "0"){
                gw.contentItem.children[2].children[0].text = gw.contentItem.children[0].children[0].text
                gw.contentItem.children[0].children[0].text = "0"
            }
            else if (index === 1 && gw.contentItem.children[5].children[0].text === "0"){
                gw.contentItem.children[5].children[0].text = gw.contentItem.children[0].children[0].text
                gw.contentItem.children[0].children[0].text = "0"
            }
            else if (index === 2 && gw.contentItem.children[0].children[0].text === "0"){
                gw.contentItem.children[0].children[0].text = gw.contentItem.children[2].children[0].text
                gw.contentItem.children[2].children[0].text = "0"
            }
            else if (index === 5 && gw.contentItem.children[0].children[0].text === "0"){
                gw.contentItem.children[0].children[0].text = gw.contentItem.children[5].children[0].text
                gw.contentItem.children[5].children[0].text = "0"
            }
            else if (index !== 4 && index !== 8 && index !== 12 && index !== 16 && gw.contentItem.children[index + 1].children[0].text === "0"){
                gw.contentItem.children[index + 1].children[0].text = gw.contentItem.children[index].children[0].text
                gw.contentItem.children[index].children[0].text = "0"
            }
            else if (index < 13 && gw.contentItem.children[index + 4].children[0].text === "0"){
                gw.contentItem.children[index + 4].children[0].text = gw.contentItem.children[index].children[0].text
                gw.contentItem.children[index].children[0].text = "0"
            }
            else if (index !== 1 && index !== 9 && index !== 13 && gw.contentItem.children[index - 1].children[0].text === "0"){
                gw.contentItem.children[index - 1].children[0].text = gw.contentItem.children[index].children[0].text
                gw.contentItem.children[index].children[0].text = "0"
            }
            else if (index > 4 && gw.contentItem.children[index - 4].children[0].text === "0"){
                gw.contentItem.children[index - 4].children[0].text = gw.contentItem.children[index].children[0].text
                gw.contentItem.children[index].children[0].text = "0"
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
