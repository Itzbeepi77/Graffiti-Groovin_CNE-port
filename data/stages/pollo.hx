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
                    {ease: FlxEase.sineInOut,
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
                                            FlxTween.tween(henchShit, {x: henchShit.x-1475}, 5, {ease: FlxEase.quartIn,
                                                onComplete:
                                                function(twn){
                                                    new FlxTimer().start(1.2, function(tmr:FlxTimer){
                                                        hench.playAnim("idle", true);// plays back to idle
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
        if (e.event.params[0] == true || e.event.params[0] == null){// you know what, fuck it
            var timerRandom1 = FlxG.random.float(FlxG.random.float(1.5,3),FlxG.random.float(1.5,0.75));
            var timerRandom2 = FlxG.random.float(FlxG.random.float(1.75,2.5),FlxG.random.float(0.5,0.25));
            var timerRandom3 = FlxG.random.float(FlxG.random.float(1,0.5), FlxG.random.float(0.25,0.5));
            var timerRandom4 = FlxG.random.float(FlxG.random.float(2,1), FlxG.random.float(1.75,2.5));
            
	switch(FlxG.random.int(0,2)){
        case 0:// double/default hench shoot
            for (henchShit in [hench,truck_bg]){
                FlxTween.tween(henchShit, {x: henchShit.x+1475}, timerRandom1,
                    {ease: FlxEase.sineInOut,
                        onComplete: function(twn){
                            new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                hench.playAnim("shoot", true);
                                camGame.shake(0.015, 0.1);
                                new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                    hench.playAnim("shoot", true);
                                    gf.playAnim("aim", true);
                                    camGame.shake(0.015, 0.1);
                                    new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                        hench.playAnim("death", true);
                                        gf.playAnim("shoot", true);
                                        camGame.shake(0.015, 0.1);
                                        new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                            gf.playAnim("idle-back", true);
                                            for (henchShit in [hench,truck_bg]){
                                                FlxTween.tween(henchShit, {x: henchShit.x-1475}, timerRandom4, {ease: FlxEase.quartIn,
                                                    onComplete:
                                                    function(twn){
                                                        new FlxTimer().start(1.2, function(tmr:FlxTimer){
                                                            hench.playAnim("idle", true);// plays back to idle
                                                            });
                                                        }});
                                                    }});
                                                });
                                            });
                                        });
                                    }});
                                };

        case 1:// triple hench shoot
            for (henchShit in [hench,truck_bg]){
                FlxTween.tween(henchShit, {x: henchShit.x+1475}, timerRandom1,
                    {ease: FlxEase.sineInOut,
                        onComplete: function(twn){
                            new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                hench.playAnim("shoot", true);
                                camGame.shake(0.015, 0.1);
                                new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                    hench.playAnim("shoot", true);
                                    camGame.shake(0.015, 0.1);
                                    new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                        hench.playAnim("shoot", true);
                                        gf.playAnim("aim", true);
                                        camGame.shake(0.015, 0.1);
                                        new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                            hench.playAnim("death", true);
                                            gf.playAnim("shoot", true);
                                            camGame.shake(0.015, 0.1);
                                            new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                                gf.playAnim("idle-back", true);
                                                for (henchShit in [hench,truck_bg]){
                                                    FlxTween.tween(henchShit, {x: henchShit.x-1475}, timerRandom4, {ease: FlxEase.quartIn,
                                                        onComplete:
                                                        function(twn){
                                                            new FlxTimer().start(1.2, function(tmr:FlxTimer){
                                                                hench.playAnim("idle", true);// plays back to idle
                                                        });
                                                    }});
                                                }});
                                            });
                                        });
                                    });
                                });
                            }});
                        };

        case 2:// quardraple hench shoot
        for (henchShit in [hench,truck_bg]){
            FlxTween.tween(henchShit, {x: henchShit.x+1475}, timerRandom1,
                {ease: FlxEase.sineInOut,
                    onComplete: function(twn){
                        new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                            hench.playAnim("shoot", true);
                            camGame.shake(0.015, 0.1);
                            new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                hench.playAnim("shoot", true);
                                camGame.shake(0.015, 0.1);
                                new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                    hench.playAnim("shoot", true);
                                    camGame.shake(0.015, 0.1);
                                    new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                        hench.playAnim("shoot", true);
                                        gf.playAnim("aim", true);
                                        camGame.shake(0.015, 0.1);
                                        new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                            hench.playAnim("death", true);
                                            gf.playAnim("shoot", true);
                                            camGame.shake(0.015, 0.1);
                                            new FlxTimer().start(timerRandom3, function(tmr:FlxTimer){
                                                gf.playAnim("idle-back", true);
                                                for (henchShit in [hench,truck_bg]){
                                                    FlxTween.tween(henchShit, {x: henchShit.x-1475}, timerRandom4, {ease: FlxEase.quartIn,
                                                        onComplete:
                                                        function(twn){
                                                            new FlxTimer().start(1.2, function(tmr:FlxTimer){
                                                                hench.playAnim("idle", true);// plays back to idle
                                                        });
                                                    }});
                                                }});
                                            });
                                        });
                                    });
                                });
                            });
                        }});
                    };
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