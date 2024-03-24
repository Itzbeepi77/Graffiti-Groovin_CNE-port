// thingy recreation in script instead of shader..
// Idk fuck that anyway
var spin = 1;
function update(elapsed){
    var i = (Conductor.songPosition + 5000) / 1000 * 30;
	if (curStep >= 768 && curStep < 1020 || curStep >= 1792 && curStep < 1908 || curStep >= 2176 && curStep < 2368){
        camFollowLerp = 0.02;

        defaultCamZoom = (Math.sin(i/40)*0.05) + 0.65;

		camGame.angle = spin * Math.sin(i/28);
        camera.scroll.y += Math.sin(i/14);
        camera.scroll.x += Math.sin(i/7);
	}
	if (curStep == 1020 || curStep == 1908 || curStep == 2368){
		camGame.angle = lerp(camGame.angle, 0, (Math.sin(i/30)*elapsed));
	}
    if (curStep == 768 || curStep == 1792 || curStep == 2176){
		camera.flash(FlxColor.WHITE, 0.2);
    }
}