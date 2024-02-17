import flixel.ui.FlxBar;
import flixel.FlxG;
function onDadHit(e){
	if (PlayState.opponentMode){if (health < 1.8) e.healthGain += 0.02;}
	else
		if (health > 0.2) e.healthGain += 0.02;
}