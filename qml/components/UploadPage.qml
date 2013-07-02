import Qt 4.7

Rectangle {
    id: page
    signal uploadToDropbox()
    signal back()
    width: parent.width
    height: parent.height
    color: "#eee"

    MouseArea {
        anchors.fill: parent
        onClicked: { }
    }

    Item {
        id: headerText
        Item {
            width: window.width
            height: 44
            Text {
                text: "Upload your activity:"
                y: 10
                x: 10
                font.bold: true
                font.pixelSize: 22
                color: theme.textColor
            }
        }
    }

    Column {
        y: 50
        x: 10
        width: window.width - 20
        spacing: 10

        BlueButtonEx {
            label: "Dropbox"
            width: parent.width
            height: 50
            onClicked: page.uploadToDropbox()
        }

        BlueButtonEx {
            label: "Map My Tracks"
            width: parent.width
            height: 50
            onClicked: page.uploadToMapMyTracks();
        }

        BlueButtonEx {
            label: "Heia! Heia!"
            width: parent.width
            height: 50
            onClicked: page.uploadToHeiaHeia();
        }

    }

    Rectangle {
        y: window.height - 70
        width: parent.width
        height: 70
        gradient: Gradient {
            GradientStop { color: "#113344"; position: 0.5; }
            GradientStop { color: "#002233"; position: 0.75; }



//            GradientStop { color: "#55AAAA"; position: 0; }
//            GradientStop { color: "#3399AA"; position: 0.6; }
        }

        BlueButtonEx {
            label: qsTr("OK")
            y: 10
            x: 10
            width:  100
            height: 50
            //pressed: friendsList.recentPressed
            onClicked: {
                page.back();
            }
        }
    }


    Rectangle {
        width: parent.width
        height: 10
        color: "#A8CB17"
        y: window.height - 80

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
        y: window.height - 80 - height
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
