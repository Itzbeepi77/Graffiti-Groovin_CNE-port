public var botPlay:Bool = false;

function create(){
    bag.playAnim("idle", true);
    bag.addOffset("hit", 36,1);
}

function update(elapsed:Float){
    botPlay = FlxG.save.data.botPlay;

	if (bag.animation.curAnim.name != null && bag.animation.curAnim.name == "idle"){
        bag.angle = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 120) * 1.0) * 5;
    } else {
        bag.angle = 0;
    }
    if (curBeat == 576 && controls.NOTE_UP || curBeat == 576 && botPlay){// incase if you miss the very last note, it will not play the anim
        bag.playAnim("knockout", true, "LOCK");
        bag.animation.finishCallback = function (_) {bag.alpha = 0.001;}
        dad.playAnim("surprise", true, "LOCK");
    }
}

function onPlayerHit(e){
    bag.playAnim("hit", true);
    bag.angle = 0;

    if (!botPlay){
        bag.animation.finishCallback = function (_) {bag.playAnim("idle");}
    }
}
function onDadHit(e){
    if (e.note.strumLine.opponentSide) return;
    bag.playAnim("hit", true);
    bag.angle = 0;
    
    if (botPlay){
        bag.animation.finishCallback = function (_) {bag.playAnim("idle");}
    }
}
function beatHit(curBeat:Int){
    if (curBeat % 2 == 0){
        gym.playAnim("idle", true);
    }
}