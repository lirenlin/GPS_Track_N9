import QtQuick 1.0
import QtMobility.location 1.2

Rectangle {
    id: page
    width: parent.width
    height: parent.height
    signal toggle()
    property string speed: "-"
    property string time: ""
    property string distance: "-"

    LandmarkModel {
        id: landmarkModelAll
    }

    Map {
        id: map
        plugin : Plugin {name : "nokia"}
        width: parent.width
        height: parent.height/2
        size.width: parent.width
        size.height: parent.height/2
        zoomLevel: 14
        center: positionSource.position.coordinate

//        MapObjectView {
//            id: allLandmarks
//            model: landmarkModelAll
//            delegate: Component {
//                MapCircle {
//                    color: "green"
//                    radius: 1000
//                    center: Coordinate {
//                        latitude: landmark.coordinate.latitude
//                        longitude: landmark.coordinate.longitude
//                    }
//                }
//            }
//        }

        MapCircle {
            id: myPosition
            color: "red"
            radius: 1000
            center: positionSource.position.coordinate
        }
    }

    BorderImage {
        id: listBackground
        source: "../pics/corner-shadow.png"
        width: parent.width; height: parent.height/2
        border.left: 62; border.top: 62
        border.right: 62; border.bottom: 62
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
    }

    Rectangle {
        id: mainPage

        y: window.height/2
        width: parent.width
        height: window.height
        gradient: Gradient {
            GradientStop { color: "#113344"; position: 0.5; }
            GradientStop { color: "#002233"; position: 0.75; }
        }

        Column {
            y: 10
            x: 10
            width: parent.width - 20
            spacing: 10

            Rectangle {
                id: gauge
                smooth: true
                color: "#000"
                width: parent.width
                height: (window.height/2 - 60) / 4
                radius: 10

                Text {
                    color: "#eee"
                    text: page.speed
                    font.pixelSize: parent.height - 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }

                Text {
                    color: "#999"
                    text: "km/h"
                    font.pixelSize: (parent.height - 30)/2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }

            Rectangle {
                color: "#000"
                width: parent.width
                height: gauge.height
                radius: 10
                smooth: true

                Text {
                    font.pixelSize: parent.height - 30
                    text: page.distance;
                    color: "#eee"
                    wrapMode: Text.WrapAnywhere
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }

                Text {
                    color: "#999"
                    text: "km"
                    font.pixelSize: (parent.height - 30)/2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
            }

            Rectangle {
                color: "#000"
                width: parent.width
                height: gauge.height
                radius: 10
                smooth: true

                Text {
                    font.pixelSize: parent.height - 40
                    text: page.time
                    color: "#eee"
                    wrapMode: Text.WrapAnywhere
                    anchors.centerIn: parent
                }
            }

            GreenButtonEx {
                label: window.recording ? qsTr("Stop") : qsTr("Start")
                height: gauge.height
                width: window.width - 20
                onClicked: {
                    page.toggle();
                }
            }

        }


    }

    Rectangle {
        id: greenBar
        width: parent.width
        height: 10
        color: "#A8CB17"
        y: window.height/2 - 10

        Rectangle {
            width: parent.width
            height: 1
            color: "#A8CB17"
            y: 9
        }

        Rectangle {
            width: parent.width
            height: 1
            color: "#888"
        }
    }

    Image {
        id: shadow
        source: "../pics/bottom-shadow.png"
        width: parent.width
        y: greenBar.y - height
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: page
                x: parent.width
            }
        },
        State {
            name: "hiddenLeft"
            PropertyChanges {
                target: page
                x: -parent.width
            }
        },
        State {
            name: "shown"
            PropertyChanges {
                target: page
                x: 0
            }
        }
    ]

    transitions: [
        Transition {
            SequentialAnimation {
                PropertyAnimation {
                    target: page
                    properties: "x"
                    duration: 300
                    easing.type: "InOutQuad"
                }
            }
        }
    ]
}
