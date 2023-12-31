import funkin.backend.utils.NativeAPI;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "custom/groovinMenu",
    StoryMenuState => "custom/groovinMenu"// well uhh personal reasons
];

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

function preStateSwitch() {
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}