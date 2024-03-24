import flixel.addons.effects.FlxTrail;

var trail:FlxTrail;
var colors = [
    0xff21d6e7,
    0xFFee6ca7,
    0xff21e7cb,
    0xff282741,
    0xffc900cb,
    0xFF55e858,
    0xffe02054
];
function postCreate() {
    if (dad.curCharacter == "nikku"){
        trail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
        //trail.color = 0xffe02054;

        dad.y -= 120;
    
        FlxTween.tween(dad, {y: dad.y +30}, 2, {ease:FlxEase.sineInOut, type:FlxTween.PINGPONG});
    }
}

function onEvent(e){
    if (e.event.name == "NikkuTrail"){
        switch(e.event.params[0]){
            case 'bf':
                trail.color = colors[0];
            case 'nene':
                trail.color = colors[1];
            case 'hex':
                trail.color = colors[2];
            case 'whitty':
                trail.color = colors[3];
            case 'darnell':
                trail.color = colors[4];
            case 'pico':
                trail.color = colors[5];
            case 'none':
                trail.color = colors[6];
        }
        trail.color = trail.color;
    }
}

function update(elpased) {
    if (dad.curCharacter == "nikku"){
        insert(members.indexOf(dad), trail);
        if (dad.animation.curAnim != null && dad.animation.curAnim.name == "idle"){
			trail.color = 0xffe02054;
		}
    }
}