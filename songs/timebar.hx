import flixel.effects.FlxFlicker;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

public var timeBarBG:FunkinSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText;

function create(){
    timeTxt = new FlxText(0, 19, 400, "X:XX", 32);
    timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    timeBarBG = new FunkinSprite(0, FlxG.height).makeSolid(1, 1, 0xFF000000);
    timeBarBG.setGraphicSize(FlxG.width/3.2, 22);
    timeBarBG.scrollFactor.set();
    timeBarBG.updateHitbox();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height/4.5);
    timeBarBG.alpha = 0;
    add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(0xFF000000,FlxColor.WHITE);
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;
    add(timeBarBG);
    add(timeBar);
    add(timeTxt);
    
    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];
}

function onSongStart() for (i in [timeBar, timeBarBG, timeTxt]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

var flashingCombo:Float = 0;
function update(elapsed) {
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }
}
function onPlayerMiss(e){
    if (e.noteType == "Shadow Note") return;
    
    e.cancelAnim();
}