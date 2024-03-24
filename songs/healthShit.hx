/** This is where all the health placed
 * a bit messy I know but better than never,
 * right..?
 * **/
import flixel.math.FlxRect;
import flixel.math.FlxPoint;
import groovin.game.AnimatedIcon;

public var leftBar:FlxSprite = new FlxSprite(0, 615);
public var rightBar:FlxSprite = new FlxSprite(0, 615);
public var barBG:FlxSprite;

public var skarletBar:FunkinSprite = new FunkinSprite(1000, !downscroll? 50: 500);
public var moraBar:FunkinSprite = new FunkinSprite(0, !downscroll? 50: 500);
public var opponentLives:Int = 5;
public var hit:Float = 3;
public var anims = ['3', '2', '1', '2-loss', '1-loss'];

public var barWidth:Float = 1;
public var barHeight:Float = 1;
public var barOffset:FlxPoint = new FlxPoint(0, 0);
public var posOffset:FlxPoint = new FlxPoint(0, 37);

function create(){

    leftBar.frames = Paths.getSparrowAtlas("hpBar");
    leftBar.animation.addByPrefix("idle", "mask", 24, true);
    leftBar.animation.play("idle");
    leftBar.scale.set(0.668, 0.69); // bigger than 2/3 to fix any small gaps
    leftBar.updateHitbox();
    leftBar.screenCenter(FlxAxes.X);
    leftBar.scrollFactor.set();
    leftBar.cameras = [camHUD];
    leftBar.flipX = true;
    leftBar.clipRect = new FlxRect(0, 0, leftBar.frameWidth, leftBar.frameHeight);
    
    rightBar.frames = Paths.getSparrowAtlas("hpBar");
    rightBar.animation.addByPrefix("idle", "mask", 24, true);
    rightBar.animation.play("idle");
    rightBar.scale.set(0.668, 0.69); // bigger than 2/3 to fix any small gaps
    rightBar.updateHitbox();
    rightBar.screenCenter(FlxAxes.X);
    rightBar.scrollFactor.set();
    rightBar.cameras = [camHUD];
    rightBar.flipX = true;
    rightBar.clipRect = new FlxRect(0, 0, rightBar.frameWidth, rightBar.frameHeight);

    barBG = new FlxSprite(0, 578);
    barBG.frames = Paths.getSparrowAtlas("hpBar");
    barBG.animation.addByPrefix("idle", "front", 24, true);
    barBG.animation.play("idle");
    barBG.scale.set(2/3, 2/3);
    barBG.updateHitbox();
    barBG.screenCenter(FlxAxes.X);
    barBG.cameras = [camHUD];
    barBG.scrollFactor.set();
    
    rightBar.antialiasing = leftBar.antialiasing = barBG.antialiasing = true;
    
    moraBar.frames = Paths.getSparrowAtlas("stages/fightuwu/images/battleSystem/MORA BAR");
    moraBar.animation.addByPrefix('anim', 'hp bar', 0, false);
    moraBar.animation.play('anim', true, false, 5 - opponentLives);
    moraBar.animation.pause();
    moraBar.setGraphicSize(Std.int(moraBar.width / 1.1));
    moraBar.updateHitbox();
    moraBar.scrollFactor.set();
    moraBar.cameras = [camHUD];
    //leftBar.screenCenter();

    skarletBar.frames = Paths.getSparrowAtlas('skarlet/images/hud/health/health-skarlet');
    for (i in 0...anims.length) skarletBar.animation.addByPrefix(anims[i], anims[i] + '0', 24, false);
    skarletBar.setGraphicSize(Std.int(skarletBar.width / 1.4));
    skarletBar.updateHitbox();
    skarletBar.animation.play('3');
    skarletBar.cameras = [camHUD];
    
    if (curSong == "freakpunk"){
        add(moraBar);
        add(skarletBar);
    } else {
        add(rightBar);
        add(leftBar);
        add(barBG);

        if(downscroll){
            rightBar.angle = leftBar.angle = barBG.angle = 180;
        }
    }
    barWidth = rightBar.frameWidth = leftBar.frameWidth;
    barHeight = rightBar.frameHeight = leftBar.frameHeight;
}

function beatHit(curBeat){
    skarletBar.animation.play(skarletBar.animation.curAnim.name);// for anim shit
}

function postCreate(){
    healthBar.alpha = 0.001;
    healthBarBG.alpha = 0.001;
}

public var displayHealth:Float = 1;
    
function update(elapsed){
    leftBar = leftBar;
    rightBar = rightBar;

    leftBar.screenCenter(FlxAxes.X);
    rightBar.screenCenter(FlxAxes.X);
    leftBar.x += posOffset.x;
    rightBar.x += posOffset.x;

    displayHealth = FlxMath.lerp(displayHealth, health, FlxMath.bound(0.2 * 60 * elapsed, 0, 1));
    if(Math.abs(displayHealth - health) < 0.01)
        displayHealth = health;

    var percent = 1 - displayHealth / 2;

    percent = FlxMath.bound(percent, 0, 1);

    var leftSize:Float = 0;
    leftSize = FlxMath.lerp(0, barWidth, percent);
    if(!downscroll) leftSize = barWidth - leftSize;
    
    leftBar.clipRect.width = leftSize;
    leftBar.clipRect.height = barHeight;
    leftBar.clipRect.x = barOffset.x;
    leftBar.clipRect.y = barOffset.y;

    rightBar.clipRect.width = barWidth + leftSize;
    rightBar.clipRect.height = barHeight;
    rightBar.clipRect.x = barOffset.x - leftSize;
    rightBar.clipRect.y = barOffset.y;

    leftBar.clipRect = leftBar.clipRect;
    rightBar.clipRect = rightBar.clipRect;

    var barCenter = leftBar.x + rightBar.width * percent + barOffset.x;

    var iconSep = 26;

    var oppX = (opponentIcon.curCharacter == "skarlet"? 75: opponentIcon.curCharacter == "nikku"? 75: 85/2);

    if (curSong != "freakpunk"){
        opponentIcon.x = barCenter - 150 / 2 - iconSep / 2 - oppX;// - (300) / 2 - iconOffset
        playerIcon.x = barCenter + 300 / 2 + iconSep / 2 - 85/2;
    }
}