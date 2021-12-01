local htmlMenu = false
local lastGrid = 00
local day = 00

RegisterNetEvent('calendar:closeMenu')
AddEventHandler('calendar:closeMenu', function()
	htmlMenuIsOpen = false
	SetNuiFocus(false)
	SendNUIMessage({
		hideAll = true
	})
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('calendar:closeMenu')
	cb('ok')
end)


RegisterNetEvent('calendar:open')
AddEventHandler('calendar:open', function()
	htmlMenuIsOpen = true
	SendNUIMessage({
		showMenu = true,
	})

	SetNuiFocus(true, true)
end)

local function notify(text)
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end


local function getItem(date) 
	local name = "AAA"
	local count = 000
	if date == 24 then 
		local rng = math.random(1, #Config.ChristmasItems)
		local result = Config.ChristmasItems[rng]

		name = result.name
		count = result.count

		if date == 24 then
			notify(Config.sentences.finish)
		end
	elseif date < 24 then
		local rng = math.random(1, #Config.Items)
		local result = Config.Items[rng]

		name = result.name 
		count = result.count
	end

	notify(Config.sentences.reward .. count .. " " .. name .. " !")
	TriggerServerEvent('calendar:giveItem', name, count)
end


RegisterNUICallback('submit', function(data)
	local date = 00
	TriggerServerEvent('calendar:getDay')
	Wait(100)

	date = tonumber(data.date)

	if lastGrid < date and day >= date then 
		if date == lastGrid + 1 then 
			getItem(date)
			TriggerServerEvent('calendar:updateData', date)
		else
			notify(Config.sentences.skip_box .. lastGrid+1 .. Config.sentences.skip_box2)
		end
	elseif lastGrid >= date then
		notify(Config.sentences.already)
	else
		notify(Config.sentences.wait .. date .. Config.sentences.wait2)
	end
end)

RegisterNetEvent('calendar:updateAllData', function()
	TriggerServerEvent('calendar:getPlayerData')
	TriggerServerEvent('calendar:getDay')
end)

RegisterNetEvent('calendar:setDay', function(data) 
	day = tonumber(data)
end)

RegisterNetEvent('calendar:setPlayerData', function(data)
	for k, v in pairs(data) do
		lastGrid = tonumber(v.day)
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent('calendar:playerExist')
	Wait(1000)
	if day == 24 then 
		notify(Config.sentences.meryChristmas)
	end
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if htmlMenuIsOpen then
			TriggerEvent('calendar:closeMenu')
		end
	end
end)