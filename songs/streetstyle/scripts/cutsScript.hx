import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
var curVideo = null; // used for under cam video
var videoOvlp = null; // used for overlapping the whole camera
function create() {
    trace("intro");
    curVideo = new FlxVideo();
    curVideo.onEndReached.add(curVideo.dispose);
    var path = Paths.file("videos/streetstyle_drop.mp4");
	curVideo.load(Assets.getPath(path));
}

function playVideoOvlp(){
    videoOvlp = new FlxVideo();
    videoOvlp.onEndReached.add(videoOvlp.dispose);
    var path = Paths.file("videos/CUTSCENE_STREETSTYLE.mp4");
	videoOvlp.load(Assets.getPath(path));
	var timer:FlxTimer = new FlxTimer();
	timer.start(1, videoOvlp.play(), 0);
}

function onSongStart(){
    playVideoOvlp();
}

function beatHit(curBeat){
	if (curBeat == 256){
        trace("drop");
        var timer:FlxTimer = new FlxTimer();
        timer.start(1, curVideo.play(), 0);
	}
}