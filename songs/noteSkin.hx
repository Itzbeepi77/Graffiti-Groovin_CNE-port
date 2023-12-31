function onNoteCreation(e) {
    switch (curSong) {
        case "streetstyle":
            e.noteSprite = 'game/notes/NOTE_skarlet';
            e.note.alpha = 0.7;
    }
}

function onStrumCreation(e) {
    switch (curSong) {
        case "streetstyle":
            e.sprite = 'game/notes/NOTE_skarlet';
    }
}

function onCountdown(e){
    switch(curSong){
        case "streetstyle":
            for (s in strumLines){
                for(i in 0...4) {
                    var n = s.members[i];
                    FlxTween.tween(n, {alpha: 0.7}, 0.5, {ease: FlxEase.sineInOut});
                }
        }
    }
}