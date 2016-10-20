import QtQuick 2.0
import QtMultimedia 5.6
import QtQuick.Controls 2.0
import QtQuick.Particles 2.0


Rectangle{
    id: mainWindow;

    property bool isPlaying: false;
    property bool playOnce: false;

    property int counter: 0;


    width: DeviceWidth;
    height: DeviceHeight;
    color: "black";


    onCounterChanged:{
        if(counter === 4){
            bagImg.visible = true;
            sys.start();
        }
    }


    MediaPlayer{
        id: mediaPlayer;

        audioRole: MediaPlayer.MusicRole;
        source: "qrc:/source/song.mp3";
        volume: 1.0;
    }

    Title{
        id: title;

        z: 2;
        titleContent: qsTr("for __ __");
    }

    Ball{
        id: ball;

        balloonSource: "qrc:/source/Balloon1.png";
        z: 1;
        x: 64;

        onHadClicked:{
            ball.visible = false;
        }

        onVisibleChanged:{
            ++counter;

            ball.destroy(200);
        }
    }


    Ball{
        id: ballTwo;

        balloonSource: "qrc:/source/Balloon2.png";
        durationTime: 3000;
        velocityNumber: 250;
        x: 64;

        onHadClicked:{
            ballTwo.visible = false;
        }

        onVisibleChanged:{
            ++counter;

            ballTwo.destroy(200);
        }
      }

    Ball{
        id: ballThree;

        x: 64;
        durationTime: 3500;
        balloonSource: "qrc:/source/Balloon3.png";

        onHadClicked:{
            ballThree.visible = false;
            ballThree.destroy(200);
        }

        onVisibleChanged:{
            ++counter;

            ballThree.destroy(200);
        }
    }

    Ball{
        id: ballFour;

        x:64;
        durationTime: 4000;
        balloonSource: "qrc:/source/Balloon4.png";
        onHadClicked:{
            ballFour.visible = false;
        }

        onVisibleChanged:{
            ++counter;

            ballFour.destroy(200);
        }
    }

    Image{
        id: bagImg;

        z: 1;
        visible: false;
        asynchronous: true;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: Math.floor(DeviceHeight/10);
        anchors.horizontalCenter: parent.horizontalCenter;
        source: "qrc:/source/bag.png";
    }

    Button{
        id: button;

        text: qsTr("Play");
        width: bagImg.width;
        height: bagImg.height/2;

        anchors.top: bagImg.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 20;


        onClicked:{
            if(isPlaying === false){
                isPlaying = true;
                button.text = qsTr("Pause");
                mediaPlayer.play();
            }else{
                isPlaying = false;
                button.text = qsTr("Play");
                mediaPlayer.pause();
            }
        }
    }


    ParticleSystem{
        id: sys;

        Component.onCompleted:{
            sys.stop();
        }

    }

    ImageParticle{
        id: imgParticle;

        system: sys;
        source: "qrc:/source/candy.png";
        rotationVariation: 360;
    }


    Emitter{
        id: emitter;

        z:2
        system: sys;
        width: bagImg.width;
        height: bagImg.height;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: Math.floor(DeviceHeight/10);
        anchors.horizontalCenter: parent.horizontalCenter;

        size: 64;
        endSize: 128;
        lifeSpan: 2000;
        lifeSpanVariation: 200;
        sizeVariation: 64;
        emitRate: 40;

        velocity: PointDirection{

            x: -50;
            xVariation: 400;
            y: -400;
            yVariation: 50;
        }
    }
}

