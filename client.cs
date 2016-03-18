//luaExec("./markov.lua");
//temp
luaExec("Add-Ons/Client_LuaStuff/markov.lua");
luaExec("Add-Ons/Client_LuaStuff/whatami.lua");

function addToMarkovCorpus(%phrase, %word) {
	//echo("added" SPC %word SPC "to" SPC %phrase);
	%phrase = strReplace(%phrase, "\"", "\\\"");
	%word = strReplace(%word, "\"", "\\\"");

	luaEval("addToCorpus(\"" @ %phrase @ "\", \"" @ %word @ "\");");
}

package LuaStuffPackage {
	function clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color) {
		%firstChar = stripChars(getSubStr(%msg, 0, 1), "!@#$%^&()_-+=[]{}\\|';:,./<>?");

		if(%firstChar $= "") {
			if(getWord(%msg, 0) $= ">>markov") {
				switch($Pref::Client::Markov::AllowChat) {
					case 0:
						return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);

					case 1:
						if(stripMLControlChars(%name) !$= $pref::Player::NetName) {
							return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);
						}
				}

				commandToServer('messageSent', "++" SPC luaCall("getMarkovChain", getWords(%msg, 1, getWordCount(%msg))));
			} else if(getWord(%msg, 0) $= ">>whatami") {
				switch($Pref::Client::Markov::AllowChat) {
					case 0:
						return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);

					case 1:
						if(stripMLControlChars(%name) !$= $pref::Player::NetName) {
							return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);
						}
				}

				commandToServer('messageSent', "++" SPC luaCall("whatAmI", %name));
			} else {
				return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);
			}
		}

		%phrase = getWords(%msg, 0, 1);
		for(%i=1;%i<getWordCount(%msg);%i++) {
			%next = getWord(%msg, %i+1);

			addToMarkovCorpus(%phrase, %next);

			%phrase = getWord(%phrase, 1) SPC %next;
		}

		return parent::clientCmdChatMessage(%a,%b,%c,%fmsg,%cp,%name,%cs,%msg,%color);
	}

	function onExit(%a,%b,%c,%d,%e,%f) {
		luaEval("saveCorpus();");
		return parent::onExit(%a,%b,%c,%d,%e,%f);
	}
};
activatePackage(LuaStuffPackage);