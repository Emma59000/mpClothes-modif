local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSh4587poiaredObj4587poiect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterServerEvent('mpClothes:generatepropsize')
AddEventHandler('mpClothes:generatepropsize', function(data)

    local _source = source;
    local xPlayer = ESX.GetPlayerFromId(_source);
    if xPlayer.getGroup() ~= 'user' then 
        print ('Save new prop size max data.json')
        jsonMaxSizeCache = nill
        SaveResourceFile(GetCurrentResourceName(), 'data.json', json.encode(data, { indent = true }), -1);
    else
        DropPlayer(_source, 'Unauthorized command')
    end
end)