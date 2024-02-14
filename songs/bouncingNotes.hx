// real codes lmao
// also use direction to do it since noteData is broken, FUCK!
function update(elapsed:Float) {
    /*for (i in playerStrums.members){
        i.y = FlxMath.lerp(50, i.y, FlxMath.bound(1 - elapsed * 9, 0, 1));
    }*/
    var lerpVal = FlxMath.bound(elapsed * 5, 0, 1);
    playerStrums.forEach(function(spr:StrumNote){
        spr.y = FlxMath.lerp(spr.y, 50, lerpVal);
    });
}
function onPlayerHit(e){
        playerStrums.members[e.direction].y = 50 + (e.note.isSustainNote? -25: -11);
}
/*
function onDadHit(e){
        cpuStrums.members[e.direction].y = 50 + -22;
        FlxTween.tween(cpuStrums.members[e.direction], {y: 50}, (e.note.isSustainNote? 0.250: 0.125), {ease: FlxEase.sineInOut});
}

function boundTo(value:Float, min:Float, max:Float) {
    return Math.max(min, Math.min(max, value));
}*/