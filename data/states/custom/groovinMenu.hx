// faq: I modified in more 20 times just to make the shitty menu states working, (not the gallery menu since it so easy to add it lmao)
import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.backend.MusicBeatState;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.math.FlxMath;
import funkin.backend.scripting.Script;

var optionShit:Array<String> = [
    'story',
    'freeplay',
    'credits',
    'options',
    'gallery',
];
var curSelected:Int = 0;
var floatvalve:Float = 0;
var floatvalve2:Float = 0.30;
var floaty:Float = 0;
var floaty2:Float = 0;
var menuItems:FlxTypedGroup<FunkinSprite>;
var menuItems = new FlxTypedGroup();
var skarlet:FunkinSprite;
public var anims:Array<String> = [];
public var canAccessDebugMenus:Bool = true;

function postCreate() {
    CoolUtil.playMenuSong();
    
    DiscordUtil.changePresence("In Main Menu", null);

    var bg:FunkinSprite = new FunkinSprite().loadGraphic(Paths.image('menus/mmbg'));
    bg.scrollFactor.set(0.03, 0.03);
    bg.setGraphicSize(Std.int(bg.width * 0.72));
    bg.updateHitbox();
    bg.screenCenter();
    add(bg);

	var bars:FunkinSprite = new FunkinSprite().loadGraphic(Paths.image('menus/mainmenu/bars'));
	bars.scrollFactor.set(0.006, 0.006);
    bars.screenCenter();
    bars.scale.set(0.7,0.6);
	add(bars);

    var name_:String = FlxG.random.bool(50) ? 'mora' : 'skarlet_small';
    skarlet = new FunkinSprite();
    skarlet.loadGraphic(Paths.image('menus/renders/' + name_));
    skarlet.scrollFactor.set(0.07, 0.07);
    skarlet.setGraphicSize(Std.int(skarlet.width * (name_ == 'mora' ? 0.554 : 0.6)));
    skarlet.updateHitbox();
    skarlet.x = FlxG.width - skarlet.width + 80 - (name_ == 'mora' ? 130 : 0);
    skarlet.y = FlxG.height - skarlet.height + (name_ == 'mora' ? 250 : 210);
    skarlet.antialiasing = true;
    add(skarlet);

    add(menuItems);
    menuItem = new FunkinSprite(70, 39);
    menuItem.scrollFactor.set();
    menuItem.scale.set(0.9, 0.9);
    menuItem.updateHitbox();
    menuItem.frames = Paths.getFrames('menus/mainmenu/menu_options', 'preload');
    for (anim in menuItem.frames.frames){
        var freddyfazbear:Array<String> = anim.name.split('0000');
        menuItem.animation.addByPrefix(freddyfazbear[0], freddyfazbear[0], 24, false);
        anims.push(freddyfazbear[0]);
    }
    menuItems.add(menuItem);

    galleryShit = new FunkinSprite(772, 528);
    galleryShit.frames = Paths.getFrames('menus/mainmenu/gallery', 'preload');
    galleryShit.animation.addByPrefix('base', "gallery0", 24, false);
    galleryShit.animation.addByPrefix('gallery', "gallery press0", 24, false);
    galleryShit.animation.addByPrefix('gallery2', "gallery press20", 24, false);
    galleryShit.animation.play('base');
    menuItems.add(galleryShit);
    galleryShit.scrollFactor.set();
    galleryShit.antialiasing = true;
    galleryShit.updateHitbox();
    galleryShit.scale.set(0.85,0.85);

    changeItem(0);
}

var selectedSomethin:Bool = false;
function update(elapsed:Float) {
    if (FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;

    if (FlxG.sound.music.volume < 0.8)
    {
        FlxG.sound.music.volume += 0.5 * elapsed;
    }

    if (!selectedSomethin) {
        if (canAccessDebugMenus) {
            if (FlxG.keys.justPressed.SEVEN) {
                persistentUpdate = false;
                persistentDraw = true;
                openSubState(new EditorPicker());
            }
        }

        if (controls.UP_P)
            changeItem(-1);

        if (controls.DOWN_P)
            changeItem(1);
        
        if (controls.SWITCHMOD) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }

        if (controls.ACCEPT)
        {
            selectItem();
        }

        if (controls.BACK)
        {
            FlxG.switchState(new TitleState());
        }
    }
    
    var sinvalve = Math.sin(floatvalve);
    var cosvalve = Math.cos(floatvalve);
    var sinvalve2 = Math.sin(floatvalve2);

    floaty += 0.04 * elapsed * 5;
    floaty2 -= 0.009 * elapsed * 5;
    floatvalve += 0.05 * elapsed * 5;
    floatvalve2 -= 0.01 * elapsed * 5;
    skarlet.y += sinvalve * elapsed * 2.5;
    skarlet.x += cosvalve * elapsed * 2.5;
    
    var lerpVal:Float = FlxMath.bound(elapsed*7.5,0,1);
    switch(optionShit[curSelected]){
        case 'story':
            //FlxTween.tween(FlxG.camera.scroll, {x: 420, y:203}, lerpVal);
            FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, 420, lerpVal),lerp(FlxG.camera.scroll.y, 203, lerpVal));
        case 'freeplay':
            //FlxTween.tween(FlxG.camera.scroll, {x: 381, y:353}, lerpVal);
            FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, 381, lerpVal), lerp(FlxG.camera.scroll.y, 353, lerpVal));
        case 'credits':
            //FlxTween.tween(FlxG.camera.scroll, {x: 404, y:532}, lerpVal);
            FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, 404, lerpVal), lerp(FlxG.camera.scroll.y, 532, lerpVal));
        case 'options':
            //FlxTween.tween(FlxG.camera.scroll, {x: 500, y:540}, lerpVal);
            FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, 500, lerpVal), lerp(FlxG.camera.scroll.y, 540, lerpVal));
        case 'gallery':
            //FlxTween.tween(FlxG.camera.scroll, {x: 600, y:540}, lerpVal);
            FlxG.camera.scroll.set(lerp(FlxG.camera.scroll.x, 600, lerpVal), lerp(FlxG.camera.scroll.y, 590, lerpVal));
    }
}

function selectItem() {
    var daChoice:String = optionShit[curSelected];
    trace(daChoice + " selected");

    CoolUtil.playMenuSFX("CONFIRM", 0.7);
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
        selectedSomethin = true;
        switch (daChoice)
        {
            case 'story':// yes also uhh fuck it (WOOHOO THANKS NEEO!!)
            PlayState.loadWeek({
                    name: "storylmao",
                    id: "storylmao",
                    sprite: null,
                    chars: [null, null, null],
                    songs: [for (song in ["soda-pop","groovin","streetstyle","beat-it","rushdown","freakpunk"]) {name: song, hide: false}],
                    difficulties: ['normal']
            }, "normal");
    
                FlxG.switchState(new PlayState());
            case 'freeplay':
                FlxG.switchState(new FreeplayState());
            case 'options':
                FlxG.switchState(new OptionsMenu());
            case 'credits':
                FlxG.switchState(new CreditsMain());
            case 'gallery':
                FlxG.switchState(new ModState("GalleryState"));// yeah. fuck this
        }
    });
}

function changeItem(huh:Int = 0) {
    curSelected += huh;

    if (curSelected >= optionShit.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = optionShit.length - 1;
    
    CoolUtil.playMenuSFX("SCROLL", 0.7);

    var spr = menuItem;

    switch (optionShit[curSelected]){
        case 'gallery':
            spr = galleryShit;
            menuItem.animation.play('base');
        default:
            galleryShit.animation.play('base');
            spr = menuItem;
    }
    spr.animation.play(optionShit[curSelected]);
}
