function onNoteHit(note){

    var curNotes = note.noteType;

    switch(curNotes){
        case "No Animation":
            note.cancelAnim();
            deleteNote(note.note);
    }
}