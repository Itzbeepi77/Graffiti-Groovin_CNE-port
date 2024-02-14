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

function create() {

    // streetstyle
    farBuilds = new FlxBackdrop(Paths.image('stages/philly/images/far buildings'),FlxAxes.X , -30, 0);
    farBuilds.velocity.x -= 900;
    insert(members.indexOf(bg)+1, farBuilds);
    
    buildings = new FlxBackdrop(Paths.image('stages/philly/images/buildings'),FlxAxes.X , -30, 0);
    buildings.velocity.x -= 2700;
    insert(members.indexOf(bg)+2, buildings);
    
    buildsDark = new FlxBackdrop(Paths.image('stages/philly/images/buildings darker'),FlxAxes.X , -10, 0);
    buildsDark.velocity.x -= 3000;
    insert(members.indexOf(bg)+3, buildsDark);
    
    poles = new FlxBackdrop(Paths.image('stages/philly/images/poles'),FlxAxes.X , 0, 0);
    poles.velocity.x -= 4000;
    poles.y = 600;
    insert(members.indexOf(bg)+4, poles);

	ad = new FunkinSprite(3500, 400).loadGraphic(Paths.image('stages/philly/images/ad_tricky'));
	ad.antialiasing = true;
	ad.updateHitbox();
    insert(members.indexOf(buildsDark)+1, ad);
    makeShitInsane(ad, -2500, 1, 1);
    
    // streetstyle neon
    lights = new FlxBackdrop(Paths.image('stages/philly/images/light'),FlxAxes.X , 0, 0);
    lights.velocity.x -= 7500;
    lights.y = 380;
    lights.scrollFactor.set(0.9,0.9);
    lights.scale.set(1.4,1.4);
    insert(members.indexOf(poles)+1, lights);

    overlay = new FlxBackdrop(Paths.image('stages/philly/images/walloverlay'),FlxAxes.X , 0, 0);
    overlay.velocity.x -= 7500;
    overlay.y = -320;
    overlay.scrollFactor.set(0.9,0.9);
    overlay.scale.set(4.0,4.0);
    insert(members.indexOf(poles)+2, overlay);

    dropBg.screenCenter();
}
function update(e){
    if(overlay.x < -2728)
    {
        overlay.x += 2728;
    }
}
function beatHit(curBeat) {}