import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup;
import groovin.game.AnimatedIcon;
import flixel.text.FlxTextBorderStyle;
import flixel.math.FlxRect;

var leftColor:Int = dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : 0xFFFF0000;
var rightColor:Int = boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : 0xFF66FF33;
var colors = [leftColor, rightColor];

public var playerIcon:AnimatedIcon;
public var opponentIcon:AnimatedIcon;

function postCreate() {
	FlxG.mouse.visible = false;

	remove(iconP1);
	remove(iconP2);

	opponentIcon = new AnimatedIcon(Assets.exists(Paths.image('groovin-icons/' + dad.getIcon())) ? dad.getIcon() : 'bf', true, 1, healthBar);
	playerIcon = new AnimatedIcon(Assets.exists(Paths.image('groovin-icons/' + boyfriend.getIcon())) ? boyfriend.getIcon() : 'bf', false, 1, healthBar);

	for (i in [playerIcon,opponentIcon]) {
		i.scrollFactor.set();
		i.cameras = [camHUD];
		i.y = healthBar.y - (i.height/2);
		insert(members.indexOf(healthBar)+1, i);
        i.scale.set(0.5, 0.5);
	}
	if (curSong == "soda-pop"){
		danceInterval = 4;
	}
}

function onPostCharacterChange(event) {
	var icon:AnimatedIcon = event.strumLine.characters[0].isDad ? opponentIcon : playerIcon;
	if (event.data.icon != icon.curCharacter && event.strumLine.characters.indexOf(event.data.newCharacter) == 0) {
		icon.switchIcon(event.data.icon);

		if (event.strumLine.characters[0].isDad) opponentIcon = icon;
		else playerIcon = icon;
	}
	healthBar.createFilledBar((PlayState.opponentMode ? colors[1] : colors[0]), (PlayState.opponentMode ? colors[0] : colors[1]));
	healthBar.updateBar();
}

function destroy()
	FlxG.mouse.enabled = FlxG.mouse.visible = true;