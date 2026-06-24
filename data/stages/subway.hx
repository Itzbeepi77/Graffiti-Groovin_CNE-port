// simple but good
// mane Idk fuck it
var cameoMap:FlxSpriteGroup;
var doorShit:Map<String, FlxSprite> = [];
var preloadedCameo = [];
var train, cameos:FlxSprite = new FlxSprite();

/*var cameo:Int = 0;
var cameoShit = [
	"1up",
	"agoti",
	"black",
	"karan",
	"melody",
    "nikku",
    "octi",
    "ying"
];*/

var bopInter = 1;

function create(){
    for (i in [bopsL,bopsR,fgbops]){
        i.animation.play("idle");
    }

    if (curSong == "soda-pop") bopInter = 2;
}

function postCreate(){
    if (cameoMap == null) {
        cameoMap = new FlxSpriteGroup(-6100, 425);
    
        train = new FlxSprite();
        train.loadGraphic(Paths.image("stages/metro/images/trains"));
        //train.scale.set(1.2, 1.2);
        train.antialiasing = true;
        train.updateHitbox();
    
        insert(members.indexOf(bg)+3, cameoMap);
    
        cameoMap.add(train);
    }

    for (event in events){
        if (event.name == "train cameo"){
            var shit:String = event.params[0];
            if (shit == null || shit == "") shit = "nikku";

            for (key=>spr in doorShit) {
                if (key == shit) cameos = spr;
            }
            if (cameos == null) return;
            cameos.alpha = 1;

            cameos.frames = Paths.getSparrowAtlas("stages/metro/images/cameos/" + shit);
            graphicCache.cache(Paths.image("stages/metro/images/cameos/" + shit));
            cameos.antialiasing = true;
            cameos.updateHitbox();
            doorShit.set(shit, cameos);
        }
    }
}
function onEvent(e){
    if (e.event.name == "train cameo"){
        var shit:String = e.event.params[0];
        if (shit == null || shit == "") shit = "nikku";

        for (key=>spr in doorShit) {
            if (key == shit) cameos = spr;
        }
        if (cameos == null) return;
        cameos.alpha = 1;

        cameos.frames = Paths.getSparrowAtlas("stages/metro/images/cameos/" + shit);
        graphicCache.cache(Paths.image("stages/metro/images/cameos/" + shit));
        cameos.animation.addByPrefix('open', 'doors open', 24, false);
        cameos.animation.addByPrefix('close', 'doors closed', 24, false);
        cameos.animation.addByIndices('idle', 'doors open', [0], "", 24, false);
        cameos.setPosition(2450 - 50 + 5 + 20, 105-10);
        cameos.animation.play('idle', true);
        cameoMap.insert(0, cameos);
        doorShit.set(shit, cameos);
        trace('hello');

        if (e.event.params[1]){

            cameos.animation.play('idle', true);
            FlxTween.tween(cameoMap, {x: -1400}, 5, {ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween){
                    new FlxTimer().start(.75, function(tmr)
                        {
                            cameos.animation.play('open', true);

                            cameos.animation.finishCallback = function(name:String){
                                if (name == 'open'){
                                    new FlxTimer().start(2, function(tmr)
                                        {
                                            cameos.animation.play('close', true);
                                        });
                                    } else if (name == 'close') {
                                        new FlxTimer().start(.75, function(tmr)
                                            {
                                                FlxTween.tween(cameoMap, {x: 3500}, 5, {ease: FlxEase.cubeInOut,
                                                    onComplete: function(twn:FlxTween){
                                                        trace('bye');
                                                        cameoMap.x = -6100;
                                                        cameos.animation.play('idle', true);
                                                        cameos.alpha = 0.001;
                                                    }
                                                });
                                            });
                                    }
                            }
                        });
                }
            });
        }
            
    }
}

function beatHit(curBeat){
    if (curBeat % bopInter == 0){
        for (i in [bopsL,bopsR,fgbops]){
            i.animation.play("idle", true);
        }
    }
}