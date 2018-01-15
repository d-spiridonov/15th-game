import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    title: qsTr("15 Puzzle")
    width: Screen.width / 2
    height: Screen.height / 2
    GridView {
        width: Screen.width / 2
        height: Screen.height / 2
        model: mod
        delegate : MyDel{}
    }
    ListModel {
        id: mod
        ListElement {
            name: "1"
        }
        ListElement {
            name: "2"
        }
        ListElement {
            name: "3"
        }
    }
}
