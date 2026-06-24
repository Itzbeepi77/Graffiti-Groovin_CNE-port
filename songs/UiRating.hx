import flixel.effects.FlxFlicker;
import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;

public var numRates:Int = 0;
public var daScore:Int = 0;
public var missNum:Int = 0;
public var comboLayer:FlxSpriteGroup;
var ratingTxt:FlxText;
var numTxt:FlxText;
var missTxt:FlxText;

function postCreate(){
    comboLayer = new FlxSpriteGroup();
    comboLayer.cameras = [camHUD];
    comboLayer.alpha = 0.001;
    add(comboLayer);

    ratingTxt = new FlxText(0, (downscroll? healthBar.y-50 : 80), FlxG.width, "");
    ratingTxt.setFormat(Paths.font("akira.ttf"), 35, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    ratingTxt.borderSize = 3;
    ratingTxt.antialiasing = true;
		
    numTxt = new FlxText(0, (downscroll? ratingTxt.y - 32 : ratingTxt.y + 32), FlxG.width, "");
    numTxt.setFormat(Paths.font("akira.ttf"), 35, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    numTxt.borderSize = 3;
    numTxt.antialiasing = true;
		
    /*missTxt = new FlxText(0, (downscroll? numTxt.y - 32 : numTxt.y + 32), FlxG.width, "");
    missTxt.setFormat(Paths.font("akira.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    missTxt.borderSize = 3;
    missTxt.antialiasing = true;*/
		
    ratingTxt.screenCenter(FlxAxes.X);
    numTxt.screenCenter(FlxAxes.X);
    //missTxt.screenCenter(FlxAxes.X);

    for (bru in [ratingTxt, numTxt]) comboLayer.add(bru);

    for (hud in [scoreTxt,missesTxt,accuracyTxt]){hud.alpha = 0.001;}

    comboGroup.visible = false;
}

var flashingCombo:Float = 0;
function update(elapsed) {
    var lerpVar:Float = FlxMath.bound(elapsed * 20, 0, 1);

    ratingTxt.scale.x = FlxMath.lerp(ratingTxt.scale.x, 1, lerpVar);
    numTxt.scale.x = FlxMath.lerp(numTxt.scale.x, 1, lerpVar);
    /*missTxt.scale.x = FlxMath.lerp(missTxt.scale.x, 1, lerpVar);
    missTxt.alpha = FlxMath.lerp(missTxt.alpha, 0, FlxMath.bound(elapsed * 10, 0, 1));*/

    if (flashingCombo > 0) {
        flashingCombo -= elapsed;
        if(flashingCombo <= 0) {
            {
                flashingCombo = 0;
                FlxFlicker.flicker(comboLayer, Conductor.crochet / 1000 * 4, 0.1, true, true, function(flick:FlxFlicker){
                    comboLayer.alpha = 0;
                    for (i in [numTxt, ratingTxt]) i.alpha = 0;
                    flashingCombo = 0;
                    daScore = 0;
                });
            }
        }
    }
}

var rates:String;
function onPlayerHit(e){
    if (e.note.isSustainNote) return;

    rates = e.rating;

    switch(rates){
        case "sick":
            numRates++;
            daScore += 300;
        case "good":
            numRates++;
            daScore += 200;
        case "bad":
            numRates++;
            daScore += 100;
        case "shit":
            numRates++;
            daScore += 50;
    }
    if (numRates > 0) {
        ratingTxt.text = rates.toUpperCase() + " X" + numRates;
        numTxt.text = daScore;

        for (shit in [ratingTxt, numTxt]) shit.scale.x += 0.05;

        for (i in [numTxt, ratingTxt]) i.alpha = 1;
    }
    FlxFlicker.stopFlickering(comboLayer);
    flashingCombo = 0.5;
    comboLayer.alpha = 1;
}
function onPlayerMiss(e){
    numRates = 0;
    daScore -= 10;
    missNum++;

    /*missTxt.text = "miss: " + missNum;
    missTxt.alpha = 1;*/
    ratingTxt.text = "OOPS...";
    numTxt.text = daScore;

    FlxFlicker.stopFlickering(comboLayer);
    flashingCombo = 0.5;
    comboLayer.alpha = 1;
}