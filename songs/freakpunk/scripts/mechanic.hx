// this is it..

var dodgeing = false;
var isDad:Bool = true;

var circMech:FunkinSprite = new FunkinSprite(360,200);

function postCreate() {

    // battle sprite
    circMech.frames = Paths.getSparrowAtlas('stages/fightuwu/images/battleSystem/battleHud');
    circMech.animation.addByPrefix('intro', 'intro', 24, false);
    circMech.animation.addByPrefix('one', 'one', 24, false);
    circMech.animation.addByPrefix('two', 'two', 24, false);
    circMech.animation.addByIndices('confirm', 'confirm', [0, 1, 2, 3, 4, 5], "", 24, false);
    circMech.animation.addByIndices('good', 'confirm', [6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
    circMech.animation.addByPrefix('miss', 'miss', 24, false);
    circMech.addOffset('intro', 0, 0);
    circMech.addOffset('one', 25, 30);
    circMech.addOffset('two', -34, -29);
    circMech.addOffset('confirm', -72, -73);
    circMech.addOffset('good', -72, -72);
    circMech.addOffset('miss', -20, -130);
    circMech.scrollFactor.set();
    circMech.cameras = [camHUD];
    add(circMech);

    circMech.playAnim('intro', true);
    
    circMech.alpha = 0.001;
}
function update(elapsed:Float){
	if(FlxG.keys.justPressed.SPACE && !FlxG.save.data.botPlay){
		dodgeing = true;
    }
    if (hit < 1){
        canDie = true;
        health -= 2;
    }
}

function onEvent(e){
    if (e.event.name == "BattleSystem"){
        startMech();
        if (e.event.params[0] == true || e.event.params[0] == null){
            isDad = true;
        } else if (e.event.params[0] == false || e.event.params[0] == null){
            isDad = false;
        } 
    }
}

function startMech(){
    dodgeing = false;
	new FlxTimer().start(.05, function(tmr)
		{
			circMech.alpha = 1;
            circMech.playAnim('intro',true);
            trace("START!");
			new FlxTimer().start(.25, function(tmr)
				{
					circMech.playAnim('one',true);
                    trace("ONE");
                    new FlxTimer().start(.25, function(tmr)
                        {
                            circMech.playAnim('two',true);
                            trace("TWO");
                        
                            new FlxTimer().start(.05, function(tmr)
                                {
                                    if (isDad){
                                        boyfriend.playAnim("pre-dodge", true, "SING");
                                    } else if (!isDad){
                                        boyfriend.playAnim("pre-attack", true, "SING");
                                    }
                                });
                            new FlxTimer().start(.25, function(tmr)
                                {
                                    var char:Character = isDad ? dad : boyfriend;
                                    char.playAnim("attack", true, "SING");

                                    new FlxTimer().start(.05, function(tmr)
                                        {
                                            if(isDad && dodgeing || isDad &&  FlxG.save.data.botPlay && !dodgeing){
                                                trace("PRESS!!!");
                                                //boyfriend.playAnim("attack",true);
                                                boyfriend.playAnim("jump",true, "SING");
                                                circMech.playAnim('good', true);
                                            } else if (!isDad && dodgeing || !isDad && FlxG.save.data.botPlay && !dodgeing){
                                                trace("PRESS!!!");
                                                //dad.playAnim("attack", true);
                                                dad.playAnim("hurt", true, "SING");
                                                opponentLives--;
                                                moraBar.animation.curAnim.curFrame = 5 - opponentLives;
                                                circMech.playAnim('good', true);
                                            }
                                            else {
                                                shitHit();
                                                circMech.playAnim('miss', true);
                                                dad.playAnim("attack", true, "SING");
                                                boyfriend.playAnim("hurt", true, "SING");
                                            }
                                                new FlxTimer().start(.5, function(tmr)
                                                    {
                                                        circMech.alpha = 0.001;
                                                    });
                                                });
                                });
                        });
				});
		});
}

function shitHit(){
    trace("bruh :/");
    hit --;
    if(hit >= 1){
        skarletBar.animation.play(hit + '-loss');
        skarletBar.animation.finishCallback = function (_) {
            skarletBar.animation.play(hit);
        };
    }
    if (hit < 2){
        playerIcon.playAnim("losing", true);
    }
}