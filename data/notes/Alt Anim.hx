var anims = ["LEFT", "DOWN", "UP", "RIGHT"];
var curChars:Array<Character> = null;
function onNoteHit(note){

    var curNotes = note.noteType;
    curChars = note.characters;
    var chars:Array<Character> = curChars != null ? curChars : [note.strumLine.characters[0]];

    switch(curNotes){
        case "Alt Animation":
            for (i in chars)
                i.playAnim("sing" + anims[note.direction] + "-alt", true);
            note.cancelAnim();
            deleteNote(note.note);
    }
}