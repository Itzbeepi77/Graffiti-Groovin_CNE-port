var shakeShader:CustomShader = new CustomShader("shake");
//var idkwahtisthis:CustomShader = new CustomShader("bug2");
var bnuy:CustomShader = new CustomShader("bnuy");
//var distort:CustomShader = new CustomShader("distortion");
var time:Float = 0;
function update(elapsed){
    time += elapsed;
    shakeShader.iTime = time;
    bnuy.iTime = time;
    //idkwahtisthis.iTime = time;
}
function beatHit(curBeat:Int){
    if (curBeat == 436){
        camera.addShader(shakeShader);
        //camera.addShader(idkwahtisthis);
        camera.addShader(bnuy);
        //camera.addShader(distort);
    }
    if (curBeat == 564){
        camera.removeShader(shakeShader);
        //camera.removeShader(idkwahtisthis);
        camera.removeShader(bnuy);
        //camera.removeShader(distort);
    }
}