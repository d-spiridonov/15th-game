import QtQuick 2.0
import QtQuick.Window 2.2

Item {
    id: mydel
    Rectangle{
        height: 200
        width: 200
        Text{
            text: name
            font.pixelSize: 12
        }
        border.width: 1
    }
}
