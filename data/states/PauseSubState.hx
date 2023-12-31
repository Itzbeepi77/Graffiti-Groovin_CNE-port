import flixel.FlxG;
/* 
    Skips the current song for the purpose of testing cutscenes 
    for the next song quickly
*/
var isDebugEnabled:Bool = true; // set to false before release

function create()
    if (isDebugEnabled && game.inst != null && game.vocals != null) menuItems.insert(5, 'Skip Song');

function postUpdate()
    if (controls.ACCEPT)
        if (menuItems[curSelected] == "Skip Song") game.endSong();