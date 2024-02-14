import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class CircleBG extends FlxSpriteGroup{
    public function new() {
		super(0, 0);
        for (i in 0...5)
        {
            var cirLmao:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/bgcircle'));
            cirLmao.scale.set(2.25, 2.25);
            cirLmao.updateHitbox();
            cirLmao.screenCenter();
            cirLmao.scrollFactor.set();
            cirLmao.alpha = 0;
            cirLmao.blend = 0;
            add(cirLmao);
        }
		scrollFactor.set();
    }
    
    private var circleShit:Float = 0;
    override function update(elapsed:Float) {
        circleShit += elapsed * 0.2;
        if (circleShit > 1) circleShit = 0;
    
        var i:Int = 1;
        for (circle in members){
            var data:Float = circleShit + (0.2 * i);
            if (data > 1) data = data - 1;
    
            var scal:Float = 2.5 - 1.6 * data;
            circle.scale.set(scal, scal);
            circle.alpha = 0.25 * (1 - data);
            i++;
        }
		super.update(elapsed);
	}

	override function set_color(Value:Int):Int
	{
		return color = Value;
	}
}