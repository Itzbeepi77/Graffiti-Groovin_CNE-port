// uhh
import funkin.game.HealthIcon;
import funkin.game.PlayState;
import flixel.math.FlxMath;

var iconOffsets:Array<Array<Float>> = [];

public var icon1:FunkinSprite;
public var icon2:FunkinSprite;

public var swapAnim:Bool = false;

var icon1DoAnim:Bool = true;
var icon2DoAnim:Bool = true;

function update(elapsed:Float){

    var barCenter = leftBar.x + rightBar.width * percent + barOffset.x;

    var iconSep = 26;

    if (curSong != "freakpunk"){

		icon2.x = barCenter - 900 / 2 - iconSep / 2;// - (300) / 2 - iconOffset
		icon1.x = barCenter - 700 / 2 + iconSep / 2;// - (0) / 2 + iconOffset;
    }

    if (curSong == "freakpunk"){
        icon1DoAnim = false;
        icon2DoAnim = false;
    }

    if (curSong == "rushdown" || curSong == "streetstyle"){

		icon2.x = barCenter - 900 / 2 - iconSep / 2;// - (300) / 2 - iconOffset
		icon1.x = barCenter - 900 / 2 + iconSep / 2;// - (0) / 2 + iconOffset;
    }

    // offsets
    for (icon in [icon1, icon2]){
        var offset = iconOffsets[icon.ID];
        icon.x += offset[0];
    }

    if(icon2DoAnim){
        iconAnim = 1-percent < 0.75 ? 'idle' : 'hurt';
        if (lastAnim != iconAnim){
            var _anim:String = '';
            switch(iconAnim){
                case 'idle':
                    _anim = 'hurtToIdle';
                case 'hurt':
                    _anim = 'idleToHurt';
            }
            icon2.playAnim(_anim);
        }
    }
    if(icon1DoAnim){
        iconAnim2 = percent < 0.75 ? 'idle' : 'hurt';
        if (lastAnim2 != iconAnim2){
            var _anim2:String = '';
            switch(iconAnim2){
                case 'idle':
                    _anim2 = 'hurtToIdle';
                case 'hurt':
                    _anim2 = 'idleToHurt';
            }
            icon1.playAnim(_anim2);
        }
    }
    updateAnim();
}

function postCreate() iconP1.visible = iconP2.visible = false;

static function createIcon(character:Character):FunkinSprite {
    var icon = new FunkinSprite();
    icon.ID = iconOffsets.length;

    var path = 'groovin-icons/' + ((character != null) ? character.getIcon() : "bf");
    if (!Assets.exists(Paths.image(path))) path = 'groovin-icons/bf';

    icon.frames = Paths.getSparrowAtlas(path);
    icon.animation.addByPrefix("idle", "icon neutral", 24, true);
    icon.animation.addByPrefix("hurt", "icon losing", 24, true);
    icon.animation.addByPrefix("idleToHurt", "neutral to losing0", 24, false);
    icon.animation.addByPrefix("hurtToIdle", "losing to neutral0", 24, false);
    icon.playAnim("idle");
    icon.setGraphicSize(Std.int(FlxG.width / getSize(character.getIcon())));

    var mothafucka = (StringTools.startsWith(character.curCharacter, 'mora') || StringTools.startsWith(character.curCharacter, 'whitty'));

    icon.flipX = mothafucka? false: !character.isPlayer; icon.updateHitbox();
    icon.cameras = [camHUD]; icon.scrollFactor.set();
    icon.antialiasing = character.antialiasing;

    iconOffsets.push([
        (character != null && character.xml != null && character.xml.exists("iconoffsetx")) ? Std.parseFloat(character.xml.get("iconoffsetx")) : 0,
        (character != null && character.xml != null && character.xml.exists("iconoffsety")) ? Std.parseFloat(character.xml.get("iconoffsety")) : 0
	]);

    return icon;
}

function getSize(char:String = ''):Float{
    return switch(char){
        case 'bf': 1.3;
        case 'mora': 1.4;
        default: 1.6;
    }
}
var iconAnim:String = 'idle';
var lastAnim:String = 'idle';
var iconAnim2:String = 'idle';
var lastAnim2:String = 'idle';

function beatHit(curBeat){
    if (curSong == "freakpunk") return;
    if (iconAnim == "idle"){
        icon2.playAnim("idle");
    } else if (iconAnim == "hurt"){
        icon2.playAnim("hurt");
    }
    
    if (iconAnim2 == "idle"){
        icon1.playAnim("idle");
    } else if (iconAnim2 == "hurt"){
        icon1.playAnim("hurt");
    }
}

public function setHealth(shit:Float) {
    for (icon in [icon1, icon2]){
        iconAnim = switch(icon){
            case icon1: shit < 0.75 ? 'idle' : 'hurt';
            case icon2: shit > 0.75 ? 'idle' : 'hurt';
        }
        if (lastAnim != iconAnim){
            var _anim:String = '';
            switch(iconAnim){
                case 'idle':
                    _anim = 'hurtToIdle';
                case 'hurt':
                    _anim = 'idleToHurt';
            }
            icon.playAnim(_anim);
        }
    }
}

function set_iconAnim(v:String) {
    if(v != iconAnim) {
        iconAnim = v;
        icon.playAnim(iconAnim, false);
        swapAnim = true;
    }
    return iconAnim;
}

function updateAnim(){
    for (icon in [icon1, icon2]){

        if (swapAnim && icon.animation.curAnim.finished){
            swapAnim = false;
            icon.playAnim(switch(icon){
                case icon1: iconAnim2;
                case icon2: iconAnim;
            });
        }
        switch(icon){
            case icon1:
                lastAnim2 = iconAnim2;
            case icon2:
                lastAnim = iconAnim;
        }
    }
}