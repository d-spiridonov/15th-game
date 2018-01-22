import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

Window {
    visible: true
    title: qsTr("15 Puzzle")
    width: 600
    height: 400
    Rectangle {
        id: mainwin
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
            cellWidth: gw.width / 4
            cellHeight: gw.height / 4
            model: appModel
            delegate :
                Rectangle {
                id: rect
                height: gw.cellHeight - 3
                width: gw.cellWidth - 3
                color: "lightblue"
                border.color: "cadetblue"
                border.width: 2
                radius: 10
                Text {
                    id:txt1
                    text: txt
                    font.pixelSize: 10
                    anchors.centerIn: parent
                }
                visible: (txt1.text === "0") ? false : true
            }
            MouseArea {
                onClicked: {
                    check.swap(mouseX, mouseY)
                }
                id: mouseArea
                anchors.fill: parent
            }
            move: Transition {
                NumberAnimation { duration: 200; properties: "x,y" }
            }
        }
        focus: true;
    }
    Item {
        id: check
        function swap(mouseX, mouseY){
            if (mouseX < 300 && appModel.get(gw.indexAt(mouseX, mouseY) + 1).txt === 0){
                console.log("moved right");
                appModel.move(gw.indexAt(mouseX, mouseY), gw.indexAt(mouseX, mouseY) + 1, 1);
            }
            else if (mouseY > 100 && appModel.get(gw.indexAt(mouseX, mouseY) - 4).txt === 0){
                console.log("moved up");
                appModel.move(gw.indexAt(mouseX, mouseY), gw.indexAt(mouseX, mouseY) - 4, 1);
                appModel.move(gw.indexAt(mouseX, mouseY) - 3, gw.indexAt(mouseX, mouseY), 1);
            }
            else if (mouseX > 100 && appModel.get(gw.indexAt(mouseX, mouseY) - 1).txt === 0){
                console.log("moved left")
                appModel.move(gw.indexAt(mouseX, mouseY), gw.indexAt(mouseX, mouseY) - 1, 1);
            }
            else if (mouseY < 300 && appModel.get(gw.indexAt(mouseX, mouseY) + 4).txt === 0){
                console.log("moved down")
                appModel.move(gw.indexAt(mouseX, mouseY), gw.indexAt(mouseX, mouseY) + 4, 1);
                appModel.move(gw.indexAt(mouseX, mouseY) + 3, gw.indexAt(mouseX, mouseY), 1);
            }
            if (checkWinner.check() === true)
                winner.visible = true
        }
    }
    Button {
        id: button
        x: 453
        y: 21
        text: qsTr("New Game")
        MouseArea {
            onClicked: {
                if (appModel.count === 0){
                    shuff.shuffle();
                }
                else {
                    appModel.clear();
                    shuff.shuffle();
                }
                console.log("shuffled");
            }
            anchors.fill: parent
        }
    }
    Dialog {
        id: winner
        visible: false

        contentItem: Rectangle {
            color: "lightseagreen"
            implicitWidth: mainwin.width - 100
            implicitHeight: mainwin.height / 4
            border.color: "black"
            Text {
                id: dialogTxt
                text: qsTr("You win!")
                color: "mintcream"
                font.bold: true
                font.family: "Helvetica"
                font.pixelSize: 30
                anchors{top: parent.top; topMargin: 20; right: parent.right; rightMargin: parent.width / 5;
                left: parent.left; leftMargin: parent.width - 200}
            }
            Button{
                id: newGame
                text: qsTr("New Game")
                anchors{top: dialogTxt.bottom;topMargin: 10; left: parent.left; leftMargin: 20}
                height: parent.height / 5
                onClicked: {
                    appModel.clear();
                    shuff.shuffle();
                    winner.close();
                }
            }
            Button{
                id: exit
                text: qsTr("Exit")
                anchors{top: dialogTxt.bottom; topMargin: 10; right: parent.right; rightMargin: 20}
                height: parent.height / 5
                onClicked: {
                    Qt.quit();
                }
            }
        }
    }

    Item {
        id: shuff
        function randomNumber(array){
            var index;
            var tmp;
            index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
            while (array[index] === 16)
                index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
            tmp = array[index];
            array[index] = 16;
            return tmp;
        }
        function randomize(array, tmp){
            for (var i = 0; i < 16; i++)
                array[i] = randomNumber(tmp);
        }
        function shuffle(){
            var array = new Array();
//            while (array.length === 0 || checkvalid.isSolvable(array) === false)
//            {
//                var tmp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
//                randomize(array, tmp);
//            }
            for (var j = 0; j < 16; j++){
                  var tmp = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
                  appModel.append({"txt": tmp[j]});
//                appModel.append({"txt": array[j]});
            }
        }
    }

    Item{
        id: checkWinner
        function check(){
            for (var i = 1; i < 15; ++i){
                if (appModel.get(i).txt < appModel.get(i - 1).txt)
                    return false;
            }
            return true;
        }
    }

    Item{
        id: checkvalid
        function getInvCount(array){
            console.log("begin check valid");
            var inv_count = 0;
            for (var i = 0; i < 15; i++){
                for (var j = i + 1; j < 16; j++){
                    if (array[i] > array[j] && array[i] !== 0 && array[j] !== 0)
                    {
                        console.log("array[i] = " + array[i])
                        console.log("array[j] = " + array[j])
                        inv_count++;
                    }
                }
                console.log("inv_count TMP =" + inv_count);
            }
            return inv_count;
        }

        function findXPosition(array){
            for (var i = 0; array[i] !== 0; i++)
                continue
            if (i < 4)
                return 1;
            else if (i < 8)
                return 2;
            else if (i < 12)
                return 3;
            else if (i < 16)
                return 4;
        }
        function isSolvable(array){
            var invCount = getInvCount(array);
            var pos = findXPosition(array);
            console.log("inv count = " + invCount);
            console.log("inv count = " + pos);
            if ((pos % 2 === 0 && invCount % 2 > 0) || (pos % 2 > 0 && invCount === 0))
                return true;
            else
                return false;
        }
    }
}

