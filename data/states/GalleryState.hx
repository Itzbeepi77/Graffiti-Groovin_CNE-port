import funkin.backend.utils.DiscordUtil;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;

//Script made by Alex Araneus (alexaraneus)

final data:Array = Json.parse(Assets.getText(Paths.json('../images/gallery/data')));

var curSelected:Int = 0;
var bg:FlxBackdrop;
var images:FlxSpriteGroup = new FlxSpriteGroup();
var title:FlxText;
var desc:FlxText;

function create() {
    //If you want to add custom Discord presence
    //DiscordUtil.changePresence("In the Gallery", null);

    FlxG.mouse.visible = true;

    bg = new FlxBackdrop(Paths.image('gallery/' + data.bgSettings.image));
    bg.antialiasing = data.bgSettings.antialiasing;
    bg.scale.set(data.bgSettings.scale.width, data.bgSettings.scale.height);
    bg.color = FlxColor.fromString(data.bgSettings.color);
    add(bg);

    if (data.images[0] != null) {
        for (i in 0...data.images.length) {
			addGalleryImage(data.images[i].filename, i);
        }
        add(images);
    } else {
        var error = new FlxText(0, 0, 600, "Oops, couldn't find any images :(", 30, true);
        error.setFormat(Paths.font(data.textFont), 30, 0xFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
        error.screenCenter();
        error.borderSize = 3;
        add(error);
    }

    title = new FlxText(0, 0, 900, data.images[curSelected].title, 30, true);
    title.setFormat(Paths.font(data.textSettings.titleFont), data.textSettings.titleSize, FlxColor.fromString(data.textSettings.titleColor), "center", FlxTextBorderStyle.OUTLINE, FlxColor.fromString(data.textSettings.titleBorderColor));
    title.x = (FlxG.width - title.width) / 2;
    title.y = (images.members[curSelected].y - title.height) / 2;
    title.borderSize = data.textSettings.titleBorderSize;
    add(title);

    desc = new FlxText(0, 0, 1200, data.images[curSelected].description, 20, true);
    desc.setFormat(Paths.font(data.textSettings.descFont), data.textSettings.descSize, FlxColor.fromString(data.textSettings.descColor), "center", FlxTextBorderStyle.OUTLINE, FlxColor.fromString(data.textSettings.descBorderColor));
    desc.x = (FlxG.width - desc.width) / 2;
    desc.y = ((FlxG.height - desc.height - images.members[curSelected].y - images.members[curSelected].height) / 2) + (images.members[curSelected].height + images.members[curSelected].y);
    desc.borderSize = data.textSettings.descBorderSize;
    add(desc);
}

function update(elapsed:Float) {
    bg.x += elapsed * 100 * data.bgSettings.velocity.x;
    bg.y += elapsed * 100 * data.bgSettings.velocity.y;
    
    if (controls.BACK) FlxG.switchState(new MainMenuState());
    if (controls.LEFT_P) changeImage(-1) else if (controls.RIGHT_P) changeImage(1);

	images.forEach(function(img:FlxSprite){
		if (img.ID == curSelected) {
            img.x = CoolUtil.fpsLerp(img.x, (FlxG.width - img.width) / 2, 0.125);
        } else if (curSelected > img.ID) {
            img.x = images.members[img.ID+1].x - images.members[img.ID].width - 100;
        } else if (curSelected < img.ID) {
            img.x = images.members[img.ID-1].x + images.members[img.ID-1].width + 100;
        }
	});
}

inline function changeText():Void {
    title.text = data.images[curSelected].title;
    title.x = (FlxG.width - title.width) / 2;
    title.y = (images.members[curSelected].y - title.height) / 2;

    desc.text = data.images[curSelected].description;
    desc.x = (FlxG.width - desc.width) / 2;
    desc.y = ((FlxG.height - desc.height - images.members[curSelected].y - images.members[curSelected].height) / 2) + (images.members[curSelected].height + images.members[curSelected].y);
}

function changeImage(number:Int):Void {
    curSelected += number;
    if (curSelected < 0) curSelected = 0;
    if (curSelected > data.images.length - 1) curSelected = data.images.length - 1;
    changeText();
}

function addGalleryImage(filename:String, num:Int):Void {
	var image = new FlxSprite(0, 0, Paths.image('gallery/images/' + filename));
	if (data.images[num].antialiasing != null && data.images[num].antialiasing) image.antialiasing = true;
	if (data.images[num].resize != null && data.images[num].resize) image.scale.set(calculateScale(image), calculateScale(image));
	image.updateHitbox();
    image.y = (FlxG.height - image.height) / 2;
    image.ID = num;
	images.add(image);
}

inline function calculateScale(img:FlxSprite):Float {
	var imgWidth:Float = (FlxG.width - 400) / img.width;
	var imgHeight:Float = (FlxG.height - 200) / img.height;
	var scale:Float = imgWidth <= imgHeight ? imgWidth : imgHeight;
	return scale;
}