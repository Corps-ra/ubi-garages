RegisterNetEvent('ubi-garages:ThrowError', function(text)
    error(text)
end)

ESX.RegisterServerCallback('ubi-garages:GetImpound', function(source, callback, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()
    local vehicles = {}

    local worldVehicles = GetAllVehicles()

    MySQL.Async.fetchAll('SELECT `plate`, `vehicle`, `health`, `job` FROM owned_vehicles WHERE (`owner` = @identifier OR `owner` = @job) AND `type` = @type AND `stored` = @stored', {
        ['@identifier'] = identifier,
        ['@type'] = type,
        ['@job'] = xPlayer.job.name,
        ['@stored'] = "out"
    }, function(results)
        if results[1] ~= nil then
            for k, v in pairs(results) do
                local veh = json.decode(v.vehicle)
                local health = json.decode(v.health)
                for index, vehicle in pairs(worldVehicles) do
                    if ESX.Math.Trim(v.plate) == ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) then
                        break
                    elseif index == #worldVehicles then
                        -- Allows players to only get their job vehicle from impound while having the job
                        if (v.job == 'civ' or v.job == nil) or v.job == xPlayer.job.name then
                            table.insert(vehicles, {plate = v.plate, vehicle = veh, health = health})
                        end
                    end
                end
            end
            callback(vehicles)
        else
            callback(nil)
        end
    end)
end)

    

local function canAfford(price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if Config.PayInCash then
            if xPlayer.getMoney() >= price then
                return true
            else
                xPlayer.showNotification("You dont have cash")
                return false
            end
        else
            if xPlayer.getAccountMoney('bank') >= price then
                return true
            else
                xPlayer.showNotification("You dont have balance in bank")
                return false
            end
        end
    end
end


RegisterNetEvent('ubi-garages:SpawnVehicle', function(model, plate, vector, heading, price)
    if type(model) == 'string' then model = GetHashKey(model) end
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicles = GetAllVehicles()
    plate = ESX.Math.Trim(plate)
    if price and not canAfford(price) then return end
     if fuel and not carfuel(fuel) then return end
    for i = 1, #vehicles do
        if ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i])) == plate then return xPlayer.showNotification("Vehicle already exists") end
    end
    Citizen.CreateThread(function()
        local entity = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, model, vector.x, vector.y, vector.z, heading)
        Wait(50)
        local netId = NetworkGetNetworkIdFromEntity(entity)
        local entityOwner = NetworkGetEntityOwner(entity)
        local ped = GetPedInVehicleSeat(entity, -1)
		if ped > 0 then
			for i = -1, 6 do
				ped = GetPedInVehicleSeat(entity, i)
				local popType = GetEntityPopulationType(ped)
				if popType <= 5 or popType >= 1 then
					DeleteEntity(ped)
				end
			end
		end
        
        MySQL.Async.fetchAll('SELECT `fuel`, `vehicle`, `plate`, `health` FROM owned_vehicles WHERE `plate` = @plate', {['@plate'] = ESX.Math.Trim(plate)}, function(result)
            if result[1] then TriggerClientEvent('ubi-garages:SetVehicleMods', entityOwner, netId, result[1]) end
            xPlayer.removeMoney(price)
        end)
    end)
end)
