var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        gf.playAnim("sing" + singDir[note.direction], true);
        boyfriend.playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();
    }
}
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        gf.playAnim("sing" + singDir[note.direction] + "miss", true);
        boyfriend.playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();
    }
}
function onDadHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction], true);
        dad.playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();
    }
}