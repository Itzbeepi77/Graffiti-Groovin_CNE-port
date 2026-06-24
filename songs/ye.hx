function onNoteHit(e){
    if (!e.note.isSustainNote) return;
    e.cancelAnim();
    for (i in e.characters)
        i.lastHit = Conductor.songPosition;
}