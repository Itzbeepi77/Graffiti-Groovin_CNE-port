var nycto = null;

function create(){
    nycto = strumLines.members[0].characters[1];
    nycto.alpha = 0.001;

    dad.x += 35;
    dad.y -= 25;

    boyfriend.y -= 25;

    truck.y += 25;
}
function postCreate(){
    nycto.x = dad.x+75;
    nycto.y = dad.y-2.5;
}

var nyctoIntro:Bool = false;
function onEvent(e){
    if (e.event.name == "nycto intro"){
        if (e.event.params[0] == true || e.event.params[0] == null){
            nyctoIntro = true;
            trace("nycto");
            boyfriend.cameraOffset.x -= 450;
            dad.cameraOffset.x -= 50;
            new FlxTimer().start(1.75, function(tmr:FlxTimer){
                camZoomingInterval = 0;
                camZoomingStrength = 0;
                camZooming = false;
                nycto.playAnim("ascending", true);
                nycto.alpha = 1;
                dad.alpha = 0.001;
                new FlxTimer().start(1, function(tmr:FlxTimer){
                    nycto.idleSuffix = "-one";
                    camGame.zoom += 0.3;
                    camGame.shake(0.03,0.1);
                    camGame.angle = -10;
                    new FlxTimer().start(0.5, function(tmr:FlxTimer){
                        nycto.idleSuffix = "-two";
                        camGame.zoom += 0.3;
                        camGame.shake(0.03,0.1);
                        camGame.angle = 10;
                        new FlxTimer().start(0.5, function(tmr:FlxTimer){
                            nycto.idleSuffix = "-three";
                            boyfriend.cameraOffset.y -= 100;
                            dad.cameraOffset.y -= 100;
                            camGame.zoom += 0.3;
                            camGame.shake(0.03,0.1);
                            camGame.angle = 0;
                            new FlxTimer().start(0.75, function(tmr:FlxTimer){
                                nycto.idleSuffix = "";
                                camZooming = true;
                                dad.cameraOffset.y += 100;
                                boyfriend.cameraOffset.x += 450;
                                boyfriend.cameraOffset.y += 100;
                                camZoomingInterval = 2;
                                camZoomingStrength = 2;
                            });
                        });
                    });
                });
            });
        }
    }
}
function stepHit(curStep){
    if (curStep == 2258){
        nycto.alpha = 0.001;
        dad.alpha = 1;
        dad.cameraOffset.x += 50;
    }
    if (curStep == 2992){
        boyfriend.cameraOffset.x += 100;
    }
    if (curStep == 3049){
        boyfriend.cameraOffset.x -= 100;
    }
    if (curStep == 3056){
        dad.alpha = 1;
    }
    if (curStep == 3000 || curStep == 3078){
        dad.alpha = 0.001;
    }
}