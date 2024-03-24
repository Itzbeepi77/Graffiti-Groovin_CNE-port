// real codes lmao
// also use direction to do it since noteData is broken, FUCK!
function update(elapsed:Float) {
    var lerpVal = FlxMath.bound(elapsed * 5, 0, 1);
    playerStrums.forEach(function(spr:StrumNote){
        spr.y = FlxMath.lerp(spr.y, 50, lerpVal);
    });
}

function onPlayerHit(e){
    //playerStrums.members[e.direction].y = 50 + (e.note.isSustainNote? -25: -11);
    playerStrums.members[e.direction].y -= 6;
}