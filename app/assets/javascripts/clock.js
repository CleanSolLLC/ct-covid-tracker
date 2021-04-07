function checkTime(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    // add a zero in front of numbers<10
    m = checkTime(m);
    s = checkTime(s);

    // Choose either "AM" or "PM" as appropriate
    var timeOfDay = ( h < 12 ) ? "AM" : "PM";

    // Convert the hours component to 12-hour format if needed
    h = ( h > 12 ) ? h - 12 : h

    // Convert an hours component of "0" to "12"
    h = ( h == 0 ) ? 12 : h;


    document.getElementById('time').innerHTML = h + ":" + m + ":" + s + " " + timeOfDay;
    t = setTimeout(function () {
        startTime()
    }, 500);
}
