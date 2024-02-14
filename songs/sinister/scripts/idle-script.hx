function onEvent(_) {
    if (_.event.name == 'Spooky kids Idles') { // fix the idle animations not switching
        for (char in strumLines.members[_.event.params[0]].characters) {
            if (char.hasAnimation('idle-alt')) { // swap the idle anim
                CoolUtil.switchAnimFrames(char.animation.getByName('idle'), char.animation.getByName('idle-alt'));
                char.switchOffset('idle', 'idle-alt');
            } else if (char.hasAnimation('danceLeft-alt')) { // swap the dance anims
                CoolUtil.switchAnimFrames(char.animation.getByName('danceLeft'), char.animation.getByName('danceLeft-alt'));
                CoolUtil.switchAnimFrames(char.animation.getByName('danceRight'), char.animation.getByName('danceRight-alt'));
                char.switchOffset('danceLeft', 'danceLeft-alt');
                char.switchOffset('danceRight', 'danceRight-alt');
            }
        }
    }
}