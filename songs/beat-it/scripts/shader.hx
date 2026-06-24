var shakeShader:CustomShader = new CustomShader("shake");
var time:Float = 0;
function update(elapsed){
    time += elapsed;
    shakeShader.iTime = time;
}
function beatHit(curBeat:Int){
    if (curBeat == 144){
        camera.addShader(shakeShader);
    }
    if (curBeat == 176){
        camera.removeShader(shakeShader);
    }
}