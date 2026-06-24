import flixel.text.FlxTextBorderStyle;
import funkin.backend.MusicBeatState;
import flixel.util.FlxAxes;
import funkin.backend.utils.DiscordUtil;
import funkin.menus.TitleState;
import flixel.effects.FlxFlicker;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxText;
import flixel.FunkinText;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;

static var skippedIntro:Bool = false;
var transitioning:Bool = false;
var initialized:Bool = false;

var render_anims:Array<String> = [];

var curWacky:Array<String> = [];

static var charOffsets = [
  //"character" => [offsetX, OffsetY, scale];
  'skarlet' => [90, -4, 1.2, 0],
  'mora' => [200, -116, 1.1, 1],
  'nikku' => [424, 149, 1.4, 1],
  'nene' => [199, 167, 2.1, 0],
  'whitty' => [787, 45, 1.5, 1],
  'hex' => [174, 101, 1.5, 0],
  'henchmen' => [460, 80, 1.4, 1]
];

var idfk = [];

var camBG:FlxCamera;
var camHUD:FlxCamera;
var camText:FlxCamera;

var floatvalve:Float = 0;
var floatvalve2:Float = 0.30;
var floaty:Float = 0;
var floaty2:Float = 0;
var textGroup:FlxGroup;
var videoSprite:FlxSprite;
var renders:FlxSprite;
var logoBl:FlxSprite;
var ngSpr:FlxSprite;
var titleText:FlxSprite;
var blackScreen:FlxSprite;
var borderTop:FlxSprite;
var borderBottom:FlxSprite;
var text_a, text_b:FunkinText;

function create() {

	camBG = new FlxCamera();
	camHUD = new FlxCamera();
	camHUD.bgColor = 0;
	camText = new FlxCamera();
	camText.bgColor = 0;
	
	FlxG.cameras.reset(camBG);
	FlxG.cameras.add(camHUD, false);
	FlxG.cameras.add(camText, false);

	DiscordUtil.changePresence('Scrolling Through Menus...', "Title Screen");
	//CoolUtil.playMenuSong(true);
	
	curWacky =  FlxG.random.getObject(getIntroTextShit());

	/*new FlxTimer().start(0.3, function(tmr:FlxTimer)
	{
		startIntro();
	});*/

	camBG.visible = false;
	//camHUD.visible = false;

	if (!initialized)
	{
		new FlxTimer().start(1.3, function(tmr:FlxTimer)
		{

			camText.fade(FlxColor.BLACK, 1, true);
				
			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
	
				FlxG.sound.music.fadeIn(4, 0, 0.7);
			}
		});	
	}
	
	Conductor.changeBPM(134);
	persistentUpdate = true;

	textGroup = new FlxGroup();

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/skyy'));
	bg.setGraphicSize(Std.int(bg.width + 100));
	bg.updateHitbox();
	bg.screenCenter();
	bg.antialiasing = true;
	bg.scrollFactor.set(0.1, 0.1);
	bg.y -= 100;
	add(bg);
  
	var buildingsfar:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/buildings_far'));
	buildingsfar.setGraphicSize(Std.int(buildingsfar.width + 100));
	buildingsfar.updateHitbox();
	buildingsfar.screenCenter();
	buildingsfar.antialiasing = true;
	buildingsfar.scrollFactor.set(0.3, 0.3);
	add(buildingsfar);
  
	var buildings:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/buildings'));
	buildings.setGraphicSize(Std.int(buildings.width + 100));
	buildings.updateHitbox();
	buildings.screenCenter();
	buildings.antialiasing = true;
	buildings.scrollFactor.set(0.8, 0.8);
	buildings.y += 100;
	add(buildings);
  
	var sunoverlay:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/sunoverlay'));
	sunoverlay.setGraphicSize(Std.int(sunoverlay.width + 100));
	sunoverlay.updateHitbox();
	sunoverlay.screenCenter();
	sunoverlay.antialiasing = true;
	sunoverlay.scrollFactor.set(0.1, 0.1);
	sunoverlay.scale.set(0.8, 0.8);
	sunoverlay.blend = "ADD";
	sunoverlay.y -= 145;
	add(sunoverlay);

	borderTop = new FlxSprite();
	borderBottom = new FlxSprite();
	for(i=>bar in [borderTop, borderBottom]) {
		bar.loadGraphic(Paths.image('menus/titlescreen/bars'));
		bar.setGraphicSize(FlxG.width, FlxG.height);
		bar.updateHitbox();
		bar.screenCenter();
		bar.antialiasing = true;
		bar.scrollFactor.set();
		bar.camera = camHUD;
		bar.clipRect = new FlxRect(0, bar.frameHeight / 2 * i, bar.frameWidth, bar.frameHeight / 2);
		add(bar);
	}
	borderTop.x -= FlxG.width;
	borderBottom.x += FlxG.width;
  
	logoBl = new FlxSprite();
	logoBl.frames = Paths.getSparrowAtlas('menus/titlescreen/logo');
	logoBl.antialiasing = true;
	logoBl.animation.addByPrefix('bump', 'gg 1 logo animated', 24, false);
	//logoBl.animation.play('bump');
	logoBl.updateHitbox();
	logoBl.scale.set(0.3, 0.3);
	logoBl.scrollFactor.set();
	logoBl.screenCenter();
	logoBl.y -= 40;
	logoBl.camera = camHUD;
	logoBl.alpha = 0.001;
	add(logoBl);
  
	titleText = new FlxSprite(290, 576);
	titleText.frames = Paths.getSparrowAtlas("menus/titlescreen/titleEnter");
	titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
	titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
	titleText.antialiasing = true;
	titleText.animation.play('idle');
	titleText.scale.set(0.7, 0.7);
	titleText.updateHitbox();
	titleText.alpha = 0.0001;
	titleText.y -= 40;
	titleText.scrollFactor.set();
	titleText.camera = camHUD;
	titleText.screenCenter(FlxAxes.X);
	add(titleText);
	
	/*if(skippedIntro) return;
	blackScreen = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
	add(blackScreen);*/

	textGroup.camera = camText;
	add(textGroup);
  
	renders = new FlxSprite();
	renders.frames = Paths.getSparrowAtlas('menus/titlescreen/renderIntro');
	for (anim in renders.frames.frames){
	  var freddyfazbear:Array<String> = anim.name.split('0000');
	  renders.animation.addByPrefix(freddyfazbear[0], freddyfazbear[0], 24, false);
	  render_anims.push(freddyfazbear[0]);
	}
	renders.antialiasing = true;
	renders.alpha = 0.001;
	renders.camera = camHUD;
	add(renders);

	text_a = new FunkinText(0, 319, FlxG.width, "", 32, true);
	text_a.setFormat("fonts/akira.ttf", 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	text_a.scrollFactor.set();
	text_a.screenCenter(FlxAxes.X);
	textGroup.add(text_a);

	text_b = new FunkinText(0, text_a.y + 50, FlxG.width, "", 40, true);
	text_b.setFormat("fonts/akira.ttf", 40, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	text_b.scrollFactor.set();
	text_b.screenCenter(FlxAxes.X);
	textGroup.add(text_b);

	idfk.push(text_a.y);
	idfk.push(text_b.y);
  
	videoSprite = new FlxSprite();
	videoSprite.frames = Paths.getSparrowAtlas('menus/titlescreen/bgvid20');
	videoSprite.animation.addByPrefix('loop', 'bgvid', 20, true);
	videoSprite.animation.play('loop');
	videoSprite.setGraphicSize(Std.int(videoSprite.width * 2));
	videoSprite.screenCenter();
	videoSprite.antialiasing = true;
	videoSprite.alpha = 0.001;
	videoSprite.blend = "ADD";
	videoSprite.camera = camText;
	add(videoSprite);

	var black_bar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 80, FlxColor.BLACK);
	black_bar.camera = camText;
	var black_bar_b:FlxSprite = new FlxSprite(0, FlxG.height - 80).makeGraphic(FlxG.width, 80, FlxColor.BLACK);
	black_bar_b.camera = camText;
	add(black_bar);
	add(black_bar_b);

	ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('menus/titlescreen/newgrounds_logo'));
	add(ngSpr);
	ngSpr.visible = false;
	ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
	ngSpr.updateHitbox();
	ngSpr.screenCenter(FlxAxes.X);
	ngSpr.antialiasing = true;
	ngSpr.camera = camHUD;

	if (initialized)
		skipIntro();
	else
		initialized = true;
	//Paths.clearUnusedMemory();
}

function characterIntro(char:String) {
	FlxTween.cancelTweensOf(renders);
	renders.animation.play(char);
	var sprite_data = charOffsets[char];
  
	var upset:Float = -300;
	if (sprite_data[3] == 1) upset = 400;
  
	renders.setPosition(sprite_data[0] + upset, sprite_data[1]);
	renders.scale.set(sprite_data[2], sprite_data[2]);
  
	FlxTween.tween(renders, {x: sprite_data[0]}, 0.8, {ease:FlxEase.expoOut, onComplete: function (_) {
		FlxTween.tween(renders, {x:sprite_data[3] == 1 ? -FlxG.width - 200 : FlxG.width + 200}, 1, {ease:FlxEase.expoInOut});
	}});
}

function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('titlescreen/introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}
	
	function textIntro(text:String = '', cur:Int = 0, out:Bool = false) {
		if (out){
			for (i in 0...textGroup.length){
				FlxTween.tween(renders, {alpha: 1}, 0.5);
				FlxTween.tween(textGroup.members[i], {y: idfk[i] + FlxG.height}, 0.5 + (i * 0.2), {ease:FlxEase.expoIn});
			}
			return;
		}

		var curText:FunkinText;
		if (cur == 0) curText = text_a;
		else curText = text_b;

		//FlxTween.tween(renders, {alpha: 0.5}, 1);

		curText.scale.set(1.0, 1.0);
		curText.text = text;
		curText.screenCenter(FlxAxes.X);
		curText.y = idfk[cur] + FlxG.height;
			
		/*for (i in 0...textGroup.length){
			textGroup.members[i].y = curText.y;
		}*/

		FlxTween.tween(curText, {y: idfk[cur] - (FlxG.height/24)}, 0.5, {ease:FlxEase.expoOut});
		FlxTween.tween(curText.scale, {x: curText.scale.x + 0.5, y: curText.scale.y + 0.5}, 1, {ease:FlxEase.expoOut});
	}

var sickBeats:Int = 0;
var closedState:Bool = false;
function beatHit(curBeat:Int){

	if(logoBl != null)
		logoBl.animation.play('bump', true);

	if(borderTop != null && curBeat % 2 == 0) {
		borderTop.y -= 10;
		borderBottom.y += 10;
		FlxTween.tween(borderTop, {y:0}, 0.2, {ease:FlxEase.cubeIn});
		FlxTween.tween(borderBottom, {y:0}, 0.2, {ease:FlxEase.cubeIn});
	}

	if(!closedState) {
		sickBeats++;

		switch (sickBeats)
		{
      	case 1:
        	videoSprite.alpha = 0.4;
        	renders.alpha = 1;
      	case 2:
        	if (!skippedIntro) characterIntro('henchmen');
      	case 4:
        	if (!skippedIntro) characterIntro('skarlet');
      	case 8:
			if (!skippedIntro) {
    	    	ngSpr.visible = true;
        		ngSpr.y += 300;
        		ngSpr.alpha = 0;
        		ngSpr.scale.set(0.4, 0.4);
       			ngSpr.screenCenter(FlxAxes.X);

        		FlxTween.tween(ngSpr, {alpha: 1, y: ngSpr.y - 450}, 1.5, {ease:FlxEase.expoOut});
        		FlxTween.tween(ngSpr.scale, {x: 0.8, y: 0.8}, 1.5, {ease:FlxEase.expoOut});
			}
      	case 12:
        	if (!skippedIntro) textIntro(curWacky[0], 0);	
        	if (!skippedIntro) FlxTween.tween(ngSpr, {alpha: 1, y: ngSpr.y + 450}, 1, {ease:FlxEase.expoInOut});
      	case 14:
        	if (!skippedIntro) textIntro(curWacky[1], 1);
      	case 16:
       		if (!skippedIntro) characterIntro('nikku');
			if (!skippedIntro) textIntro('', 0, true);
    	case 20:
        	if (!skippedIntro) characterIntro('mora');
    	case 24:
	        if (!skippedIntro) characterIntro('hex');
    	case 28: 
        	if (!skippedIntro) characterIntro('whitty');
      	case 30:
        	if (!skippedIntro) textIntro('GRAFFITI', 0);
      	case 31:
        	if (!skippedIntro) textIntro("GROOVIN'", 1);
      	case 32:
    	    skipIntro();
		}
	}
}

function skipIntro() {
	if (!skippedIntro) {
		FlxTween.cancelTweensOf(renders);
		remove(renders);
		remove(ngSpr);
		remove(textGroup);
		remove(blackScreen);
		remove(videoSprite);
		FlxG.camera.flash(FlxColor.WHITE, 2);
		skippedIntro = true;
		camBG.visible = true;
		camHUD.visible = true;
		camHUD.flash(FlxColor.WHITE, 1);
		camBG.zoom = 1.5;
			new FlxTimer().start(0.1, function(tmr:FlxTimer) {
				// this is utterly retarded
				FlxTween.tween(camBG, {zoom: 1}, 0.2);
				FlxTween.tween(logoBl.scale, {x: 0.4, y: 0.4}, 0.2, {ease:FlxEase.backInOut, onUpdate:function(twn:FlxTween){
						logoBl.updateHitbox();
						logoBl.screenCenter();
					}, onComplete:function(twn:FlxTween){
						titleText.alpha = 1;
					}
				});
				new FlxTimer().start(0.3, function(tmr:FlxTimer) {
					FlxTween.tween(borderTop, {x:0}, 0.2, {ease:FlxEase.cubeIn});
					FlxTween.tween(borderBottom, {x:0}, 0.2, {ease:FlxEase.cubeIn});
				});
			});

		titleText.alpha = 1;
		logoBl.alpha = 1;
	}
}

function update(elapsed:Float) {
	var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

	if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;

	if (pressedEnter) {
		if (!skippedIntro)
			skipIntro();
		else if (!transitioning)
			pressEnter();
	}
    
    var sinvalve = Math.sin(floatvalve);
    var cosvalve = Math.cos(floatvalve);
    var sinvalve2 = Math.sin(floatvalve2);

    floaty += 0.04 * elapsed * 5;
    floaty2 -= 0.009 * elapsed * 5;
    floatvalve += 0.05 * elapsed * 5;
    floatvalve2 -= 0.01 * elapsed * 5;
    
    var lerpVal:Float = FlxMath.bound(elapsed*7.5,0,1);
	
    var i = (Conductor.songPosition) / 1000;

	FlxG.camera.angle = cosvalve;
    FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, FlxG.camera.scroll.x + (Math.sin(floatvalve2*20)), lerpVal),lerp(FlxG.camera.scroll.y, FlxG.camera.scroll.y + (Math.cos(floatvalve*20)), lerpVal));
}

function pressEnter() {
	titleText.animation.play('press');

	camHUD.flash(FlxColor.WHITE, 1);
	FlxG.camera.fade(FlxColor.BLACK, 1);
	CoolUtil.playMenuSFX("CONFIRM", 0.7);

	transitioning = true;
	// FlxG.sound.music.stop();

	new FlxTimer().start(seenMenuCutscene ? 1.2 : 1.4, (_) -> 	FlxG.switchState(new MainMenuState()));

	FlxTween.tween(titleText, {y: titleText.y + (FlxG.height*1.4)}, 2, {ease: FlxEase.circInOut});

	MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = !seenMenuCutscene;
}