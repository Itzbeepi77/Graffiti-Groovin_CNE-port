import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup;
import groovin.game.AnimatedIcon;

var leftColor:Int = dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : 0xFFFF0000;
var rightColor:Int = boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : 0xFF66FF33;
var losing:Bool = false;
public var playerIcon:AnimatedIcon;
public var opponentIcon:AnimatedIcon;

function onGamePause(event) {
	event.cancel();

	persistentUpdate = false;
	persistentDraw = true;
	paused = true;

	openSubState(new ModSubState('PauseMenu'));
}
function postCreate() {
	camera.zoom = defaultCamZoom;

	FlxG.mouse.visible = false;

	remove(iconP1);
	remove(iconP2);

	if (downscroll){
		rightBar.color = rightColor;
		leftBar.color = leftColor;
	} else if (!downscroll){
		rightBar.color = leftColor;
		leftBar.color = rightColor;
	}

	opponentIcon = new AnimatedIcon(Assets.exists(Paths.image('groovin-icons/' + dad.getIcon())) ? dad.getIcon() : 'bf', false, 1, healthBar);
	playerIcon = new AnimatedIcon(Assets.exists(Paths.image('groovin-icons/' + boyfriend.getIcon())) ? boyfriend.getIcon() : 'bf', true, 1, healthBar);
	for (i in [playerIcon,opponentIcon]) {
		i.scrollFactor.set();
		i.cameras = [camHUD];
		i.y = healthBar.y - (i.height/2);
		insert(members.indexOf(healthBar)+1, i);
		i.scale.set(0.5, 0.5);
	}
	if (!downscroll){
		switch(playerIcon.curCharacter){
			case 'skarlet', 'skarletnikku':
				playerIcon.y -= 30;
		}
		switch(opponentIcon.curCharacter){
			case 'skarlet', 'skarletnikku':
				opponentIcon.y -= 30;
		}
	} else if (downscroll){
		switch(playerIcon.curCharacter){
			case 'skarlet', 'skarletnikku':
				playerIcon.y += 30;
		}
		switch(opponentIcon.curCharacter){
			case 'skarlet', 'skarletnikku':
				opponentIcon.y += 30;
		}
	}

	if (curSong == "soda-pop"){
		danceInterval = 4;
	}
	if (curSong == 'freakpunk'){
		canDie = canDadDie = false;
		
		playerIcon.x += 900;
		playerIcon.y += 100;
		opponentIcon.x += 200;
		for (i in [playerIcon,opponentIcon]) {
			i.y = healthBar.y - (i.height);
		}
	}

	if (curSong == "freakpunk" || curSong == "streetstyle"){
		for (icons in [playerIcon,opponentIcon])
			icons.alpha = 0.001;
	}
}

function onPostCharacterChange(event) {
	var icon:AnimatedIcon = event.strumLine.characters[0].player ? opponentIcon : playerIcon;
	if (event.data.icon != icon.curCharacter && event.strumLine.characters.indexOf(event.data.newCharacter) == 0) {
		icon.switchIcon(event.data.icon);

		if (event.strumLine.characters[0].player) playerIcon = icon;
		else opponentIcon = icon;
	}
	healthBar.createFilledBar((PlayState.opponentMode ? leftColor : rightColor), (PlayState.opponentMode ? rightColor : leftColor));
	healthBar.updateBar();
}

function update(e){
	if (opponentIcon.curCharacter == 'whitty' || opponentIcon.curCharacter == 'mora' && curSong != "freakpunk"){
		losing = ((healthBar.percent <= 25 && opponentIcon.flipX) || (healthBar.percent >= 75 && !opponentIcon.flipX));
		opponentIcon.playAnim(losing ? 'losing' : 'normal');
	}
	player.cpu = FlxG.save.data.botPlay;
}

if(FlxG.save.data.botPlay){
	function onNoteHit(event){
		if (event.note.strumLine.opponentSide) return;
		event.healthGain = 0.045;
	}
}

function destroy()
	FlxG.mouse.enabled = FlxG.mouse.visible = true;