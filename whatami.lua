function string.trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"));
end

function getDescriptors()
	local descriptors = {
		"big",
		"bad",
		"large",
		"kinky",
		"hot",
		"charming",
		"toxic",
		"happy",
		"terrifying",
		"horny",
		"wet",
		"sexy",
		"annoying",
		"irritating",
		"loud",
		"homosexual",
		"heterosexual",
		"gay",
		"straight",
		"independent",
		"oily",
		"slimy",
		"funny",
		"unfunny",
		"religious",
		"patriotic",
		"tasty",
		"strong",
		"buff",
		"wimpy",
		"skimpy",
		"gentle",
		"rough"
	};

	local prefixes = {
		["hot"] = {
			"smokin'",
			"blazin'"
		},
		["homosexual"] = {
			"flaming"
		},
		["heterosexual"] = {
			"privileged"
		}
	};

	local suffixes = {
		["happy"] = {
			"go-lucky"
		}
	};

	local amount = math.random(2, 3);
	local used = {};
	local given = {};

	for i=1,amount do
		local chosenDescriptor = descriptors[math.random(1, #descriptors)];
		while used[chosenDescriptor] do
			chosenDescriptor = descriptors[math.random(1, #descriptors)];
		end

		used[chosenDescriptor] = true;

		local toAdd = chosenDescriptor;
		if math.random(0, 5) == 0 and prefixes[chosenDescriptor] ~= nil then
			toAdd = prefixes[chosenDescriptor][math.random(1, #prefixes[chosenDescriptor])] .. " " .. toAdd;
		end
		if math.random(0, 5) == 0 and suffixes[chosenDescriptor] ~= nil then
			toAdd = toAdd .. " " .. suffixes[chosenDescriptor][math.random(1, #suffixes[chosenDescriptor])];
		end

		if math.random(0, 7) == 0 then
			toAdd = toAdd .. " ass";
		end

		table.insert(given, toAdd);
	end

	return table.concat(given, ", ");
end

function getThing()
	local things = {
		"anime waifu",
		"feminist",
		"meninist",
		"men's rights activist",
		"Blockhead",
		"elite hacker",
		"weed brownie",
		"11 year-old kid",
		"rule breaker",
		"cis scum",
		"mafia scumbag",
		"memer",
		"Ethan Bradberry",
		"ham and cheese sandwich",
		"buttermilk buscuit",
		"glazed donut",
		"racist",
		"id racist",
		"apache attack helicopter",
		"rare pepe",
		"pedobear",
		"salmon",
		"illegal drug",
		"oak tree",
		"lava lamp",
		"bedroom producer",
		"wannabe comedian",
		"college dropout",
		"4th grader"
	};

	return things[math.random(1, #things)];
end

function getAction()
	local actionsIndex = {
		"browses",
		"is",
		"jacks off to",
		"loves",
		"unironically",
		"beats",
		"voted for",
		"supports",
		"thinks",
		"has",
		"posted",
		"spams",
		"wants",
		"looks up",

		"don't need no man",
		"tells lies on the Internet",
		"died. rip.",
		"lost the lottery",
		"won the lottery, somehow",
		"falls for trap links",
		"actually got free admin",
		"smashed that mf like button",
		"doesn't think twice",
		"tells it like it is",
		"caught all 151 pokemon",
		"hosted a CityRPG server",
		"claims it was just a prank, bro",
		"litters. how could you?",
		"claims they know what \"cyka blyat\" means",
		"told someone to \"kys\" and meant it",
		"shits rainbows"
	};

	local actions = {
		["beats"] = {
			"their mother every morning",
			"their meat constantly",
			"oranges to a pulp",
			"The Impossible Game twice a day"
		},
		["browses"] = {
			"4chan on a regular basis",
			"the deep web",
			"their mother's underwear drawer",
			"e621 multiple times a day"
		},
		["has"] = {
			"nothing productive to say",
			"so many dildoes. so many.",
			"blhack.dll",
			"been drama'd " .. math.random(1, 50) .. " times",
			"hairy legs",
			"diabetes",
			"a gambling problem",
			"no idea what antidisestablishmentarianisms are"
		},
		["is"] = {
			"a regular at various Family RP servers",
			"one of *those* Tumblr users",
			"blatantly stealing builds",
			"the Zodiac Killer",
			"probably spamming this command",
			"dead. rip."
		},
		["jacks off to"] = {
			"furry porn",
			"vore",
			"Danny Devito",
			"Jerry Sienfeld",
			"gay porn",
			"their grandfather"
		},
		["looks up"] = {
			"pictures of animal torture",
			"how to make bombs",
			"how to spell words",
			"at the sky for no apparent reason",
			"how to install gentoo",
			"memes",
			"a scary amount of cat pictures"
		},
		["loves"] = {
			"to eat pizza",
			"to shout memes endlessly",
			"fucking memes. literally.",
			"blasting asses into space",
			"pushing buttons",
			"pushing people's buttons",
			"spliced dicks",
			"belly buttons"
		},
		["posted"] = {
			"nudes on the forums",
			"an AMA thread on the forums. thrice."
		},
		["spams"] = {
			"projectiles",
			"large penises on freebuilds"
		},
		["supports"] = {
			"the death penalty",
			"banning all anime",
			"the KKK"
		},
		["thinks"] = {
			"blockland is dying",
			"badspot is hot",
			"the earth is flat",
			"the N word is funny",
			"the BLF community sucks"
		},
		["unironically"] = {
			"likes Rick Astley",
			"has an OkCupid account",
			"has a pair of white Vans",
			"likes \"The Room\"",
			"listens to Linkin Park",
			"uses the word \"literally\" correctly",
			"watches PewDiePie",
			"uses memes involving numbers",
			"uses the word \"fam\"",
			"likes Blockland Machinima",
			"loves puns"
		},
		["voted for"] = {
			"John Cena",
			"Hillary Clinton",
			"Ben Carson",
			"Donald Trump",
			"Bernie Sanders",
			"David Hasselhoff",
			"Vermin Supreme",
			"a loaf of bread"
		},
		["wants"] = {
			"maps back",
			"a dick inside them",
			"to shit profusely",
			"to die",
			"a big, wet kiss"
		}
	};

	local selector = actionsIndex[math.random(1, #actionsIndex)];
	if not actions[selector] then
		return selector;
	end

	local probably = "";
	if math.random(1, 20) == 20 then
		probably = "probably ";
	end

	return probably .. selector .. " " .. actions[selector][math.random(1, #actions[selector])];
end

function whatAmI(name)
	--math.randomseed(18701);

	local joiner = " is a ";
	if not name then
		name = "You";
		joiner = " are a ";
	end

	local descriptors = getDescriptors();
	local thing = getThing();
	local action = getAction();

	return string.upper(name) .. joiner .. string.upper(descriptors) .. " " .. string.upper(thing) .. " who " .. string.upper(action);
end