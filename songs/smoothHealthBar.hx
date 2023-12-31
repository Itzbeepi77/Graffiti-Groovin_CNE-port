import flixel.ui.FlxBar;
import flixel.FlxG;
function postUpdate(elapsed) {
	var mult:Float = FlxMath.lerp(health, health, (health * elapsed * 8));
	health = mult;
}
function onDadHit(e){
	if (PlayState.opponentMode){if (health < 1.8) e.healthGain += 0.02;}
	else
		if (health > 0.2) e.healthGain += 0.02;
}