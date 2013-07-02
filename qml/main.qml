import "components"
import QtQuick 1.0
import com.nokia.meego 1.0
//import com.symbian 1.0
import QtMobility.location 1.1
import "js/script.js" as Script

PageStackWindow {
    initialPage: window
    showToolBar: false

    Rectangle {
        id: window
        anchors.fill: parent
//        width: 360
//        height: 640
        property string lat: ""
        property string lon: ""
        property string path: ""
        property double startTime: 0
        property bool recording: false
        property bool locationAvailable: false

        Component.onCompleted: {
            var activities = ["Running", "Cycling", "Sailing", "Driving",
                              "Walking", "Skiing", "Motor racing", "Canoeing",
                              "Rowing", "Windsurfing", "Kiteboarding",
                              "Orienteering", "Mountaineering", "Skating",
                              "Horse riding", "Hang gliding", "Gliding",
                              "Snowboarding", "Paragliding", "Hot air ballooning",
                              "Miscellaneous"];
            for(var activity in activities) {
                var name = activities[ activity ];
                activityModel.append({ "name" : name });
            }
        }

        ListModel {
            id: activityModel
        }

        CustomTheme {
            id: theme
        }

        PositionSource {
            id: positionSource
            updateInterval: 1000
            active: true
            onPositionChanged: {
                if(signalIcon.visible && positionSource.position.latitudeValid) {
                    signalIcon.visible = false;
                    window.locationAvailable = true;
                }
            }
        }

        Timer {
            id: locationTimer
            interval: 1000
            repeat: true
            onTriggered: {
                if(typeof(positionSource.position.coordinate.latitude)!="undefined") {
                    if(window.recording && positionSource.position.latitudeValid) {
                        // Append file
                        var xml = Script.getXmlPosition(positionSource.position.coordinate.latitude, positionSource.position.coordinate.longitude, positionSource.position.coordinate.altitude);
                        helper.write(window.path, xml);

                        // Update screen
                        var kmh = positionSource.position.speed * 3.6;
                        trackPage.speed = Math.round( kmh );
                        trackPage.time = Script.timeFromStart();
                        trackPage.distance = Script.getCurrentDistance().toFixed(2);
                    }
                }
            }
        }

        UploadPage {
            id: uploadPage
            state: "hidden"
            onBack: {
                mainPage.visible = false;
                startPage.visible = false;
                mainPage.visible = true;
                uploadPage.state = "hidden"
                mainPage.state = "shown";
                trackPage.state = "hidden";
            }
            visible: false
        }

        TrackPage {
            visible: false
            id: trackPage
            state: "hidden"
            onToggle: {
                if(window.recording==false) {
                    window.recording = true;
                    Script.startRecording();
                    var dateStamp = Script.getDateStamp();
                    var xml = Script.getXmlStart();
                    window.path = "trail_" + dateStamp + ".gpx";
                    helper.write(window.path, xml);
                    locationTimer.start();
                } else {
                    window.recording = false;
                    locationTimer.stop();
                    helper.write(window.path, Script.getXmlEnd());

                    uploadPage.visible = true;
                    uploadPage.state = "shown";
                    trackPage.state = "hiddenLeft";
                }
            }
        }

        StartPage {
            id: startPage
            state: "hidden"
            onBack: {
                trackPage.visible = false;
                mainPage.state = "shown"
                startPage.state = "hidden";
            }
            onStart: {
                mainPage.visible = false;
                uploadPage.visible = false;
                trackPage.visible = true;
                startPage.state = "hiddenLeft";
                trackPage.state = "shown";
            }
        }

        MainPage {
            id: mainPage
            state: "shown"
            onStart: {
                uploadPage.visible = false;
                trackPage.visible = false;
                startPage.visible = true;
                startPage.state = "shown";
                mainPage.state = "hiddenLeft";
            }
        }

        Rectangle {
            id: signalIcon
            radius: 6
            color: "#d66"
            width: 32
            height: 32
            x: parent.width - 40
            y: 8
            Image {
                anchors.centerIn: parent
                source: "pics/sat_dish.png"
            }
        }
    }
}
