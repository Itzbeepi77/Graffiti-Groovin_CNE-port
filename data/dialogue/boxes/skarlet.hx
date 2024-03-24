import funkin.game.Character;

var game;

function create(){
    game = PlayState.instance;
}

function popupChar(event) {
    if (event.char.positionName == "right"){
        curCameraTarget = 1;
    } else if (event.char.positionName == "left"){
        curCameraTarget = 1;
    }
}