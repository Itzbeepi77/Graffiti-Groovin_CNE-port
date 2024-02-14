import flixel.FlxTween;

function startIntro(){
  var bg:FunkinSprite = new FunkinSprite();
  bg.antialiasing = true;
  bg.screenCenter();
  bg.frames = Paths.getSparrowAtlas("menus/titlescreen/bgVid20");
  bg.animation.addByPrefix("idle", "bgvid", 24, true);
  bg.animation.play("idle");
  add(bg);	
}
function create() {
    camBG = new FlxCamera();
    camBG.bgColor = new FlxColor(0x00000000);
    FlxG.cameras.add(camBG, false);
    window.title = "Graffiti Groovin'";
}
function postCreate(){
  titleText.scale.set(0.7, 0.7);
  titleText.y -= 50;
  titleText.x += 50;
}
