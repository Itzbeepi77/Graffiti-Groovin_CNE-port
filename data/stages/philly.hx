//a
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;

function makeShitInsane(object, xThing, timerRandom1, timerRandom2){
    timerShit = FlxG.random.float(timerRandom1, timerRandom2);
    FlxTween.tween(object, {x: xThing}, timerShit, {
        ease: FlxEase.sineInOut,
        onComplete: 
        function(e)
        {
            object.x = 3500;
            makeShitInsane(object, xThing, timerRandom1, timerRandom2);
        }
    });
}

function postCreate() {
    bg.scrollFactor.set(0.2,0.2);
    
    farBuilds = new FlxBackdrop(Paths.image('stages/philly/images/far buildings'),FlxAxes.X , -30, 0);
    farBuilds.velocity.x -= 900;
    insert(members.indexOf(bg)+1, farBuilds);
    
    buildings = new FlxBackdrop(Paths.image('stages/philly/images/buildings'),FlxAxes.X , -30, 0);
    buildings.velocity.x -= 2700;
    insert(members.indexOf(bg)+2, buildings);
    
    buildsDark = new FlxBackdrop(Paths.image('stages/philly/images/buildings darker'),FlxAxes.X , -10, 0);
    buildsDark.velocity.x -= 6000;
    insert(members.indexOf(bg)+3, buildsDark);
    
    poles = new FlxBackdrop(Paths.image('stages/philly/images/poles'),FlxAxes.X , 0, 0);
    poles.velocity.x -= 18900;
    poles.y = 500;
    insert(members.indexOf(bg)+4, poles);

	ad = new FunkinSprite(3500, 200).loadGraphic(Paths.image('stages/philly/images/ad_tricky'));
	ad.antialiasing = true;
	ad.updateHitbox();
    insert(members.indexOf(buildsDark)+1, ad);
    makeShitInsane(ad, -2500, 1, 1);
}
function beatHit(curBeat:Int) {}

function boundTo(value:Float, min:Float, max:Float):Float {
	var newValue:Float = value;
	if(newValue < min) newValue = min;
	else if(newValue > max) newValue = max;
	return newValue;
}