import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtLocation 5.6
import QtPositioning 5.5
import "logic.js" as Logic

Window {
    visible: true
    title: qsTr("15 Puzzle")
    width: 600
    height: 400
    Rectangle{
        id: win
        width: parent.width
        height: parent.height
        visible: true
        color: "powderblue"
    }
    Rectangle {
        id: mainwin
        width: parent.width - parent.width / 4
        height: parent.height
        border.width: 3
        border.color: "grey"
        color: "snow"
        ListModel{
            id: appModel
            ListElement{txt: 1}
            ListElement{txt: 2}
            ListElement{txt: 3}
            ListElement{txt: 4}
            ListElement{txt: 5}
            ListElement{txt: 6}
            ListElement{txt: 7}
            ListElement{txt: 8}
            ListElement{txt: 9}
            ListElement{txt: 10}
            ListElement{txt: 11}
            ListElement{txt: 12}
            ListElement{txt: 13}
            ListElement{txt: 14}
            ListElement{txt: 15}
            ListElement{txt: 0}
        }
        GridView {
            id: gv
            width: parent.width
            height: parent.height
            cellWidth: gv.width / 4
            cellHeight: gv.height / 4
            model: appModel
            delegate :
                Rectangle {
                id: rect
                height: gv.cellHeight - 3
                width: gv.cellWidth - 3
                color: "lightskyblue"
                border.color: "cadetblue"
                border.width: 2
                radius: 10
                Text {
                    id:txt1
                    text: txt
                    font.family: "Helvetica"
                    font.pixelSize: 25
                    anchors.centerIn: parent
                }
                visible: (txt1.text === "0") ? false : true
            }
            MouseArea {
                visible: false
                onClicked: {
                    Logic.swap(gv.indexAt(mouseX, mouseY))
                }
                id: gameArea
                anchors.fill: parent
            }
            move: Transition {
                NumberAnimation { duration: 200; properties: "x,y" }
            }
        }
    }
    Button {
        id: newgame
        anchors{left: mainwin.right; leftMargin: 30; top: mainwin.top; topMargin: 70;
            right: win.right; rightMargin: 30;}
        width: parent.width / 4
        height: parent.height / 5
        Text{
            text: qsTr("New Game")
            anchors.centerIn: parent
            font.family: "Calibri"
            font.bold: true
        }
        MouseArea {
            onClicked: {
                gameArea.visible = true;
                appModel.clear();
                Logic.shuffle();
            }
            anchors.fill: parent
        }
    }
    Button {
        id: quit
        anchors{left: mainwin.right; leftMargin: 30; top: mainwin.top;
            topMargin: 200; right: win.right; rightMargin: 30}
        width: parent.width / 4
        height: parent.height / 5
        Text{
            text: qsTr("Quit")
            anchors.centerIn: parent
            font.family: "Calibri"
            font.bold: true
        }
        MouseArea {
            onClicked: {
                Qt.quit()
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
                anchors.centerIn: parent
            }
            Button{
                id: newGame
                text: qsTr("New Game")
                anchors{top: dialogTxt.bottom;topMargin: 10; left: parent.left; leftMargin: 20}
                height: parent.height / 5
                onClicked: {
                    appModel.clear();
                    Logic.shuffle();
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
}

