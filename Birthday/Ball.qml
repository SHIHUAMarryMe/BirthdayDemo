import QtQuick 2.7

Image {
    id: ballItem;

    property string balloonSource;
    property string directionX: "right";
    property int durationTime: 2000;
    property int velocityNumber: 200;

    signal hadClicked();

    width: 128;
    height: 128;
    source: balloonSource;
    asynchronous: true;

    SequentialAnimation on x{
        loops: Animation.Infinite;

        NumberAnimation{to: DeviceWidth-128; duration: durationTime;}
        PropertyAction{target: ballItem; property: "directionX"; value: "left";}
        NumberAnimation{to: 32; duration: durationTime;}
        PropertyAction{target: ballItem; property: "directionX"; value: "right";}
    }

    // Make y move with a velocity of 200
    Behavior on y { SpringAnimation{ velocity: velocityNumber; } }

    Component.onCompleted: y = DeviceHeight - 10; // start the ball motion

    // Detect the ball hitting the top or bottom of the view and bounce it
    onYChanged: {
        if (y <= 0) {
            y = DeviceHeight - 20;
        } else if (y >= DeviceHeight - 20) {
            y = 0;
        }
    }


    MouseArea{
        anchors.fill: parent;
        onClicked:{
            hadClicked();
        }
    }
}

