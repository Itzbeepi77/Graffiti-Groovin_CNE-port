function onNoteHit(note){

    var curNotes = note.noteType;

    switch(curNotes){
        case "Alt Animation":
            note.animSuffix = "-alt";
    }
}