var states:Array<String> = [
    'intro',
    'one',
    'two',
    'confirm',
    'good',
    'miss'
];

var stepTime:Float = 0;
var nextStateTime:Float = 0;
var _lastSongPos:Float = 0;
var _lastBeatHit:Int = -999999;
var hitWindow:Float = 0.3;
var lastPressed:Float = 0;

var isDad:Bool = false;

var pressedBattleKey:Bool = false;
var spamPardon:Int = 2;

static var botPlay:Bool = false;

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

function update(elapsed:Float){
    if(_lastBeatHit != curBeat){
        _lastBeatHit = curBeat;
    }
    nextStateTime -= (Conductor.songPosition - _lastSongPos) / 1000;
    while(nextStateTime <= 0) //Use "while" to sync to a laggy PC
    {
        nextStateTime += stepTime;
        nextState();
    }

    var pressed:Bool = (!botPlay && FlxG.keys.justPressed.SPACE);
    switch(state){
        case 'two':
            if(pressed)
            {
                spamPardon--;
                trace('pressed too early or spammed');
            }
        case 'confirm':
            if(pressed)
            {
                lastPressed = 0;
                pressedBattleKey = true;
                trace('pressed space on time');
            }
            lastPressed += elapsed;

            if(circMech.animation.curAnim.finished)
            {
                var char:Character = isDad ? dad : boyfriend;
                char.playAnim('attack', true);

                if((pressedBattleKey && lastPressed < hitWindow && spamPardon > 0) || botPlay)
                {
                    state = "good";
                    trace('confirm: ' + state + ', lastPressed: ' + lastPressed);

                    circMech.playAnim('good', true);
                    //FlxG.sound.play(Paths.sound('confirmMenu'), 0.6);
    
                    if (isDad)
                    {
                        boyfriend.playAnim('dodge', true);
                    }
                    else
                    {
                        dad.playAnim('hurt', true);
                        //PlayState.instance.health += 0.4;
                        opponentLives--;
                        healthBar.animation.curAnim.curFrame = 5 - opponentLives;
                    }
                }
                else
                {
                    state = 'miss';
                    trace('confirm: ' + state);
                    circMech.playAnim('miss', true);
                    //FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), 0.6);
    
                    if (isDad)
                    {
                        boyfriend.playAnim('hurt', true);
                        shitHit();
                    }
                    else
                    {
                        // Mora doesnt have a dodge anim
                        if(dad.hasAnimation('dodge'))
                        {
                            dad.playAnim('dodge', true);
                        }
                        else
                        {
                            dad.dance();
                        }
                        //PlayState.instance.health -= 0.4;
                    }
                }
            }
        
        case 'good', 'miss':
            if(circMech.animation.curAnim.finished)
            {
                circMech.alpha = 0.001;
                //trace('good/miss: $state');
                //state = 'neutral';
                trace('ending battle');
            }
        default: //
    }
    _lastSongPos = Conductor.songPosition;

    if (hit < 1){// ded
        canDie = true;
        health -= 2;
    }
}

function nextState()
	{
		switch(state)
		{
			case 'intro':
				//FlxG.sound.play(Paths.sound('dialogue'), 1);
				circMech.playAnim('one', true);
				state = 'one';
				trace('intro: ' + state);

			case 'one':
				//FlxG.sound.play(Paths.sound('dialogue'), 1);
				circMech.playAnim('two', true);
				state = 'two';
				trace('one: ' + state);

			case 'two':
				//FlxG.sound.play(Paths.sound('dialogue'), 1);
				circMech.playAnim('confirm', true);
				state = 'confirm';
				trace('two: ' + state);
				
				var char:Character = isDad ? dad : boyfriend;
				if(char.animation.exists('pre-attack'))
				{
					char.playAnim('pre-attack', true);
				}

				if (isDad && boyfriend.animation.exists('pre-dodge'))
				{
					boyfriend.playAnim('pre-dodge', true);
				}
			default:
		}
	}

function startMech(){
    //FlxG.sound.play(Paths.sound('clickText'), 0.75);
    circMech.playAnim('intro', true);
    circMech.alpha = 1;
    
    state = 'intro';
    pressedBattleKey = false;
    spamPardon = 2;
    trace('start: ' + state);
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