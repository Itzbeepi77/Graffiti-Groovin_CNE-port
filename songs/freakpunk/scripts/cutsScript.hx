import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
var video = null; // used for overlapping the whole camera

var skarletPunch:FunkinSprite = new FunkinSprite();
var knockoutBG:FunkinSprite = new FunkinSprite();
var slash:FunkinSprite = new FunkinSprite();

function onSubstateOpen(event) if (video != null && paused) video.pause();
function onSubstateClose(event) if (video != null && paused) video.resume();
function focusGained() if (video != null && !paused) video.resume();
function postCreate(){
	video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
	video.bitmap.onEndReached.add(videokill);
    var path = Paths.file("videos/CUTSCENE_FREAKPUNK.mp4");
	video.load(Assets.getPath(path));
    video.y -= "15";
    
	add(video);
	video.cameras = [camHUD];
}
function create() {
    trace("intro");

    var obj="";
    var prefix="stages/fightuwu/images/" + obj;

    // skarlet punch cutscene sprite
    skarletPunch.frames = Paths.getSparrowAtlas(prefix + "battleSystem/SKARLET_PUNCH");
    skarletPunch.animation.addByPrefix("idle", "skarlet ult", 24, false);
    skarletPunch.scale.x = skarletPunch.scale.y = 1.35;
    skarletPunch.y -= 50;
    skarletPunch.updateHitbox();
    skarletPunch.screenCenter();
    skarletPunch.alpha = 0.001;
    add(skarletPunch);
    
    // slash
    var daScale = 1 / defaultCamZoom;
    knockoutBG.frames = Paths.getSparrowAtlas(prefix + "battleSystem/KO SCREEN");
    knockoutBG.animation.addByPrefix("idle", "screen loop", 24, true);
    knockoutBG.scale.set(daScale * 0.9, daScale * 0.9);
    knockoutBG.updateHitbox();
    knockoutBG.screenCenter();
    knockoutBG.alpha = 0.001;
    insert(members.indexOf(dad), knockoutBG);
    
    slash.frames = Paths.getSparrowAtlas(prefix + "battleSystem/SLASH");
    slash.animation.addByPrefix("idle", "SLASH", 24, false);
    slash.scale.set(daScale * 0.64, daScale * 0.64);
    slash.updateHitbox();
    slash.screenCenter();
    slash.x += 80;
    slash.y -= 50;
    slash.alpha = 0.001;
    slash.animation.finishCallback = function(name:String) slash.visible = false;
    insert(members.indexOf(dad), slash);

    for (cuts in [skarletPunch,knockoutBG,slash]){
        cuts.scrollFactor.set();
    }
}
function videokill(){
    video.destroy();
    for (i in [skarletBar,moraBar,timeBar,timeBarBG,timeTxt])i.alpha = 1;
    for (icons in [playerIcon,opponentIcon])
        icons.alpha = 1;
}

function onSongStart(){
    video.play();
}

function onEvent(e){
    if (e.event.name == "FreakFatality"){
        if (e.event.params[0] == true){
            fatality();
            //canPause = false;
        }
    }
}

function fatality(){
    dad.alpha = 1;
    camera.followLerp = 0.08;
    dad.playAnim("angry", true);
    new FlxTimer().start(2, function(tmr)
        {
            dad.playAnim("jumpscare", true);
            dad.animation.finishCallback = function (name:String) dad.alpha = 0.001;
            new FlxTimer().start(.5, function(tmr)
                {
                    boyfriend.playAnim("final-blow", true, "LOCK");
                    new FlxTimer().start(2, function(tmr:FlxTimer)
                        {
                            skarletPunch.alpha = 1;
                            skarletPunch.playAnim("idle", true);
                        });
                new FlxTimer().start(3.5, function(tmr)
                    {
                        var slashStart:Float = 0.65;

                        boyfriend.playAnim("punch-after", true);

                        skarletPunch.alpha = 0.001;
                        slash.alpha = 1;
                        slash.playAnim("idle", true);
                        knockoutBG.alpha = 1;
                        knockoutBG.playAnim("idle", true);
                        FlxTween.tween(knockoutBG, {alpha: 0}, 0.5, {startDelay: slashStart + 1.5, ease: FlxEase.linear});
                        new FlxTimer().start(1.2, function(tmr:FlxTimer)
                            {

                                boyfriend.playAnim('hey', true, "LOCK");
                                dad.alpha = 1;
                                dad.playAnim("ko", true, "LOCK");
                                dad.animation.finishCallback = function (name:String) dad.alpha = 0.001;
                                for (i in [moraBar, opponentIcon]){
                                    FlxFlicker.flicker(i, Conductor.crochet / 1000 *4, 0.1, true, true, function(flick:FlxFlicker){
                                        moraBar.alpha = 0.001;
                                        opponentIcon.alpha = 0.001;
                                    });
                                }
                            });
                    });
                });
            });
        }

function beatHit(curBeat:Int){
    if (curBeat == 556){
        boyfriend.cameraOffset.x += 400;
    }
    if (curBeat == 564){
        boyfriend.cameraOffset.x -= 400;
    }
    if (curBeat == 760){
        opponentLives--;
        moraBar.animation.curAnim.curFrame = 5 - opponentLives;
    }
}