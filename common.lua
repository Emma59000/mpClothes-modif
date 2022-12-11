ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSh4587poiaredObj4587poiect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function skipValue(sex, name, value, direction)

	local gender = sex  == 0 and 'm' or 'f'

	if (config[gender].main_skip[name]) then
		for k, skip in pairs(config[gender].main_skip[name]) do
			if (value >= skip.min and value <= skip.max) then
				if (direction > 0) then
					return skip.max + 1;
				end
				return skip.min - 1;
			end
		end
	end

	local customStart = getStartCustom(sex, name);

	if customStart ~= nil then

		if (config[gender].custom_skip[name]) then
			for k, skip in pairs(config[gender].custom_skip[name]) do
				if (value >= (skip.min + customStart) and value <= (skip.max + customStart)) then
					if (direction > 0) then
						return customStart + skip.max + 1;
					end
					return customStart + skip.min - 1;
				end
			end
		end

	end
	return value
end

function valueInContinue(sex, name, value)
	local remove = 0;
	local gender = sex == 0 and 'm' or 'f';

	if (config[gender].main_skip[name]) then
		for k, skip in pairs(config[gender].main_skip[name]) do
			if (value >= skip.max) then
				remove = remove + skip.max - skip.min + 1
			end
		end
	end

	local customStart = getStartCustom(sex, name);

	if customStart ~= nil then

		if (config[gender].custom_skip[name]) then
			for k, skip in pairs(config[gender].custom_skip[name]) do
				if (value >= (skip.max + customStart)) then
					remove = remove + skip.max - skip.min + 1
				end
			end
		end

	end
	
	return value - remove;
end


function continueToValue(sex, name, continue)
	local value = -2;
	local gender = sex == 0 and 'm' or 'f';
	local customStart = getStartCustom(sex, name);
	
	for i = -1, continue, 1 do
		value = value + 1;

		if (config[gender].main_skip[name]) then
			for k, skip in pairs(config[gender].main_skip[name]) do
				if (i >= skip.min and i <= skip.max) then
					value = value + skip.max - skip.min + 1
				end
			end
		end

		if customStart ~= nil then

			if (config[gender].custom_skip[name]) then
				for k, skip in pairs(config[gender].custom_skip[name]) do
					if (i >= (skip.min + customStart) and i <= (skip.max + customStart)) then
						value = value + skip.max - skip.min + 1
					end
				end
			end
	
		end

	end
	
	return value;
end


function isSkipped(sex, name, value)
	local gender = sex  == 0 and 'm' or 'f'

	if (config[gender].main_skip[name]) then
		for k, skip in pairs(config[gender].main_skip[name]) do
			if (value >= skip.min and value <= skip.max) then
				return true;
			end
		end
	end

	local customStart = getStartCustom(sex, name);

	if customStart ~= nil then

		if (config[gender].custom_skip[name]) then
			for k, skip in pairs(config[gender].custom_skip[name]) do
				if (value >= (skip.min + customStart) and value <= (skip.max + customStart)) then
					return true;
				end
			end
		end

	end
	return false;
end


jsonMaxSizeCache = nil;

function getMaxVals(sex)
	local gender = sex == 0 and 'm' or 'f';
	if (jsonMaxSizeCache == nil) then
		local file = LoadResourceFile(GetCurrentResourceName(), 'data.json');
		jsonMaxSizeCache = json.decode(file);
	end
	return jsonMaxSizeCache[gender] or {}
end


function getCustomQuantity(sex, name)
	local gender = sex == 0 and 'm' or 'f'
	local customStart = config[gender].custom_quantity[name];
	return config[gender].custom_quantity[name];
end


function getStartCustom(sex, name)
	local customQuantity = getCustomQuantity(sex, name);
	local maxs = getMaxVals(sex);
	if customQuantity ~= nil then
		local maxs = getMaxVals(sex);
		return maxs[name] - customQuantity + 1;
	end
	return nil;
end


function isCustom(sex, name, value)

	local customStart = getStartCustom(sex, name);
	if customStart ~= nil then
		return customStart <= value;
	end
	return false;
end

function toCustomId(sex, name, value)
	if (isCustom(sex, name, value)) then
		local customStart = getStartCustom(sex, name);
		return value - customStart;
	end
	return value
end

function fromCustomId(sex, name, value)
	local customStart = getStartCustom(sex, name);
	if customStart ~= nil then
		return value + customStart;
	end
	return value
end

function toCustomSkin(skin)
	if skin == nil then
		return nil
	end
	local skin2 = {}
	for k,v in pairs(skin) do
		if (not string.find(k, '_custom', 1, true)) then 
			if isCustom(skin.sex, k, v) then
				skin2[k] = toCustomId(skin.sex, k, v);
				skin2[k..'_custom'] = 1;
			else
				skin2[k] = v;
				skin2[k..'_custom'] = 0;
			end
		end
	end
	return skin2;
end


function fromCustomSkin(skin)
	if skin == nil then
		return nil
	end
	local skin2 = {}
	for k,v in pairs(skin) do
		if (not string.find(k, '_custom', 1, true)) then 
			if (skin[k..'_custom'] == 1) then
				skin2[k] = fromCustomId(skin.sex, k, v);
			else
				skin2[k] = v;
			end

		end
	end
	return skin2;
end
