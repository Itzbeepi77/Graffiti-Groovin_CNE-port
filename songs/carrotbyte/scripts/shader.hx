var drunk:CustomShader = new CustomShader("drunk");
var time:Float = 0;
function update(elapsed){
    time += elapsed;
    drunk.iTime = time;
}
function beatHit(curBeat:Int){
    switch(curBeat){
        case 182, 448, 544:
            camera.addShader(drunk);
        case 256, 480, 592:
            camera.removeShader(drunk);
    }
}