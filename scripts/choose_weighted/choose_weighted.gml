//
//DESC:
//
//https://yal.cc/gamemaker-weighted-choose/#more-1506
//
function choose_weighted() {
    var n = 0;
    for (var i = 1; i < argument_count; i += 2) {
        if (argument[i] <= 0) continue;
        n += argument[i];
    }
    
    n = random(n);
    for (var i = 1; i < argument_count; i += 2) {
        if (argument[i] <= 0) continue;
        n -= argument[i];
        if (n < 0) return argument[i - 1];
    }
    
    return argument[0];
}
