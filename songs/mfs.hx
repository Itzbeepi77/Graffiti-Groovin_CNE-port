import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.group.FlxSpriteGroup;
import groovin.game.AnimatedIcon;

var leftColor:Int = dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : 0xFFFF0000;
var rightColor:Int = boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : 0xFF66FF33;
var losing:Bool = false;
static var botPlay:Bool = false;

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

	if (downscroll){
		rightBar.color = rightColor;
		leftBar.color = leftColor;
	} else if (!downscroll){
		rightBar.color = leftColor;
		leftBar.color = rightColor;
	}

    for (newIcon in 0...2){
        var icon = createIcon(newIcon == 1 ? boyfriend : dad);
        add(switch (newIcon) {
            case 1: icon1 = icon;
            case 0: icon2 = icon;
        });
    }

	for (i in [icon1, icon2]){
		switch(i){
			case 0: i.x = 900;
			case 1: i.x = 300;
		}
		i.y = healthBar.y - (i.height/2);
		i.scale.set(0.5, 0.5);
	}

	if (curSong == 'freakpunk'){
		canDie = canDadDie = false;
		
		icon1.x += 600;
		icon2.x -= 150;
		for (i in [icon1,icon2]) {
			i.y = healthBar.y - (i.height/2);
			i.y -= 100;
		}
	}

	if (curSong == "freakpunk" || curSong == "streetstyle"){
		for (icons in [icon1,icon2])
			icons.alpha = 0.001;
	}
}

function update(elapsed:Float){
	player.cpu = botPlay;
}

function onNoteHit(event){
	if (event.note.strumLine.opponentSide) return;
	if(botPlay){
		event.healthGain = 0.045;
	}
}

function destroy()
	FlxG.mouse.enabled = FlxG.mouse.visible = true;