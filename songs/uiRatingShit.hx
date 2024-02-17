import flixel.effects.FlxFlicker;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

var timeBarBG:FunkinSprite;
var timeBar:FlxBar;
var shitTween:FlxTween;
public var ratingTxt:FunkinText;
public var numRates:Int = 0;
public var scores:Int = songScore;
public var comboLayer = [];

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
function postCreate(){
    ratingTxt = new FlxText(565, (!curSong == 'freakpunk'? rightBar.y - 25: 590), 0, "");
    ratingTxt.setFormat(Paths.font("akira.ttf"), 30, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    ratingTxt.borderSize = 3;
    ratingTxt.antialiasing = true;
    ratingTxt.alpha = 0.001;

    ratingTxt.cameras = [camHUD];
    
    scoresTxt = new FlxText(590, ratingTxt.y - 25, 0, "");
    scoresTxt.setFormat(Paths.font("akira.ttf"), 30, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    scoresTxt.borderSize = 3;
    scoresTxt.antialiasing = true;
    scoresTxt.alpha = 0.001;

    scoresTxt.cameras = [camHUD];
		
    add(scoresTxt);
    add(ratingTxt);

    for (i in [scoresTxt,ratingTxt]){comboLayer.push(i);}

    for (hud in [scoreTxt,missesTxt,accuracyTxt]){hud.alpha = 0.001;}
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

    ratingTxt.scale.x = FlxMath.lerp(ratingTxt.scale.x, 1, FlxMath.bound(elapsed * 20, 0, 1));
    scoresTxt.scale.x = FlxMath.lerp(scoresTxt.scale.x, 1, FlxMath.bound(elapsed * 20, 0, 1));

    if (flashingCombo > 0) {
        flashingCombo -= elapsed;
        if(flashingCombo <= 0) {
            {
                flashingCombo = 0;
                for (i in comboLayer){
                    FlxFlicker.flicker(i, Conductor.crochet / 1000 * 4, 0.1, true, true, function(flick:FlxFlicker){
                        i.alpha = 0;
                        flashingCombo = 0;
                        songScore = 0;
                    });
                }
            }
        }
    }
}

function onPlayerHit(e){
    if (e.note.isSustainNote) return;

    scores += songScore;

    var rates = e.rating;

    switch(rates){
        case "sick":
            numRates++;
        case "good":
            numRates++;
        case "bad":
            numRates++;
        case "shit":
            numRates++;
    }
    if (numRates > 0) {
        ratingTxt.text = rates + " X" + numRates;
        scoresTxt.text = scores;

        ratingTxt.scale.x += 0.05;
        scoresTxt.scale.x += 0.05;
    }
    for (i in comboLayer){
        FlxFlicker.stopFlickering(i);
        flashingCombo = 0.5;
        i.alpha = 1;
    }
}
function onPlayerMiss(e){
    numRates = 0;
    e.cancelAnim();
}