import flixel.FlxCamera;

public var cam3:HudCamera;
function create(){
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(cam3 = new HudCamera(), false);
    cam3.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
}