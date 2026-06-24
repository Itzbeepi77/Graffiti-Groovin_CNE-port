//
import StringTools;

var curChars:Array<Character> = null;
var yeIdfk:Bool = false;

function update(elapsed){
	if (StringTools.startsWith(boyfriend.getAnimName(), "sing")){
		//yeIdfk = true;
		var chars:Array<Character> = curChars != null ? curChars : [boyfriend];
		for (i in chars){
			i.danceOnBeat = false;
		}
	} else if (!StringTools.startsWith(boyfriend.getAnimName(), "sing")){
		//yeIdfk = false;
		var chars:Array<Character> = curChars != null ? curChars : [boyfriend];
		for (i in chars){
			i.danceOnBeat = true;
		}
	}
}

/*function onInputUpdate(event) {
		var chars:Array<Character> = curChars != null ? curChars : [event.strumLine.characters[0]];

		for (value in event.pressed)
			if (value && (yeIdfk)){
				yeIdfk = true;
				for (i in chars){
					i.danceOnBeat = false;
				}
			}

		for (value in event.justReleased)
			if (value){
				yeIdfk = false;
				for (i in chars){
					i.danceOnBeat = true;
				}
			}
}*/

function onPlayerHit(event) {
	curChars = curChars != null ? curChars : [event.character];
	if (!yeIdfk){
		yeIdfk = true;
	}
}