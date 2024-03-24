import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;

function create(){
    builds = new FlxBackdrop(Paths.image('stages/pollo/images/edificios'),FlxAxes.X , -30, 0);
    builds.velocity.x -= 1800;
    insert(members.indexOf(cielo)+1, builds);
    
    builds2 = new FlxBackdrop(Paths.image('stages/pollo/images/edificios2'),FlxAxes.X , -30, 0);
    builds2.velocity.x -= 900;
    insert(members.indexOf(cielo)+1, builds2);
}

function postCreate(){
    truck.scale.set(1.2,1.2);
    truck.y += 50;

    hench.playAnim("idle", true);
    hench.x -= 700;
    hench.y -= 20;

    truck_bg.y -= 20;

    dad.x -= 100;
    dad.y -= 29;

    boyfriend.x -= 15;
    boyfriend.y -= 15;

    gf.x += 25;

    car.scale.set(1.2, 1.2);
    car.x += 270;
    car.y += 105;

    cielo.y += 100;

    road.scale.set(1.2, 1.22);
    road.y -= 15;

    for (chars in [dad,gf,boyfriend]) chars.alpha = 0.001;
}

function onEvent(e){// don't ask about it
    if (e.event.name == "Intro_Outro Rush"){
        switch (e.event.params[0]){
            case 'Intro':
			FlxG.sound.play(Paths.sound("henchmen"));
            for (henchShit in [hench,truck_bg]){
                FlxTween.tween(henchShit, {x: henchShit.x+1475}, 2.5,
                    {ease:FlxEase.sineInOut,
                        onComplete: function(twn){
                            new FlxTimer().start(0.1355, function(tmr:FlxTimer){
                                camZooming = true;
                                boyfriend.playAnim("intro", true);
                                gf.playAnim("land", true);
                                for (chars in [gf,boyfriend]) {
                                    chars.alpha = 1;
                                }
                            new FlxTimer().start(0.25, function(tmr:FlxTimer){
                                hench.playAnim("shoot", true);
                                FlxG.sound.play(Paths.sound("shoot"));
                                dad.playAnim("intro", true);
                                dad.alpha = 1;
                                camGame.shake(0.015, 0.1);
                                new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                    hench.playAnim("shoot", true);
                                    FlxG.sound.play(Paths.sound("shoot"));
                                    gf.playAnim("aim", true);
                                    camGame.shake(0.015, 0.1);
                                    new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                        hench.playAnim("death", true);
                                        FlxG.sound.play(Paths.sound("shoot"));
                                        gf.playAnim("shoot", true);
                                        camGame.shake(0.015, 0.1);
                                        new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                            gf.playAnim("idle-back", true);
                                        for (henchShit in [hench,truck_bg]){
                                            FlxTween.tween(henchShit, {x: henchShit.x-1475}, 2.5, {ease:FlxEase.expoIn,
                                                onComplete:
                                                function(twn){
                                                    new FlxTimer().start(1.2, function(tmr:FlxTimer){
                                                        hench.playAnim('idle');// plays back to idle
                                                        });
                                                    }});
                                                }});
                                            });
                                        });
                                    });
                                });
                            }});
                        };

            case 'Outro':
                for (crash in [truck_light,truck,gf,boyfriend,dad]){
                    FlxTween.tween(crash, {x: crash.x+2400}, 2, {ease: FlxEase.quartIn});
                }
                FlxTween.tween(car, {x: car.x-425}, 2.5, {ease: FlxEase.sineInOut});
                curCameraTarget = -1;
                FlxG.sound.play(Paths.sound("crash"));
        }
    }

    if (e.event.name == "Hench Shoot"){
        switch(e.event.params[0]){
            case "WASSAP FUCKERS":
                hench.alpha = 1;
                truck_bg.y = 448.5;
                hench.y = 262;
                hench.playAnim('idle');

                FlxG.sound.play(Paths.sound('pium-in'), 0.3);

                for (henchShit in [hench,truck_bg]){
                    FlxTween.tween(henchShit, {x: henchShit.x+1475}, 3, {ease:FlxEase.expoOut});
                    FlxTween.tween(henchShit, {y: henchShit.y+30}, 1, {type: FlxTween.PINGPONG});
                }
                new FlxTimer().start(2, function(tmr:FlxTimer){
                    hench.playAnim('idle');
                    trace('o');
                    gf.playAnim('aim', true);
                    gf.holdTime = 0.5;
                    gf.idleSuffix = '-aim';
                });
            case "shoot":
                FlxG.camera.shake(0.01, 0.1);
                FlxG.sound.play(Paths.sound('shoot'), 0.7);
                hench.playAnim('shoot', true);
                hench.animation.finishCallback = function (name:String) {
                    if (name == 'shoot')
                        hench.playAnim('idle');
                }
            case "man Im ded":
                FlxG.camera.shake(0.01, 0.1);
                for (henchShit in [hench,truck_bg]){
                    FlxTween.cancelTweensOf(henchShit);
                }

                FlxG.sound.play(Paths.sound('shoot'), 1);
                gf.playAnim('shoot', true);
                hench.playAnim('death', true);
                hench.animation.finishCallback = function (name:String) {
                    if (name == 'death'){
                        FlxFlicker.flicker(hench, 1.5, 0.1, true, true, function(flick:FlxFlicker)
                        {
                            hench.alpha = 0.001;
                            gf.playAnim('idle-back', true);
                            gf.idleSuffix = '';

                            FlxG.sound.play(Paths.sound('pium'), 0.2);
                            for (henchShit in [hench,truck_bg]){
                                FlxTween.tween(henchShit, {x: henchShit.x-1475}, 2.5, {ease:FlxEase.expoIn});
                            }
                        });
                    }
                }
        }
    }
}
function stepHit(){
    // cam bopping part
    if (curStep == 1856){
        boyfriend.cameraOffset.x += 175;
    }
    if (curStep == 1872){
        boyfriend.cameraOffset.x -= 175;
    }
}