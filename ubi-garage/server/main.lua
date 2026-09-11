ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	TriggerEvent('ubi-garage:setvehicelhpim', "2")
	print("ubi-garage: set all vehicle in outside to impound")
end)

RegisterServerEvent('ubi-garage:printGetProperties')
AddEventHandler('ubi-garage:printGetProperties', function()
	print('Getting Properties')
end)

ESX.RegisterServerCallback('ubi-garage:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local properties = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(data)
		for _,v in pairs(data) do
			table.insert(properties, v.name)
		end
		cb(properties)
	end)
end)

ESX.RegisterServerCallback('ubi-garage:isVehicleOwned', function(source, cb, plate, location)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(data)
		if data[1] ~= nil and location then
			MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, `location` = @location WHERE plate = @plate', {
				['@stored'] = "in",
				['@plate'] = plate,
				['@location'] = location
			}, function(rowsChanged)
				if rowsChanged == 0 then
					
				end
				cb(true)
			end)
		else 
			cb(data)
		end
	end)
end)

ESX.RegisterServerCallback('ubi-garage:getAllOwnedVehicles', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ownedCars = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier,
		
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
		
end)

ESX.RegisterServerCallback('ubi-garage:getSharedVehicles', function(source, cb, job, type)

	if job == 'police' then
		if type == 'cars' then
			local sharedPoliceCars = {}
			MySQL.Async.fetchAll('SELECT * FROM shared_vehicles WHERE Type = @Type AND job = @job', {
				['@Type'] = 'car',
				['@job'] = 'police',
				['@category'] = 'cars'
			}, function(data)
				for _,v in pairs(data) do
					local vehicle = json.decode(v.vehicle)
					table.insert(sharedPoliceCars, {vehicle = vehicle, plate = v.plate, vehName = v.name, fuel = v.fuel, stored = v.stored})
				end
				cb(sharedPoliceCars)
			end)
		end
	end
	
end)

ESX.RegisterServerCallback('ubi-garage:vehicle', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job AND `stored` = @stored', {
			['@owner']  =	xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)

ESX.RegisterServerCallback('ubi-garage:getOwnedVehiclesall', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND location = @location AND job = @job AND `stored` = @stored AND vehiclename = @vehiclename', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@vehiclename'] = vehiclename,
			['@job']    = 'civ',
			['@stored'] = stored,
			['@location'] = location
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)

-- ambulance garage
ESX.RegisterServerCallback('ubi-garage:ownedAmbulanceCars', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND location = @location AND job = @job AND `stored` = @stored', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@stored'] = "in",
			['@location'] = location
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND location = @location AND Type = @Type AND job = @job', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@location'] = 'ambulanceGarage'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)
		
-- police garage
ESX.RegisterServerCallback('ubi-garage:policegarage', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND location = @location AND job = @job AND `stored` = @stored', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@stored'] = "in",
			['@location'] = location
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND location = @location AND Type = @Type AND job = @job', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@location'] = 'policeGarageMRPD'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)

-- garasi seluruh

ESX.RegisterServerCallback('ubi-garage:garageall', function(source, cb, currentLoc)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local location = currentLoc
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND location = @location AND job = @job AND `stored` = @stored', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@stored'] = "in",
			['@location'] = location
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND location = @location AND Type = @Type AND job = @job', {
			['@owner']  = xPlayer.identifier,
			['@Type']   = 'car',
			['@job']    = 'civ',
			['@location'] = location
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, location = v.location, fuel = v.fuel, plate = v.plate})
			end
			cb(ownedCars)
		end)
	end
end)

ESX.RegisterServerCallback('ubi-garage:getOutOwnedCars', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', {
		['@owner'] = xPlayer.identifier,
		['@Type']   = 'car',
		['@stored'] = 'out'
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)


-- IMP bayar 
ESX.RegisterServerCallback('ubi-garage:storeVehicle', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehiclePropsjson = json.encode(vehicleProps)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate ', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle, job = @job WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = vehiclePropsjson,
					['@plate'] = vehicleProps.plate,
					['job'] = 'civ'
				}, function (rowsChanged)
					if rowsChanged == 0 then
						print(('ubi-garage: %s attempted to store an vehicle they don\'t own!'):format(xPlayer.identifier))
					end
					cb(true)
				end)
			else
				if Config.Main.KickCheaters then
					if Config.Main.CustomKickMsg then
						print(('ubi-garage: %s attempted to Cheat! Tried Storing: %s | Original Vehicle: %s '):format(xPlayer.identifier, vehiclemodel, originalvehprops.model))
						cb(false)
					else
						print(('ubi-garage: %s attempted to Cheat! Tried Storing: %s | Original Vehicle: %s '):format(xPlayer.identifier, vehiclemodel, originalvehprops.model))
						cb(false)
					end
				else
					print(('ubi-garage: %s attempted to Cheat! Tried Storing: %s | Original Vehicle: %s '):format(xPlayer.identifier, vehiclemodel, originalvehprops.model))
					cb(false)
				end
			end
		else
			MySQL.Async.fetchAll('SELECT * FROM shared_vehicles WHERE plate = @plate', {
				['@plate'] = vehicleProps.plate
			}, function (result)
				if result[1] ~= nil then
					local originalvehprops = json.decode(result[1].vehicle)
					if originalvehprops.model == vehiclemodel then
						MySQL.Async.execute('UPDATE shared_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
							['@plate'] = vehicleProps.plate,
							['@vehicle'] = json.encode(vehicleProps)
						}, function (rowsChanged)
							if rowsChanged == 0 then
								print(('ubi-garage: %s attempted to store an vehicle they don\'t own!'):format(xPlayer.identifier))
							end
							cb(true)
						end)
					end
				else
					print(('made it here'):format(xPlayer.identifier))
					cb(false)
				end
			end)
		end
	end)
	
	

	
end)

ESX.RegisterServerCallback('ubi-garage:getname', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if Config.DontShowPoundCarsInGarage == true then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
			['@owner']  = xPlayer.identifier,
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle})
			end
			cb(ownedCars)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
			['@owner']  = xPlayer.identifier,
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle})
			end
			cb(ownedCars)
		end)
	end
end)

-- Pay to Return Broken Vehicles
RegisterServerEvent('ubi-garage:payhealth')
AddEventHandler('ubi-garage:payhealth', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. price)

	if Config.Main.GiveSocMoney then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			account.addMoney(price)
		end)
	end
end)

-- Rename Vehicle
RegisterServerEvent('ubi-garage:renameVehicle')
AddEventHandler('ubi-garage:renameVehicle', function(plate, name)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET name = @name WHERE plate = @plate', {
		['@name'] = name,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)



-- Set kednraaan state
RegisterServerEvent('ubi-garage:setVehicleState')
AddEventHandler('ubi-garage:setVehicleState', function(plate, state, location, state1, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, `location` = @location, state = @state WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate,
		['@location'] = location,
		['@state'] = state1,
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET `stored` = @stored, `location` = @location, state = @state WHERE plate = @plate', {
				['@stored'] = state,
				['@plate'] = plate,
				['@location'] = location,
				['@state'] = state1,
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)

RegisterServerEvent('ubi-garage:setVehiclin')
AddEventHandler('ubi-garage:setVehiclin', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored', {
		['@stored'] = 'in',
		['@location'] = location
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET `stored` = @stored', {
				['@stored'] = 'in',
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)

-- admincar
RegisterServerEvent('admin:svcar')
AddEventHandler('admin:svcar', function(vehicleProps, fuel, plate, modelveh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type, job, fuel) VALUES (@owner, @plate, @vehicle, @stored, @type, @job, @fuel)', {
		['@owner']   = xPlayer.identifier,
		['@plate']   = plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored'] = "out",
		['@type'] = "car",
		['@job'] = "civ",
		['@fuel'] = fuel
	}, function (rowsChanged)
	end)
end)


ESX.RegisterServerCallback('ubi-garage:getvehown', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehiclePropsjson = json.encode(vehicleProps)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate ', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		local owened = false
		if result[1] ~= nil then
			-- print(('ubi-garage: %s is the owner of %s'):format(xPlayer.identifier, vehicleProps.plate))
			owened = true
		else
			-- print(('ubi-garage: %s is not the owner of %s'):format(xPlayer.identifier, vehicleProps.plate))
			owened = false
		end
		cb(owened)
	end)
end)



RegisterServerEvent('ubi-garage:setVehicleout')
AddEventHandler('ubi-garage:setVehicleout', function(plate, state, state1)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, state = @state WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate,
		["@state"] = state1,
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET `stored` = @stored state = @state WHERE plate = @plate', {
				['@stored'] = state,
				['@plate'] = plate,
				['@state'] = state1,
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)



RegisterServerEvent('ubi-garage:setvehicelhpim')
AddEventHandler('ubi-garage:setvehicelhpim', function(state1)
	local xPlayer = ESX.GetPlayerFromId(source)
	-- print("ubi-garage: set all vehicle to impound lot!")
	MySQL.Async.execute('UPDATE owned_vehicles SET state = @state WHERE stored = @stored', {
		["@state"] = state1,
		["@stored"] = "out", 
	})
end)

if Config.Main.Commands then
	ESX.RegisterCommand('setimpound', 'admin', function(args, showError)
		TriggerEvent('ubi-garage:setvehicelhpim', "2")
		print("ubi-garage: setvehicle to impound")
	end, true, {help = 'Set All Vehicle To Impound', validate = false})
end


RegisterServerEvent('ubi-garage:getstate', function(stored)
	-- print("ubi-garage: cdbug!")
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `stored` = @stored', {
			['@stored']  = stored,
		})

end)

RegisterServerEvent('ubi-garage:setVehiclename')
AddEventHandler('ubi-garage:setVehiclename', function(plate, vehiclename)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET vehiclename = @vehiclename WHERE plate = @plate', {
		['@vehiclename'] = vehiclename,
		['@plate'] = plate,
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET vehiclename = @vehiclename WHERE plate = @plate ', {
				['@vehiclename'] = vehiclename,
				['@plate'] = plate,
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)

-- set vehicle model
RegisterServerEvent('ubi-garage:setvehmodel')
AddEventHandler('ubi-garage:setvehmodel', function(modelveh, plate)
local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET modelveh = @modelveh WHERE plate = @plate', {
		['@modelveh'] = modelveh,
		['@plate'] = plate,
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET modelveh = @modelveh WHERE plate = @plate ', {
				['@modelveh'] = modelveh,
				['@plate'] = plate,
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)


-- Set Fuel Level
RegisterServerEvent('ubi-garage:setVehicleFuel')
AddEventHandler('ubi-garage:setVehicleFuel', function(plate, fuel)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET fuel = @fuel WHERE plate = @plate', {
		['@fuel'] = fuel,
		['@plate'] = plate,
	}, function(rowsChanged)
		if rowsChanged == 0 then
			MySQL.Async.execute('UPDATE shared_vehicles SET fuel = @fuel WHERE plate = @plate ', {
				['@fuel'] = fuel,
				['@plate'] = plate,
			}, function(rowsChanged)
				if rowsChanged == 0 then
					print(('ubi-garage: %s exploited the garage!'):format(xPlayer.identifier))
				end
			end)
		end
	end)
end)



 ESX.RegisterServerCallback("garage:checkAdmin", function(source, cb)
     local xPlayer = ESX.GetPlayerFromId(source)
              
     if xPlayer.getGroup() == 'admin' or 'superadmin' then
         cb(true)
    else
         cb(false)
		 print(('ubi-garage: %s the player tray to break admin event!'):format(xPlayer.identifier))
     end
 end)


ESX.RegisterServerCallback('ubi-garage:getidentifier', function(source, admin)
	local xPlayer = ESX.GetPlayerFromId(source)
	local admin = GetPlayerIdentifiers(xPlayer.source)
	local grade = xPlayer.getGroup()
	if grade == "admin" then
		return
		print(('ubi-garage: the identifer'.. admin .. 'not support admin command'))
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', soruce, { type = 'inform', text = 'Only Admins can use this command!' })  	
	end
end)