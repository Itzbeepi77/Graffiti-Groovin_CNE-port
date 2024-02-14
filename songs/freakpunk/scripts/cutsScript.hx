/*import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
var videoOvlp = null; // used for overlapping the whole camera
function create() {
    trace("intro");
}

function playVideoOvlp(){
    videoOvlp = new FlxVideo();
    videoOvlp.onEndReached.add(videoOvlp.dispose);
    var path = Paths.file("videos/CUTSCENE_FREAKPUNK.mp4");
	videoOvlp.load(Assets.getPath(path));
	var timer:FlxTimer = new FlxTimer();
	timer.start(1, videoOvlp.play(), 0);
}

function onSongStart(){
    playVideoOvlp();
}*/