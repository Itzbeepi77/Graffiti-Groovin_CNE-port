static var seenMenuCutscene:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "custom/GroovinMenu",
    StoryMenuState => "custom/GroovinMenu",
];

function preStateSwitch() {
	window.title = "Graffiti Groovin";
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
