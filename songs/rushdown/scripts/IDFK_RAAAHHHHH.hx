//the whole shits lmfao 

import flixel.FlxBasic;
import funkin.system.FunkinSprite;

var xVal, yVal, zoomVal:Float;
var maskShader:CustomShader = new CustomShader("mask");
var bikeCut, bubbleCut:FunkinSprite;
var camCut:FlxCamera = new FlxCamera();
function postCreate(){
    FlxG.cameras.add(camCut, false);
	camCut.bgColor = 0;

	bubbleCut = new FunkinSprite();
	bubbleCut.antialiasing = true;
	bubbleCut.loadSprite(Paths.image('stages/pollo/images/MORA_BUBBLE'));
	bubbleCut.addAnim('nyeh', 'mora bike bubble0', 0, false);
	bubbleCut.playAnim('nyeh', true);
	//bubbleCut.animation.curAnim.pause();

	bikeCut = new FunkinSprite();
	bikeCut.antialiasing = true;
	bikeCut.loadSprite(Paths.image('stages/pollo/images/MORA_INTRO'));
	bikeCut.animateAtlas.anim.addBySymbol('attack', 'mora bike camera final', 0, false);
	bikeCut.playAnim('attack', true);
	//bikeCut.animateAtlas.curAnim.pause();
	bikeCut.camera = camCut;
	//bikeCut.antialiasing = true;
	//cutscene.scale.set(1.2, 1.2);
	bikeCut.updateHitbox();
	bikeCut.screenCenter();
	bikeCut.setPosition(310, 610);

    add(bikeCut);
    add(bubbleCut);

	var bitmap = bubbleCut.graphic.bitmap;
	//maskShader.maskTexture.input = [bitmap];
	//maskShader.maskTexture.mipFilter = MIPLINEAR;
	//maskShader.maskTexture.filter = ["LINEAR"];
	maskShader.sc = [bitmap.width, bitmap.height];

    yVal = -200;
    zoomVal = 0.5;

    for (shits in [camCut, bubbleCut, bikeCut]){
        shits.alpha = 0.001;
    }
}

function onEvent(e){
    if (e.event.name == "Intro_Outro Rush"){
        if (e.event.params[0] == "Outro"){
            startCut();
        }
    }
}

function startCut(){
	bubbleCut.playAnim('nyeh', true);
    camCut.addShader(maskShader);
    for (shits in [camCut, bubbleCut, bikeCut]){
        shits.alpha = 1;
    }
}
function update(elapsed) {
	//bubbleCut.update();
	//bikeCut.update(elapsed);

	bikeCut.animation.curAnim.curFrame = bubbleCut.animation.curAnim.curFrame;

    var frame = bubbleCut.frame;
	maskShader.fs = [frame.frame.x, frame.frame.y, frame.frame.width, frame.frame.height];
	//ts = [frame.offset.x + bubbleCut.x, frame.offset.y + bubbleCut.y, frame.sourceSize.x, frame.sourceSize.y];
	maskShader.ts = [frame.offset.x + bubbleCut.x, frame.offset.y + bubbleCut.y, camCut.width, camCut.height];
	maskShader.zoom = camCut.zoom;
	maskShader.scroll = [camCut.scroll.x, camCut.scroll.y];

	camCut.scroll.x = -xVal;
	camCut.scroll.y = -yVal;
	camCut.zoom = zoomVal;
}
function destroy() {
	if(FlxG.cameras.list.contains(camCut))
		FlxG.cameras.remove(camCut, true);
}