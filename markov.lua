function isFile(file)
	local file = io.open(file, "rb");

	if file then
		file:close()
	end

	return file ~= nil;
end

function readFile(file)
	if not isFile(file) then
		return {};
	end

	local lines = {};
	
	for line in io.lines(file) do
		lines[#lines + 1] = line;
	end

	return lines;
end

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true;
		end
	end

	return false;
end

function split(data, separator)
	local fields = {};
	
	if not separator then
		separator = "%s";
	end

	for field in string.gmatch(data, "([^" .. separator .. "]+)") do
		fields[#fields + 1] = field;
	end

	return fields;
end

function addToCorpus(index, data)
	if data == "" then
		data = nil;
	end

	if not corpus[index] then
		corpus[index] = {data};
		table.insert(corpusIndex, index);
	else
		if not table.contains(corpus[index], data) then
			table.insert(corpus[index], data);
		end
	end
end

function loadCorpus()
	local file = "config/client/markov/corpusL.txt";
	local lines = readFile(file);

	local count = 0;
	for key, line in pairs(lines) do
		local fields = split(line, "%\t");

		local phrase = fields[1];
		for i=2,#fields do
			addToCorpus(phrase, fields[i]);
		end

		count = count + 1;
		if count % 500 == 0 then
			print("Imported " .. count .. " lines...");
		end
	end

	print("Imported " .. count .. " lines...");
end

function saveCorpus()
	local filename = "config/client/markov/corpusL.txt";
	local file = io.open(filename, "w");

	local count = 0;
	for key, data in pairs(corpus) do
		file:write(key .. "\t" .. table.concat(data, "\t") .. "\n");

		count = count + 1;
		if count % 500 == 0 then
			print("Exported " .. count .. " lines...");
		end
	end

	print("Exported " .. count .. " lines...");

	file:close();
end

function getMarkovChain(generatedChain)
	local phrase = corpusIndex[math.random(1, #corpusIndex)];
	if not generatedChain then
		generatedChain = phrase;
	else
		local _ = split(generatedChain);
		if #_ >= 2 then
			phrase = _[#_ - 1] .. " " .. _[#_];
		else
			generatedChain = phrase;
		end
	end

	if corpus[phrase] ~= nil then
		if corpus[phrase][1] ~= nil then
			while corpus[phrase] ~= nil and string.len(generatedChain) < 144 do
				local nextWord = corpus[phrase][math.random(1, #corpus[phrase])];

				if nextWord ~= nil then
					generatedChain = generatedChain .. " " .. nextWord;

					local tempSplit = split(phrase);
					phrase = tempSplit[2] .. " " .. nextWord;
				else
					break;
				end
			end
		end
	else
		generatedChain = "I haven't learned enough to know what to say here. :(";
	end

	return generatedChain;
end

if not hasLoaded then
	_G.corpus = {};
	_G.corpusIndex = {};

	hasLoaded = true;
	loadCorpus();
end

--[[
function testFields()
	local data = "this\tis\ta\ttest hey";
	local fields = split(data, "%\t");

	print(data);
	for key, field in pairs(fields) do
		print("[" .. key .. "] = " .. field);
	end
end
testFields();
--]]