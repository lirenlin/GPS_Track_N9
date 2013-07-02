import Qt 4.7

Rectangle {
    id: page
    signal start()
    signal archive()
    signal about()
    width: parent.width
    height: parent.height
    color: "#eee"

    MouseArea {
        anchors.fill: parent
        onClicked: { }
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
        id: toolbar
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

            GreenButtonEx {
                label: "Start activity"
                width:  parent.width
                height: 80
                //pressed: friendsList.recentPressed
                onClicked: {
                    page.start();
                }
            }

            GreenButtonEx {
                label: qsTr("Old activities")
                width: parent.width
                height: 80
                onClicked: page.archive();
            }

            Row {
                width: parent.width
                height: 80
                spacing: 10

                BlueButtonEx {
                    label: qsTr("About")
                    width: parent.width/2 - 5
                    height: 80
                    onClicked: page.about();
                }

                BlueButtonEx {
                    label: qsTr("Exit")
                    width: parent.width / 2 - 5
                    height: 80
                    onClicked: Qt.quit();
                }
            }
        }
    }


    Rectangle {
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
        y: toolbar.y - 10 - height
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
