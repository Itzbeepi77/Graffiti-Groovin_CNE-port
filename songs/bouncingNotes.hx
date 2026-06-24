// real codes lmao
// also use direction to do it since noteData is broken, FUCK!
function update(elapsed) {
    var lerpVal:Float = FlxMath.bound(elapsed * 5, 0, 1);
    for (i in playerStrums.members){
        i.y = FlxMath.lerp(i.y, 50, lerpVal);
        //i.angle = FlxMath.lerp(i.angle, 0, lerpVal);
    }
}

function onPlayerHit(e){
    //playerStrums.members[e.direction].y = 50 + (e.note.isSustainNote? -25: -11);
    playerStrums.members[e.direction].y -= 6;
    /*playerStrums.members[e.direction].angle = e.direction == 0 ? -5 : e.direction == 3 ? 5 : 0;
    playerStrums.members[e.direction].noteAngle = 0;*/
}