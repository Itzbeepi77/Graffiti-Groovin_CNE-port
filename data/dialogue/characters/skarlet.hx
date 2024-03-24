var game:PlayState;

function create(){
    game = PlayState.instance;
}

function update(elapsed) {
    if (positionName == "right"){
        curCameraTarget = 1;
    } else if (positionName == "left"){
        curCameraTarget = 0;
    }
}