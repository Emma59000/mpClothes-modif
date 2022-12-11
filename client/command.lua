local StaffMod = false
local ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSh4587poiaredObj4587poiect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


function getMaxVals()
	local playerPed = PlayerPedId()
	
	local data = {
		skin			= 45,
		age_1			= GetNumHeadOverlayValues(3)-1,
		age_2			= 10,
		beard_1			= GetNumHeadOverlayValues(1)-1,
		beard_2			= 10,
		beard_3			= GetNumHairColors()-1,
		beard_4			= GetNumHairColors()-1,
		hair_1			= GetNumberOfPedDrawableVariations		(playerPed, 2) - 1,
		hair_color_1	= GetNumHairColors()-1,
		hair_color_2	= GetNumHairColors()-1,
		eye_color		= 31,
		eyebrows_1		= GetNumHeadOverlayValues(2)-1,
		eyebrows_2		= 10,
		eyebrows_3		= GetNumHairColors()-1,
		eyebrows_4		= GetNumHairColors()-1,
		makeup_1		= GetNumHeadOverlayValues(4)-1,
		makeup_2		= 10,
		makeup_3		= GetNumHairColors()-1,
		makeup_4		= GetNumHairColors()-1,
		lipstick_1		= GetNumHeadOverlayValues(8)-1,
		lipstick_2		= 10,
		lipstick_3		= GetNumHairColors()-1,
		lipstick_4		= GetNumHairColors()-1,
		blemishes_1		= GetNumHeadOverlayValues(0)-1,
		blemishes_2		= 10,
		blush_1			= GetNumHeadOverlayValues(5)-1,
		blush_2			= 10,
		blush_3			= GetNumHairColors()-1,
		complexion_1	= GetNumHeadOverlayValues(6)-1,
		complexion_2	= 10,
		sun_1			= GetNumHeadOverlayValues(7)-1,
		sun_2			= 10,
		moles_1			= GetNumHeadOverlayValues(9)-1,
		moles_2			= 10,
		chest_1			= GetNumHeadOverlayValues(10)-1,
		chest_2			= 10,
		chest_3			= GetNumHairColors()-1,
		bodyb_1			= GetNumHeadOverlayValues(11)-1,
		bodyb_2			= 10,
		eans_1			= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		tshirt_1		= GetNumberOfPedDrawableVariations		(playerPed, 8) - 1,
		torso_1			= GetNumberOfPedDrawableVariations		(playerPed, 11) - 1,
		decals_1		= GetNumberOfPedDrawableVariations		(playerPed, 10) - 1,
		arms			= GetNumberOfPedDrawableVariations		(playerPed, 3) - 1,
		arms_2			= 10,
		pants_1			= GetNumberOfPedDrawableVariations		(playerPed, 4) - 1,
		shoes_1			= GetNumberOfPedDrawableVariations		(playerPed, 6) - 1,
		mask_1			= GetNumberOfPedDrawableVariations		(playerPed, 1) - 1,
		bproof_1		= GetNumberOfPedDrawableVariations		(playerPed, 9) - 1,
		chain_1			= GetNumberOfPedDrawableVariations		(playerPed, 7) - 1,
		bags_1			= GetNumberOfPedDrawableVariations		(playerPed, 5) - 1,
		helmet_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 0) - 1,
		glasses_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		watches_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 6) - 1,
		bracelets_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 7) - 1,
	}

	return data
end


local created = false;
AddEventHandler('ad_maladie:staffmod', function(_StaffMod)
    StaffMod = _StaffMod;
	
	if not created then
		created = true
		RegisterCommand("generatepropsize", function()
			if StaffMod == true then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		
					local data = {};
					local previousSex = skin.sex;
		
					ESX.ShowAdvancedNotification('Administation', '~r~Server', 'Generation des valeurs ...', 'CHAR_MAUDE', 1)
		
					TriggerEvent("skinchanger:change", "sex", 0)
					Wait(2000)
					data.m = getMaxVals()
					TriggerEvent("skinchanger:change", "sex", 1)
					Wait(2000)
					data.f = getMaxVals()
					TriggerEvent("skinchanger:change", "sex", previousSex)
		
					ESX.ShowAdvancedNotification('Administation', '~r~Server', 'Generation des valeurs: OK (Redémarrer le serveur)', 'CHAR_MAUDE', 1)
		
					TriggerServerEvent('mpClothes:generatepropsize', data)
		
				end)
			else
				ESX.ShowAdvancedNotification('Administation', '~r~Server', 'Cette comande est réservé aux staffs en service !!!', 'CHAR_MAUDE', 1)
			end
		end)
	end
end)