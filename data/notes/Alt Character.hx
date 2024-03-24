var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        gf.playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();
    }
}
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        gf.playAnim("sing" + singDir[note.direction] + "miss", true);
        note.cancelAnim();
    }
}
function onDadHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        if (!FlxG.save.data.botPlay || note.note.strumLine.opponentSide){
            strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction], true);
        } else if (FlxG.save.data.botPlay){
            if (note.note.strumLine.opponentSide) return;
            gf.playAnim("sing" + singDir[note.direction], true);
        }
        note.cancelAnim();
    }
}