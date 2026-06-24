var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        gf.playSingAnim(note.direction, note.animSuffix, "SING", true);
    }
}
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        gf.playSingAnim(note.direction, note.animSuffix, "SING", true);
    }
}
function onDadHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Both Characters":
        if (!botPlay || note.note.strumLine.opponentSide){
            strumLines.members[3].characters[0].playSingAnim(note.direction, note.animSuffix, "SING", true);
        } else if (botPlay){
            if (note.note.strumLine.opponentSide) return;
            gf.playSingAnim(note.direction, note.animSuffix, "SING", true);
        }
    }
}