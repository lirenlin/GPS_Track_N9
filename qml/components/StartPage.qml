import Qt 4.7

Rectangle {
    id: page
    signal back()
    signal start(string activity)
    width: parent.width
    height: parent.height
    color: "#eee"

    MouseArea {
        anchors.fill: parent
        onClicked: { }
    }

    Component {
        id: headerText
        Item {
            width: window.width
            height: 44
            Text {
                text: qsTr("Select your activity:")
                y: 10
                x: 10
                font.bold: true
                font.pixelSize: 22
                color: theme.textColor
            }
        }
    }

    ListView {
        y: 0
        header: headerText
        model: activityModel
        width: parent.width
        height: parent.height - 80
        delegate: friendsListDelegate
        highlightFollowsCurrentItem: true
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
            label: qsTr("Back")
            y: 10
            x: 10
            width:  100
            height: 50
            //pressed: friendsList.recentPressed
            onClicked: {
                page.back();
            }
        }

        Rectangle {
            y: 10
            x: 120
            radius: 6
            smooth: true
            width: parent.width - 130
            height: 50
            color: "#AA1144"
            visible: window.locationAvailable==false
            Text {
                text: qsTr("Waiting for GPS fix...")
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 22
                color: "#E8E5D3"
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

    Component {
        id: friendsListDelegate

        Item {
            id: friendItem
            width: parent.width
            height: 42

            Rectangle {
                id: titleContainer
                color: mouseArea.pressed ? "#ddd" : "#eee"
                y: 0
                width: parent.width
                height: 41

                Column {
                    id: statusTextArea
                    spacing: 4
                    x: 10
                    y: 5
                    width: parent.width - x - 10

                    Text {
                        id: messageText
                        color: theme.textColor
                        font.pixelSize: 30
                        //font.bold: true
                        width: parent.width
                        text: name
                        wrapMode: Text.Wrap
                    }
                }
            }

            Rectangle {
                width:  parent.width - 8
                x: 4
                y: friendItem.height - 1
                height: 1
                color: "#ddd"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    // index
                    page.start( name );
                }
            }

        }
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
