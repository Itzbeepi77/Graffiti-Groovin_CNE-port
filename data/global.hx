import funkin.backend.utils.WindowUtils;

import hxvlc.util.Handle;

static var seenMenuCutscene:Bool = false;

function new() {
	FlxG.mouse.useSystemCursor = true;
    
    Handle.init([]);
}
function preStateSwitch() {
    WindowUtils.resetTitle();
	window.title = "Graffiti Groovin";
}