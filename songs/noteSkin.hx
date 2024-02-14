function onNoteCreation(e) {
    switch (curSong) {
        case "soda-pop", "groovin", "streetstyle", "sinister":
            e.noteSprite = 'game/notes/NOTE_skarlet';
            e.note.splash = "skarlet";
    }
    e.note.alpha = 0.7;
}

function onStrumCreation(e) {
    switch (curSong) {
        case "soda-pop", "groovin", "streetstyle", "sinister":
            e.sprite = 'game/notes/NOTE_skarlet';
    }
    e.strum.alpha = 0.7;
}

function onSongStart(){
    for (i in 0...4) {
        FlxTween.cancelTweensOf(cpuStrums.members[i]);
        FlxTween.tween(cpuStrums.members[i], {alpha: 0.7}, 0.7);
    }
    for (i in 0...4) {
        FlxTween.cancelTweensOf(playerStrums.members[i]);
        FlxTween.tween(playerStrums.members[i], {alpha: 0.7}, 0.7);
    }
}