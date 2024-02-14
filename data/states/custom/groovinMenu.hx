// faq: I modified in more 20 times just to make the shitty menu states working, (not the gallery menu since it so easy to add it lmao)
import funkin.backend.utils.DiscordUtil;
import funkin.backend.scripting.events.DiscordPresenceUpdateEvent;
import discord_rpc.DiscordRpc;
import funkin.menus.MainMenuState;
import funkin.backend.scripting.events.MenuChangeEvent;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.CoolUtil;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.math.FlxMath;
import flixel.FlxCamera;

var camShit:FlxCamera;
var optionShit:Array<String> = [
    'story',
    'freeplay',
    'credits',
    'options',
    'gallery',
];
var curSelected:Int = 0;
var menuItems:FlxTypedGroup<FunkinSprite>;
var menuItems = new FlxTypedGroup();
public var anims:Array<String> = [];
public var canAccessDebugMenus:Bool = true;

function postCreate() {
    FlxG.cameras.add(camShit = new FlxCamera(), false);
    camShit.bgColor = FlxColor.TRANSPARENT;

    CoolUtil.playMenuSong();

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

    var shit:String = FlxG.random.bool(50) ? 'mora' : 'skarlet_small';
    menuChars = new FunkinSprite().loadGraphic(Paths.image("menus/renders/" + shit));
	menuChars.antialiasing = true;
	menuChars.scrollFactor.set(0.07, 0.07);
    menuChars.setGraphicSize(Std.int(menuChars.width * (shit == 'mora' ? 0.554 : 0.6)));
    menuChars.x = FlxG.width - menuChars.width + 80 - (shit == 'mora' ? -170 : -275);
    menuChars.y = FlxG.height - menuChars.height + (shit == 'mora' ? 620 : 515);
    add(menuChars);

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
        if (controls.SWITCHMOD) {
            openSubState(new ModSwitchMenu());
            persistentUpdate = false;
            persistentDraw = true;
        }
        if (controls.UP_P)
            changeItem(-1);

        if (controls.DOWN_P)
            changeItem(1);

        if (controls.ACCEPT)
        {
            selectItem();
        }
        if (controls.BACK)
        {
            FlxG.switchState(new TitleState());
        }
    }
}

function selectItem() {
    var daChoice:String = optionShit[curSelected];
    trace(daChoice + " selected");

    var event = event("onSelectItem", EventManager.get(NameEvent).recycle(daChoice));
    if (event.cancelled) return;
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
        selectedSomethin = true;
        CoolUtil.playMenuSFX("CONFIRM", 0.7);
        switch (daChoice)
        {
            case 'story':// yes also uhh fuck it (WOOHOO THANKS NE_EO!!)
            PlayState.loadWeek({
                    name: "storylmao",
                    id: "storylmao",
                    sprite: null,
                    chars: [null, null, null],
                    songs: [for (song in ["soda-pop","groovin","streetstyle","beat-it"]) {name: song, hide: false}],
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