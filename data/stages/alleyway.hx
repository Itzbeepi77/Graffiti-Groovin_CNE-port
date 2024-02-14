//a
function create() {
    sky = new FunkinSprite(-438, -310);
    sky.frames = Paths.getSparrowAtlas('stages/alleyway/images/alleyway');
    sky.animation.addByPrefix('sky', 'skyy', 0, false);
    sky.playAnim('sky');
    sky.active = false;
    insert(members.indexOf(dad)-1, sky);
    sky.scrollFactor.set(0.1, 0.1);

    bg = new FunkinSprite(-438, -310);
    bg.frames = Paths.getSparrowAtlas('stages/alleyway/images/alleyway');
    bg.animation.addByPrefix('bg', 'background', 0, false);
    bg.playAnim('bg');
    bg.active = false;
    insert(members.indexOf(dad),bg);
    
    light = new FunkinSprite(-113, -310);
    light.frames = Paths.getSparrowAtlas('stages/alleyway/images/alleyway');
    light.animation.addByPrefix('light', 'light', 0, false);
    light.playAnim('light');
    light.active = false;
    add(light);
    light.blend = 0;
    light.alpha = 0.3;

    trash = new FunkinSprite(-383, 610);
    trash.frames = Paths.getSparrowAtlas('stages/alleyway/images/alleyway');
    trash.animation.addByPrefix('trash', 'trash', 0, false);
    trash.playAnim('trash');
    trash.active = false;
    add(trash);

    bin = new FunkinSprite(783, 710);
    bin.frames = Paths.getSparrowAtlas('stages/alleyway/images/alleyway');
    bin.animation.addByPrefix('bin', 'bin', 0, false);
    bin.playAnim('bin');
    bin.active = false;
    add(bin);

    for (i in [trash,bin]){ i.scrollFactor.set(1.1, 1.1);}
}
function postCreate(){
    camX = camFollow.x = -25;
    camY = camFollow.y = -25;
}
function beatHit(curBeat) {}