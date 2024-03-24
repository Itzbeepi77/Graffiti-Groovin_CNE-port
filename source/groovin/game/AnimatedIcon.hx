// credits to S.D mod team for making the class especially for brussy [ thanks for letting me use it :D ]
// also this class is modified bcuz if not it will be shitty
import flixel.ui.FlxBar;
import Xml;
import haxe.Exception;

class AnimatedIcon extends funkin.backend.FunkinSprite {
	private var songName:String = PlayState.SONG.meta.displayName;
	public var curCharacter:String = 'bf';
	public var danceInterval:Int = 1;
	public var displayHealth:Float = 1;
	public var losing:Bool = false;
	public var moveIcon:Bool = false;

	public var healthBar:FlxBar = null;

	public var debug:Bool = false;

	public var xml:Xml = null;

	public var sprTracker:FlxSprite = null;

	public function new(char:String = 'bf', player:Bool = true, interval:Int = 1, health:FlxBar = null) {
		flipX = char == 'whitty' || char == 'mora' ? false: !player;
		danceInterval = interval;
		healthBar = health;

		switchIcon(char);
	}

	public function switchIcon(char:String = 'bf') {
		curCharacter = char;

		try {
			if (!Assets.exists(Paths.xml('icons/' + char))) throw new Exception(curCharacter + '\'s icon xml doesnt exist');
			xml = Xml.parse(Assets.getText(Paths.xml('icons/' + char))).firstElement();

			frames = Paths.getSparrowAtlas('groovin-icons/' + curCharacter);

			for (node in xml.elements()) {
				animation.addByPrefix(node.get('name'), node.get('anim'), Std.parseFloat(node.get('fps')), node.get('loop') == 'true');
				addOffset(node.get('name'), Std.parseFloat(node.get('x')), Std.parseFloat(node.get('y')));
			}

			playAnim(!losing ? 'normal' : 'losing');
		} catch(e:Exception) {
			trace(e);
			trace('loading placeholder icon for ' + (!flipX ? 'player' : 'opponent'));
			switchIcon('bf');
		}

		antialiasing = true;
	}

	public override function addOffset(name:String, x:Float, y:Float)
		animOffsets[name] = FlxPoint.get(x, y);

	public function update(elapsed:Float) {
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);

		if (healthBar != null) {
			switch(songName){
				default:
					//turn this off to make the health move smoothly
					//x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - (flipX ? width + -50 : 50));
					losing = ((healthBar.percent <= 25 && !flipX) || (healthBar.percent >= 75 && flipX));

				case "freakpunk":
			}
		}
	}

	public function beatHit(curBeat:Int)
		if (curBeat % danceInterval == 0 && !debug)
			playAnim(!losing ? 'normal' : 'losing');
}