function onPlayerMiss(e){
    if (e.noteType == "Shadow Note" && e.noteType != "" || e.noteType != null){
        e.cancel(true);
        e.note.strumLine.deleteNote(e.note);
    }
}
function onPlayerHit(e){
    if (e.noteType == "Shadow Note"){
        e.cancelAnim();
        boyfriend.playAnim("hurt", true);
    }
}
function onNoteCreation(e){
    var curNotes = e.noteType;
    var note = e.note;

    note.copyStrumAngle = false;

    switch (curNotes) {
        case "Shadow Note":
            e.cancel();

            if (!e.cancel){
                note.frames = Paths.getFrames("stages/fightuwu/images/arrow-nycto");
                switch (e.strumID) {
                    case 0:
                        note.animation.addByPrefix('scroll', 'plague note', 24, true);
                        note.angle = 270;
                    case 1:
                        note.animation.addByPrefix('scroll', 'plague note', 24, true);
                        note.angle = 180;
                    case 2:
                        note.animation.addByPrefix('scroll', 'plague note', 24, true);
                        note.angle = 0;
                    case 3:
                        note.animation.addByPrefix('scroll', 'plague note', 24, true);
                        note.angle = 90;
                }
                note.scale.set(0.7, 0.7);
                note.updateHitbox();
                e.note.avoid = true;
                e.note.canBeHit = false;
                e.note.wasGoodHit = false;
                //note.splash = "default";
        }
    }
}
function onPostNoteCreation(e){
    var curNotes = e.noteType;
    var note = e.note;

    note.forceIsOnScreen = true;

    if (curNotes == "Shadow Note"){
        note.offset.x -= 20;
        if (downscroll) note.offset.y -= 30;
        else note.offset.y -= 4;
    }
}