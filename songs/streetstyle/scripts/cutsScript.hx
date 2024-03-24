import funkin.game.cutscenes.Cutscene;
import funkin.game.cutscenes.ScriptedCutscene;
import funkin.game.cutscenes.VideoCutscene;
import hxvlc.flixel.FlxVideoSprite;
var video = null; // used for overlapping the whole camera
var video2 = null; // used for overlapping the whole camera

function onSubstateOpen(event){
    if (video != null && paused) video.pause();
    if (video2 != null && paused) video2.pause();
}
function onSubstateClose(event){
    if (video != null && paused) video.resume();
    if (video2 != null && paused) video2.resume();
}
function focusGained(){
    if (video != null && !paused) video.resume();
    if (video2 != null && !paused) video2.resume();
}
function postCreate(){
    video = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
    video.bitmap.onEndReached.add(videokill);
    var path = Paths.file("videos/CUTSCENE_STREETSTYLE.mp4");
	video.load(Assets.getPath(path));
    video.y -= "15";

    add(video);
    video.cameras = [camHUD];
}
function create() {
    trace("intro");
    
	video2 = new FlxVideoSprite(FlxAxes.X,FlxAxes.Y);
	video2.bitmap.onEndReached.add(videokill2);
    var path = Paths.file("videos/streetstyle_drop.mp4");
	video2.load(Assets.getPath(path));
	video2.cameras = [camHUD];
    video2.y -= "15";
    
	insert(1, video2);

}

function videokill(){
    video.destroy();
    for (icons in [playerIcon,opponentIcon])
        icons.alpha = 1;
}

function onSongStart(){
    video.play();
}

function videokill2()video2.destroy();

function beatHit(curBeat){
	if (curBeat == 256){
        trace("drop");
        video2.play();
	}
}