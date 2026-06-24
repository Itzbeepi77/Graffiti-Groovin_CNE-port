var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
function onPlayerHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        note.characters = strumLines.members[2].characters;
    }
}
function onPlayerMiss(note){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        note.characters = strumLines.members[2].characters;
    }
}
function onDadHit(note:NoteHitEvent){
    var curNotes = note.noteType;

    switch(curNotes){
    case "Alt Character":
        if (!botPlay || note.note.strumLine.opponentSide){
            note.characters = strumLines.members[3].characters;
        } else if (botPlay){
            if (note.note.strumLine.opponentSide) return;
            note.characters = strumLines.members[2].characters;
        }
    }
}