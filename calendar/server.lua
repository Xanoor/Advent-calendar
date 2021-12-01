--ONLY IF YOU USE ESX !--
if Config.ESX then 
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end


RegisterCommand('calendar', function(source, args)
    local playerId = source 

    TriggerClientEvent('calendar:open', playerId)
end, false)

RegisterNetEvent('calendar:playerExist', function() 
    local date = os.date("%m")

    if date == "12" then 
    else
        return
    end

    local identifier = "000"
    local playerId = source
    for k, v in pairs(GetPlayerIdentifiers(source)) do 
        if string.match( v, "license" ) then 
            identifier = string.sub(v, 9)
            break
        end
    end

    
    MySQL.Async.fetchScalar('SELECT * FROM calendar WHERE identifier = @identifier', {
        ["@identifier"] = identifier;
    }, function(result)
        if not result then
            MySQL.Async.execute('INSERT INTO calendar (day, identifier) VALUES (@day, @identifier)', {
                ['@day'] = 0,
                ['@identifier'] = identifier
            })
        end
    end)

    TriggerClientEvent('calendar:updateAllData', playerId)
end)

RegisterNetEvent('calendar:getPlayerData', function() 
    local identifier = "000"
    local playerId = source
    for k, v in pairs(GetPlayerIdentifiers(source)) do 
        if string.match( v, "license" ) then 
            identifier = string.sub(v, 9)
            break
        end
    end

    MySQL.Async.fetchAll('SELECT * FROM calendar WHERE identifier = @identifier', {
        ["@identifier"] = identifier;
    }, function(result)
        TriggerClientEvent('calendar:setPlayerData', playerId, result)
    end)
end)

RegisterNetEvent('calendar:updateData', function(date) 
    local identifier = "000"
    local playerId = source

    for k, v in pairs(GetPlayerIdentifiers(source)) do 
        if string.match( v, "license" ) then 
            identifier = string.sub(v, 9)
            break
        end
    end

    MySQL.Async.execute('UPDATE calendar SET `day` = @day WHERE identifier = @identifier', {
		['@day'] = date,
		['@identifier'] = identifier
	})  

    TriggerClientEvent('calendar:updateAllData',playerId )
end)


RegisterNetEvent('calendar:getDay', function()
    local player = source
    local date = os.date("%d")

    TriggerClientEvent('calendar:setDay', player, date)
end)


--FOR GIVE ITEM (ESX)--
RegisterNetEvent('calendar:giveItem', function(item, count)
    if Config.ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item, count)
    end
end)