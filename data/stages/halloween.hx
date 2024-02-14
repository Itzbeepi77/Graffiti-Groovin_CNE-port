public var lightningStrike:Bool = true;
public var lightningStrikeBeat:Int = 0;
public var lightningOffset:Int = 8;
public var thunderSFXamount:Int = 2;

function create() {
    cd = new FunkinSprite(boyfriend.x-325, 608);
    cd.frames = Paths.getSparrowAtlas('cd');
    cd.animation.addByPrefix('idle', 'boombox', 24, false);
	cd.flipX = true;
	cd.scale.set(1.4, 1.4);
    insert(members.indexOf(dad)-1, cd);

    strumLines.members[3].characters[0].x = dad.x +250;
    strumLines.members[3].characters[0].y = dad.y -80;

	camZoomingStrength = 4;

	for(i in 1...thunderSFXamount+1)
		FlxG.sound.load(Paths.sound('thunder_' + Std.string(i)));
	bg.playAnim('idle');
}

var spin = 2;
function update(e){
	if (curStep >= 0 && curStep < 5000){
		var songPos = Conductor.songPosition / 1000;
		camHUD.angle = spin * Math.sin(songPos);
	}
	if (curStep >= 5000){
		camHUD.angle = 0;
	}
}
public function lightningStrikeShit():Void
{
	FlxG.sound.play(Paths.soundRandom('thunder_', 1, thunderSFXamount));
	bg.playAnim('lightning');

	lightningStrikeBeat = curBeat;
	lightningOffset = FlxG.random.int(8, 24);
}

function beatHit(curBeat) {
	if (lightningStrike && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
	{
		lightningStrikeShit();
	}
    cd.playAnim('idle', true);
}