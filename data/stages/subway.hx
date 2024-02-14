//simple but good
var cameos = new FunkinSprite();

var cameo:Int = 0;
var cameoShit = [
	"1up",
	"agoti",
	"black",
	"karan",
	"melody",
    "nikku",
    "octi",
    "ying"
];

var bopInter = 1;

function create(){
    for (i in [bopsL,bopsR,fgbops]){
        i.playAnim("idle", false);
    }

    if (curSong == "soda-pop"){
        bopInter = 2;
    }
}

function postCreate(){
    for (event in events)
        if (event.name == 'train cameo') {
            if (event.params[0] == true || event.params[0] == null){
            var shit = FlxG.random.int(0, cameoShit.length-2);
            if (shit >= cameo) shit++;
            cameo = shit;

            cameos = new FunkinSprite();
            cameos.frames = Paths.getSparrowAtlas("stages/metro/images/cameos/" + cameoShit[cameo].length-2);
            cameos.animation.addByPrefix('open', 'doors open', 24, false);
            cameos.animation.addByPrefix('close', 'doors closed', 24, false);
            cameos.updateHitbox();
            cameos.antialiasing = true;
            cameos.setPosition(975, 536.75);
            cameos.playAnim('close', true);
            insert(members.indexOf(train), cameos);
        }
    }
}
function onEvent(e){}

function beatHit(curBeat){
    if (curBeat % bopInter == 0){
        for (i in [bopsL,bopsR,fgbops]){
            i.playAnim("idle", true);
        }
    }
}