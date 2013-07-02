var start;
var lastPoint;
var distance;
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

function startRecording() {
    start = new Date();
    distance = 0.0;
    lastPoint = new Object();
}

function timeFromStart() {
    var diff = (((new Date()).getTime() - start.getTime()) / 1000);
    var seconds = Math.floor(diff) % 60;
    var minutes = Math.floor(diff / 60) % 60;
    var hours   = Math.floor(diff / 3600);
    return leadingZero(hours) + ":" + leadingZero(minutes) + ":" + leadingZero(seconds);
}

function getCurrentDistance() {
    return distance;
}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function getDateStamp() {
    var date = new Date();
    var year = date.getYear();
    if(year<1900) {
        year += 1900;
    }
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = date.getHours();
    var minutes = date.getMinutes();
    return year + "" + leadingZero(month) + "" + leadingZero(day) + "_" + leadingZero(hour) + leadingZero(minutes);
}

function getXmlStart() {
    var x = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><gpx xmlns=\"http://www.topografix.com/GPX/1/1\" version=\"1.1\" creator=\"Poluilla\">";
    x += "<trk><trkseg>";
    return x;
}

function getXmlEnd() {
    var x = "</trkseg></trk></gpx>";
    return x;
}

function getXmlPosition(lat, lon, ele) {
    try {
        if(isNumber(lat)==false || isNumber(lon)==false) {
            return;
        }
        var point = new Object();
        point.lat = lat;
        point.lon = lon;
        if(isNumber(lastPoint.lat)) {
            var dist = getDistance(lat, lon, lastPoint.lat, lastPoint.lon);
            distance += dist;
            if(isNumber(distance)==false) {
                distance = 0.0;
            }
        }
        lastPoint = point;
        var time = new Date().toISOString();
        var x = "<trkpt lat=\"" + lat + "\" lon=\"" + lon + "\">" +
            "<time>" + time + "</time>";
        if(isNumber(ele)) {
            x += "<ele>" + ele + "</ele>";
        }
        x += "</trkpt>";
        return x;
    } catch(ex) {
        return("<err>" + ex + "</err>");
    }
    return "<err />";
}

function getDistance(lat1, lon1, lat2, lon2) {
    var R = 6371.0; // km (change this constant to get miles)
    //console.log("lat1: " + lat1 + " lon1: " + lon1 + " lat2: " + lat2 + " lon2: " + lon2);
    var dLat = (lat2-lat1) * Math.PI / 180.0;
    var dLon = (lon2-lon1) * Math.PI / 180.0;
    //console.log("dLAT: " + dLat + " dLon: " + dLon);
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(lat1 * Math.PI / 180.0 ) * Math.cos(lat2 * Math.PI / 180.0 ) *
    Math.sin(dLon/2) * Math.sin(dLon/2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;
    return d;
    //if (d>1) return Math.round(d)+"km";
    //else if (d<=1) return Math.round(d*1000)+"m";
    //return d;
}



function leadingZero( num ) {
    var n = num.toString();
    if(n.length==1) {
        n = "0" + n;
    }
    return n;
}
