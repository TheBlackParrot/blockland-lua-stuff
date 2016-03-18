package ohmygod {
	function serverCmdMessageSent(%client, %msg) {
		%r = parent::serverCmdMessageSent(%client, %msg);

		if(stripChars(%msg, "?") $= "what am i") {
			talk(luaCall("whatAmI", %client.name));
		}

		return %r;
	}
};
activatePackage(ohmygod);