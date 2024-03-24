import funkin.backend.utils.FunkinParentDisabler;
import funkin.editors.charter.Charter;
import funkin.options.OptionsMenu;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import groovin.game.AnimatedIcon;

var itemArray:Array<FunkinSprite> = [];
var camPause:FlxCamera;
var menuItems = [];
var curSelected:Int = 0;
var parentDisabler:FunkinParentDisabler;
var pauseMusic:FlxSound;
var wall:FlxSprite;
var render:FunkinSprite;
var levelInfo:FunkinText;
var canSelect:Bool = false;
static var botPlay:Bool = false;

function create() {
	FlxG.state.persistentUpdate = false;
	FlxG.state.persistentDraw = true;
	FlxG.state.paused = true;

	parentDisabler = new FunkinParentDisabler();
	add(parentDisabler);

	pauseMusic = FlxG.sound.load(Paths.music('breakfast'), 0, true);
	pauseMusic.persist = false;
	pauseMusic.group = FlxG.sound.defaultMusicGroup;
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	camPause = new FlxCamera();
	camPause.bgColor = 0x4F000000;
	FlxG.cameras.add(camPause, false);
	FlxTween.cancelTweensOf(camPause);
	camPause.alpha = 0.001;
	camPause.zoom = 2;
	FlxTween.tween(camPause, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut});
	FlxTween.tween(camPause, {zoom: 1}, 2, {ease: FlxEase.expoInOut, 
		onComplete: function(twn:FlxTween){
				canSelect = true;
		}
	});

    wall = new FlxSprite();
    wall.frames = Paths.getSparrowAtlas("game/pause/wall");
    wall.animation.addByPrefix("idle", "wall3", 24);
    wall.animation.play("idle");
    wall.setGraphicSize(0, FlxG.height + 30 + 60);
    wall.updateHitbox();
    wall.antialiasing = true;
    wall.y -= 60;
    wall.x -= 130;
    wall.x += 17;
    wall.scale.set(1.08,1.08);
    wall.cameras = [camPause];
    add(wall);

	var name:String = switch(PlayState.instance.dad.curCharacter) {
		default: PlayState.instance.dad.curCharacter;
		case 'skarletnew' | 'skarletsoda' | 'skarlet-excited': 'skarlet_small';
		case 'skid' | 'pump': 'spooks';
		case 'mora-beat': 'mora';
	};
	var path = Assets.exists(Paths.image('menus/renders/' + name)) ? Paths.image('menus/renders/' + name) : Paths.image('menus/renders/question_mark');
	render = new FunkinSprite().loadGraphic(path);
	render.cameras = [camPause];
	render.zoomFactor = 0.5;
	render.scale.set(720/render.width, 720/render.width);
	render.updateHitbox();
	render.antialiasing = true;
	render.x = render.x + (FlxG.width - render.width + 720);
	render.y = switch(name) {
		default: 0;
		case 'spooks': 100;
		case 'matt', 'henchmen': 200;
		case 'pico': 50;
	};
	add(render);
	FlxTween.tween(render, {x: FlxG.width - render.width}, 2, {ease: FlxEase.expoInOut});

	levelDifficulty = new FunkinText(900, -10 + 32, 0, "DIFFICULTY: " + PlayState.difficulty.toUpperCase(), 32);
    levelDifficulty.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    levelDifficulty.cameras = [camPause];
	levelDifficulty.alpha = 1;
	add(levelDifficulty);

	menuItems = ['resume', 'restart', 'botplay', 'exit'];

	for (index in 0...menuItems.length) {
		var item:FunkinSprite = new FunkinSprite(0,50);
		item.frames = Paths.getSparrowAtlas('game/pause/' + menuItems[index]);
		item.animation.addByPrefix('idle', menuItems[index] + '0', 24, true);
		item.animation.addByPrefix('selected', menuItems[index] + ' white', 24, true);
		item.playAnim('idle', true);
		
		item.scale.set(0.066, 0.066);
		item.updateHitbox();

		item.y = 90 + (169 * index);
		if (menuItems[index] == 'resume') item.offset.y = 240;
		if (menuItems[index] == 'botplay') item.offset.y = 120;
		if (menuItems[index] == 'exit') item.offset.y = 150;

		item.cameras = [camPause];
		add(item);
		itemArray.push({
			sprite: item,
			lerp: 0.4
		});
	}
    
    startTweens();
}
function startTweens()
{
    var time = 2;
    var add = 600;

    wall.x -= add;
    FlxTween.tween(wall, {x: wall.x + add}, time, {ease: FlxEase.expoInOut});
}

function onClose() {
	if (pauseMusic != null)
		FlxG.sound.destroySound(pauseMusic);

	FlxTween.cancelTweensOf(camPause);
	FlxTween.tween(camPause, {alpha: 0.001}, 0.5, {ease: FlxEase.quartInOut, 
		onComplete: function(twn:FlxTween){
			if (FlxG.cameras.list.contains(camPause))
				FlxG.cameras.remove(camPause, true);
		}
	});
}

function update(elapsed:Float) {
	if (controls.BACK) {
		close();
		return;
	}

	if (FlxG.keys.justPressed.P)
		FlxG.switchState(new OptionsMenu());

	if (pauseMusic.volume < 0.5)
		pauseMusic.volume += 0.01 * elapsed;

	function changeItem(value:Int) {
		CoolUtil.playMenuSFX(0, 0.2);

		curSelected = value;
		
		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
	}

	function selectItem(selected:String) {
		switch(selected) {
			case 'resume':
				canSelect = false;
                FlxTween.tween(camPause, {zoom: 6}, 2, {ease: FlxEase.expoInOut,
                    onComplete: function(twn:FlxTween){
                        close();
                        //FlxTween.tween(camPause, {alpha: 0.001}, 0.5, {ease: FlxEase.quartInOut});
                    }
                });
				FlxTween.tween(wall, {x: wall.x -600}, 2, {ease: FlxEase.expoInOut});
				FlxTween.tween(render, {x: render.x+(FlxG.width - render.width)}, 2, {ease: FlxEase.expoInOut});
			case 'restart':
				canSelect = false;
                FlxTween.tween(camPause, {zoom: 6}, 2, {ease: FlxEase.expoInOut,
                    onComplete: function(twn:FlxTween){
						//parentDisabler.reset();
						PlayState.instance.registerSmoothTransition();
						FlxG.resetState();
                        //FlxTween.tween(camPause, {alpha: 0.001}, 0.5, {ease: FlxEase.quartInOut});
                    }
                });
				FlxTween.tween(wall, {x: wall.x -600}, 2, {ease: FlxEase.expoInOut});
				FlxTween.tween(render, {x: render.x+(FlxG.width - render.width)}, 2, {ease: FlxEase.expoInOut});
			case 'botplay':
                botPlay = !botPlay;
                trace("BOTPLAY: " + botPlay);
			case 'exit':
				canSelect = false;
                FlxTween.tween(camPause, {zoom: 6}, 2, {ease: FlxEase.expoInOut,
                    onComplete: function(twn:FlxTween){
						if (PlayState.isStoryMode)
							FlxG.switchState(new MainMenuState());
						if (PlayState.chartingMode)
							FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, false));
						if (!PlayState.isStoryMode && !PlayState.chartingMode)
							FlxG.switchState(new FreeplayState());

                        //FlxTween.tween(camPause, {alpha: 0.001}, 0.5, {ease: FlxEase.quartInOut});
                    }
                });
				FlxTween.tween(wall, {x: wall.x -600}, 2, {ease: FlxEase.expoInOut});
				FlxTween.tween(render, {x: render.x+(FlxG.width - render.width)}, 2, {ease: FlxEase.expoInOut});
		}
	}

	for (i in itemArray) {
		var targetScale:Float = itemArray.indexOf(i) == curSelected ? 0.5 : 0.5;
		i.sprite.scale.set(CoolUtil.fpsLerp(i.sprite.scale.x, targetScale, i.lerp), CoolUtil.fpsLerp(i.sprite.scale.y, targetScale, i.lerp));

		var targetX:Float = itemArray.indexOf(i) == curSelected ? 400 : 300;
		i.sprite.x = CoolUtil.fpsLerp(i.sprite.x, targetX, i.lerp);
        
		var targetAnim:String = itemArray.indexOf(i) == curSelected ? 'selected' : 'idle';
        i.sprite.playAnim(targetAnim);
	}

	if (canSelect){
		if (controls.UP_P)
			changeItem(curSelected == 0 ? menuItems.length-1 : curSelected - 1);
	
		if (controls.DOWN_P)
			changeItem(curSelected == menuItems.length-1 ? 0 : curSelected + 1);
	
		if (controls.ACCEPT){
			selectItem(menuItems[curSelected]);
		}
	}
}