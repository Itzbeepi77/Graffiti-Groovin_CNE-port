var cinematicBarTween1:FlxTween = null;
var cinematicBarTween2:FlxTween = null;

var cinematicBar1:FunkinSprite = null;
var cinematicBar2:FunkinSprite = null;

function create() {
    for (i in 0...2) {
        var cinematicBar:FunkinSprite = new FunkinSprite().makeSolid(1, 1, 0xFF000000);
        cinematicBar.scrollFactor.set(0, 0);
        //cinematicBar.zoomFactor = 0;
        cinematicBar.cameras = [cam3];
        insert(0, cinematicBar);

        cinematicBar.scale.set(FlxG.width, 0);
        cinematicBar.updateHitbox();

        if (i == 1) cinematicBar2 = cinematicBar;
        else cinematicBar1 = cinematicBar;
    }
}

function update(elapsed:Float) {
    if (cinematicBarTween2 != null && cinematicBarTween2.active && cinematicBarTween1 != null && cinematicBarTween1.active)
        for (bar in [cinematicBar1, cinematicBar2]) bar.updateHitbox();
    cinematicBar2.y = FlxG.height - cinematicBar2.height;
}

function onEvent(eventEvent) {
    var params:Array = eventEvent.event.params;
    if (eventEvent.event.name == "Cineamatic Bars") {
        if (params[0] == false)
            for (bar in [cinematicBar1, cinematicBar2]) {
                bar.scale.y = (FlxG.height/2) * params[1];
                bar.updateHitbox();
            }
        else {
            for (twn in [cinematicBarTween1, cinematicBarTween2])
                if (twn != null) twn.cancel();
            
            var flxease:String = params[3] + (params[3] == "linear" ? "" : params[4]);

            for (bar in [cinematicBar1, cinematicBar2]) {
                var tween:FlxTween = FlxTween.tween(bar.scale, {y: (FlxG.height/2) * params[1]}, ((Conductor.crochet / 4) / 1000) * params[2], {ease: Reflect.field(FlxEase, flxease)});
                if (bar == cinematicBar1) cinematicBarTween1 = tween;
                else cinematicBarTween2 = tween;
            }
            
        }
    }
}