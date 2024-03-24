function onEvent(e) {// yipee
    if (e.event.name == 'Spooky kids Idles') {
        switch(e.event.params[0]){
            case "both":
                for (chars in [dad, strumLines.members[3].characters[0]]){
                    chars.playAnim("look", true);
                    chars.idleSuffix = '-alt';
                }
                
            case "skid":
                dad.playAnim("look", true);
                dad.idleSuffix = '-alt';
                
            case "pump":
                strumLines.members[3].characters[0].playAnim("look", true);
                strumLines.members[3].characters[0].idleSuffix = '-alt';
                
            case "back to idle (both)":
                for (chars in [dad, strumLines.members[3].characters[0]]){
                    chars.playAnim("idle-back", true);
                    chars.idleSuffix = '';
                }
                
            case "back to idle (skid)":
                dad.playAnim("idle-back", true);
                dad.idleSuffix = '';
                
            case "back to idle (pump)":
                strumLines.members[3].characters[0].playAnim("idle-back", true);
                strumLines.members[3].characters[0].idleSuffix = '';
        }
    }
}