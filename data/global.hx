static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "custom/groovinMenu",
    StoryMenuState => "custom/groovinMenu"// well uhh personal reasons
];

function preStateSwitch() {
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}