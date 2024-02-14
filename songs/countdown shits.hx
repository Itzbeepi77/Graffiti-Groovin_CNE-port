import funkin.backend.FunkinSprite;

var Skarintro:Character;

var countNum = new FunkinSprite();

// introSounds
introSounds = ['intro3', 'intro2', 'intro1', 'introGo', null];

// for 3,2,1,GO images, I made it null since the thingy is animated
introSprites = [null, null, null, null];

function create(){
    countNum = new FunkinSprite(350, 150);// countdown numbers thingys
    countNum.frames = Paths.getSparrowAtlas("countdown");
    countNum.animation.addByPrefix('1', 'one0', 24, false);
    countNum.animation.addByPrefix('2', 'two0', 24, false);
    countNum.animation.addByPrefix('3', 'three0', 24, false);
    countNum.animation.addByPrefix('go', 'go0', 24, false);
    countNum.updateHitbox();
    countNum.alpha = 0.001;
    countNum.cameras = [camHUD];
    countNum.antialiasing = true;
    countNum.addOffset('1', -130, -50);
    countNum.addOffset('2', -130, -50);
    countNum.addOffset('3', -130, -50);
}

function onCountdown(event) {// countdown thingy
    switch(curSong){
        case 'soda-pop', 'groovin':
            switch(event.swagCounter) {
                case 0:
                        Skarintro.playAnim('three', true);
                        dad.alpha = 0.001; 
                        Skarintro.alpha = 1; 
                        countNum.playAnim('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                        Skarintro.playAnim('two', true); 
                        countNum.playAnim('2', true);
    
                case 2: 
                        Skarintro.playAnim('one', true); 
                        countNum.playAnim('1', true);
    
                case 3: 
                        Skarintro.playAnim('go'); 
                        countNum.playAnim('go', true);

                case 4:
                        countNum.alpha = 0.001;
                        dad.alpha = 1; 
                        Skarintro.alpha = 0.001; 
            };

        case 'streetstyle':
                event.cancel();

        default:
            switch(event.swagCounter) {
                case 0:
                        countNum.playAnim('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                        countNum.playAnim('2', true);
    
                case 2:
                        countNum.playAnim('1', true);
    
                case 3: 
                        countNum.playAnim('go', true);

                case 4:
                        countNum.alpha = 0.001;
            };
    }
}
function onSongStart(){
        if (curSong == 'streetstyle') camera.alpha = 1;
}
function postCreate(){
	Skarintro = new Character(0, 0, "countdown", false);
	Skarintro.alpha = 0.0001;
	insert(members.indexOf(dad)+1, Skarintro);
    
        Skarintro.x = dad.x+20;
        Skarintro.y = dad.y+15;
    
        add(countNum);
        if (curSong == 'streetstyle') camera.alpha = 0.001;
        trace("Countdown Shits");
}