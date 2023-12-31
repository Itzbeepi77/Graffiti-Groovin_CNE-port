import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxG;
import funkin.backend.FunkinText;
import flixel.util.FlxAxes;

function create(){
    textShit = new FunkinText(35, 10, 0, "nothing special here go back to menu", 48);
    textShit.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    textShit.scrollFactor.set();
    textShit.borderSize = 3;
    textShit.antialiasing = true;
    add(textShit);
}