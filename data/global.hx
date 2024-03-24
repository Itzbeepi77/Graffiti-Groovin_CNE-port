static var seenMenuCutscene:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    TitleState => "custom/GroovinTitleMenu",
    MainMenuState => "custom/GroovinMenu",
    StoryMenuState => "custom/GroovinMenu",
    PauseSubState => "PauseMenu",
];

function preStateSwitch() {
	window.title = "Graffiti Groovin";
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}