//a
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;

var sakrlet2 = null;
var skarDrop = null;
var bf2 = null;

function create() {

    sakrlet2 = strumLines.members[0].characters[1];
    skarDrop = strumLines.members[0].characters[2];
    bf2 = strumLines.members[1].characters[1];

    skarDrop.alpha = 0.001;
    sakrlet2.alpha = 0.001;
    bf2.alpha = 0.001;

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
    lights = new FlxBackdrop(Paths.image('stages/philly/images/light'),FlxAxes.X , 0, 600);
    lights.velocity.x -= 7500;
    lights.y = 600;
    lights.scrollFactor.set(0.9,0.9);
    lights.scale.set(1.4,1.4);
    insert(members.indexOf(wall)+1, lights);

    overlay = new FlxBackdrop(Paths.image('stages/philly/images/walloverlay'),FlxAxes.X , 0, 0);
    overlay.velocity.x -= 7500;
    overlay.scrollFactor.set(0.9,0.9);
    overlay.scale.set(4.0,4.0);
    insert(members.indexOf(lights), overlay);

    for (neon in [train2,lights,wall,overlay]){
        neon.alpha = 0.001;
    }

    dropBg.screenCenter();
}

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

function onEvent(e){
    if (e.event.name == "Streetstyle Transition"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            FlxTween.tween(wallTrans, {x: -2500}, 0.2, {
                ease: FlxEase.sineInOut,
                onComplete: 
                function(e)
                {
                    wallTrans.x = 1750;
                }
            });
        }
    }
}
function beatHit(curBeat) {
    if (curBeat == 264){
        dropBg.alpha = 1;
        skarDrop.alpha = 1;
        dad.alpha = 0.001;
        boyfriend.alpha = 0.001;
    }
    if (curBeat == 296){
        skarDrop.alpha = 0.001;
        dropBg.alpha = 0.001;

        for (neon in [bf2,sakrlet2,train2,lights,wall,overlay]){
            neon.alpha = 1;
        }
    }
    if (curBeat == 328 || curBeat == 648){
        for (neon in [bf2,sakrlet2,train2,lights,wall,overlay]){
            neon.alpha = 0.001;
        }
        boyfriend.alpha = 1;
        dad.alpha = 1;
    }
    if (curBeat == 584){
        dad.alpha = 0.001;
        boyfriend.alpha = 0.001;
        for (neon in [bf2,sakrlet2,train2,lights,wall,overlay]){
            neon.alpha = 1;
        }
    }
}