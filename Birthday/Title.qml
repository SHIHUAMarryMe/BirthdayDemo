import QtQuick 2.7


Item{
    id: title;

    property string titleContent: "title";

    width: parent.width;
    height: Math.floor(DeviceHeight/12);

    anchors.top: parent.top;
    anchors.horizontalCenter: parent.horizontalCenter;

    Rectangle{
        width: parent.width;
        height: parent.height;
        color: "red";
        anchors.centerIn: parent;
    }

    Text{
        z: 2;
        anchors.centerIn: parent;
        text: titleContent;
        color: "white";
        font.pointSize: 24;
    }
}
