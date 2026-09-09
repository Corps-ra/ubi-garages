local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
ESX = nil
local displayed = false
local vehToSpawn = {}
local pgarage = false
local supers = false
local totalCars 
local locToSpawn 
local headingToSpawn 
local currentLoc
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10) 
	end
	ESX.PlayerData = ESX.GetPlayerData()
	-- CreateBlips()
	-- RefreshJobBlips()
end)

--- code location
local locations = {
	policeGarageSec= 'PoliceGarageVPD',
	casinoGarage= 'B', 
	policeGarage= 'policeGarageMRPD', 
	policeGarageSheriff= 'policeGarageSheriff',
	apartmentGarage= 'A', 
	elginGarage= 'C', 
	paletoGarage= 'H', 
	sandyGarage= 'G', 
	kotGarage = "D", 
	bankGarage = "E",
	impoundParking = 'F', 
	towGarage = 'towGarage', 
	ambulanceGarage = 'ambulanceGarage'
}
 
RegisterCommand('getheding', function()
	local playerPed = PlayerPedId()
local heading = GetEntityHeading(playerPed)
print("Current heading: " .. heading)
end, false)


-- heading spawn vehicle
	local headingTable = {
	kotGarage1 = 248.36, 
	kotGarage2 = 247.41,
	kotGarage3 = 247.85,	
	kotGarage5 = 246.75,
	kotGarage4 = 249.58,
	bankGarage1 = 86.19,
	bankGarage2 = 83.7,
	bankGarage3 = 90.85,
	bankGarage4 = 90.11,
	bankGarage5 = 87.21,
	casinoGarage1 = 328.06, 
	casinoGarage2 = 328.06,
	casinoGarage3 = 327.57,
	casinoGarage4 = 323.05, 
	casinoGarage5 = 331.38,
	casinoGarage6 = 327.29,
	impoundParking1 = 89.78, 
	impoundParking2 = 92.53,
	apartmentGarage1 = 158.0, 
	apartmentGarage2 = 158.0,
	apartmentGarage3 = 158.0,
	apartmentGarage4 = 158.0,
	apartmentGarage5 = 160.51, 
	apartmentGarage6 = 155.64, 
	policeGarage1= 78.96, 
	policeGarage2 = 87.49,
	policeGarage3 = 90.0, 
	policeGarage4 = 93.43, 
	policeGarageSheriff1 = 209.31808,
	policeGarageSheriff2 = 212.47630,
	ambulanceGarage1 = 145.35, 
	ambulanceGarage2 = 135.23,
	elginGarage1 = 160.0, 
	elginGarage2 = 160.0, 
	elginGarage3 = 160.0,
	elginGarage4 = 160.0, 
	paletoGarage1 = 0.0, 
	paletoGarage3 = 180.0, 
	paletoGarage4 = 180.0, 
	sandyGarage1 = 210.0, 
	sandyGarage2 = 210.0, 
	sandyGarage3 = 210.0, 
	sandyGarage4= 210.0, 
	towGarage = 83.01
}

-- location spawn
local locSpawnTable = {
	kotGarage1 = vector3(276.61,-339.82,44.92), 
	kotGarage2 = vector3(277.54,-336.38,44.92), 
	kotGarage3 = vector3(278.83,-333.32,44.92),
	kotGarage4 = vector3(279.98,-329.83,44.92),
	kotGarage5= vector3(281.54,-326.66,44.92),
	bankGarage1 = vector3(-348.74,272.45,85.14),
	bankGarage2 = vector3(-349.33,276.00,85.02),
	bankGarage3 = vector3(-348.80,279.27,84.98),
	bankGarage4 = vector3(-348.92,282.58,84.96),
	bankGarage5= vector3(-348.75,286.04,84.97),
	casinoGarage1 = vector3(895.50,-5.44,78.76),
	casinoGarage2 = vector3(898.34,-7.78,78.76),
	casinoGarage3 = vector3(901.59,-9.88,78.76),
	casinoGarage4 = vector3(905.07,-11.71,78.76),
	casinoGarage5 = vector3(908.48,-13.95,78.76), 
	casinoGarage6 = vector3(911.76,-16.13,78.76),
	impoundParking1 = vector3(-152.44,-1169.88, 23.77),
	impoundParking2 = vector3(-152.26165771484,-1166.8446044922,23.769592285156), 
	policeGarage1 = vector3(444.96472167969,-997.06298828125,25.699802398682), 
	policeGarage2 = vector3(445.9648,-988.9055,25.6908), 
	policeGarage3 = vector3(446.2286,-994.2879,25.6908), 
	policeGarage4 = vector3(446.47845458984,-991.55181884766,25.69980430603), 
	policeGarageSheriff1 = vector3(1878.9471435,3690.60034,33.53419044),
	policeGarageSheriff2 = vector3(1881.83666,3692.29638,33.54188),
	apartmentGarage1 = vector3(-297.5900, -989.6500, 31.0800),
	apartmentGarage2 = vector3(-301.2132,-988.7868,31.06592),
	apartmentGarage3 = vector3(-304.7736,-987.5472,31.06592), 
	apartmentGarage4 = vector3(-308.3736,-986.4132,31.06592), 
	apartmentGarage5 = vector3(-311.51,-984.67,31.08), 
	apartmentGarage6 = vector3(-314.63549804688,-983.41412353516,31.080953598022), 
	elginGarage1 = vector3(247.7143,-758.3735,30.4), 
	elginGarage2 = vector3(251.3539, -759.1121, 30.4), 
	elginGarage3 = vector3(254.2945,-760.9319,30.4), 
	elginGarage4 = vector3(257.4857, -762, 30.4), 
	paletoGarage1 = vector3(145.73, 6602.37, 31.8), 
	paletoGarage2 = vector3(151.04, 6597.12, 31.84), 
	paletoGarage3 = vector3(151.12, 6609.01, 31.87),
	paletoGarage4 = vector3(145.48, 6612.71, 31.82), 
	sandyGarage1 = vector3(1949.47, 3759.19, 32.21), 
	sandyGarage2 = vector3(1953.08, 3760.69,32.2), 
	sandyGarage3 = vector3(1956.13, 3762.66, 32.2),
	sandyGarage4 = vector3(1959.19, 3764.9, 32.2), 
	towGarage = vector3(-209.75,-1169.98, 23.04), 
	ambulanceGarage1 = vector3(-848.90,-1227.90,6.78), 
	ambulanceGarage2 = vector3(-852.32,-1225.23,6.63)
}

--- location garage name 
local locBooleans = {
	kotGarage1 = false,
	kotGarage2 = false, 
	kotGarage3 = false, 
	kotGarage4 = false,
	kotGarage5 = false,
	bankGarage1 = false,
	bankGarage2 = false,
	bankGarage3 = false,
	bankGarage4 = false, 
	bankGarage5 = false,
	casinoGarage1 = false, 
	casinoGarage2 = false, 
	casinoGarage3 = false, 
	casinoGarage4 = false,
	casinoGarage5 = false,
	casinoGarage6 = false, 
	impoundParking1= false, 
	impoundParking2 = false,
	policeGarage1 = false, 
	policeGarage2 = false, 
	policeGarage3 = false, 
	policeGarage4 = false, 
	policeGarageSheriff1 = false,
	policeGarageSheriff2 = false,
	apartmentGarage1 = false, 
	apartmentGarage2 = false, 
	apartmentGarage3 = false, 
	apartmentGarage4 = false, 
	apartmentGarage5 = false,
	apartmentGarage6 = false, 
	elginGarage1 = false, 
	elginGarage2 = false, 
	elginGarage3 = false,
	elginGarage4 = false, 
	paletoGarage1 = false, 
	paletoGarage2 = false, 
	paletoGarage3 = false, 
	paletoGarage4 = false, 
	sandyGarage1 = false,
	sandyGarage2 = false, 
	sandyGarage3 = false, 
	sandyGarage4 = false, 
	towGarage = false,
	ambulanceGarage1 = false, 
	ambulanceGarage2 = false
} 

--  end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
	-- DeleteJobBlips()
	-- RefreshJobBlips()
end)

RegisterNetEvent('bt-polyzone:enter')
AddEventHandler('bt-polyzone:enter', function(name)
	if locBooleans[name] ~= nil then
        locBooleans[name] = true
		locToSpawn = locSpawnTable[name]
		headingToSpawn = headingTable[name]
		local location = string.gsub(name, "%d", "")
		currentLoc = locations[location]
		exports['aw3-ui']:showInteraction("Parking")
		-- print(locToSpawn, headingToSpawn)
    end
end)

RegisterNetEvent('bt-polyzone:exit')
AddEventHandler('bt-polyzone:exit', function(name)
	if locBooleans[name] ~= nil then
		locBooleans[name]=false
		locToSpawn = nil
		headingToSpawn = nil
		exports['aw3-ui']:hideInteraction()
    end
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end


-- End of Ambulance Code
RegisterNetEvent('ubi-garage:OpenJobGarageRadial')
AddEventHandler('ubi-garage:OpenJobGarageRadial', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			OpenPoliceGarageMenu()
			displayed = false
		end
	end
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'towing' then
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			OpenTowingGarageMenu()
			displayed = false
		end
	end
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			OpenAmbulanceGarageMenu()
			displayed = false
		end
	end
end)


function DoVehicleDamage(vehicle, health)
    if health ~= nil then
        Citizen.Wait(1500)
        health.engine = ESX.Math.Round(health.engine, 2)
        health.body = ESX.Math.Round(health.body, 2)

        -- Making the vehicle still drivable if it's completely totaled
        if health.engine < 200.0 then
            health.engine = 200.0
        end
    
        if health.body < 150.0 then
            health.body = 150.0
        end
    
        for _, window in pairs(health.parts.windows) do
            SmashVehicleWindow(vehicle, window)
        end

        for _, tyre in pairs(health.parts.tires) do
            SetVehicleTyreBurst(vehicle, tyre, true, 1000.0)
        end

        for _, door in pairs(health.parts.doors) do
            SetVehicleDoorBroken(vehicle, door, false)
        end

        SetVehicleBodyHealth(vehicle, health.body)
        SetVehicleEngineHealth(vehicle, health.engine)
    else
        return
    end
end

function SpawnVehicle(vehicle, plate,fuel, vector, heading, netId, svData)
	local ped = PlayerPedId()
	local veh = NetToVeh(netId)
	if vector ~= nil then
	ESX.Game.SpawnVehicle(vehicle.model, vector, heading, function(callback_vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleBodyHealth(callback_vehicle, vehicle.bodyHealth)
		-- print(vehicle.bodyHealth)
		-- DoVehicleDamage(vehicle, json.decode(svData.health))
		doCarDamages(vehicle.engineHealth, vehicle.bodyHealth, callback_vehicle, vehicle.tyre, vehicle.doors, vehicle.windows)
		exports['LegacyFuel']:SetFuel(callback_vehicle, fuel)
		
		Citizen.Wait(100)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		SetVehicleDirtLevel(callback_vehicle, vehicle.dirt)
		
		
	end)

	TriggerServerEvent('ubi-garage:setVehicleout', plate, "out", "3")
	-- print("test")

else
	exports['mythic_notify']:SendAlert('inform', 'No spawn spot.')
	end
end

function checkPDGarage()
	if locBooleans.policeGarage1 or locBooleans.policeGarage2 or locBooleans.policeGarage3 or locBooleans.policeGarage4 or locBooleans.policeGarageSheriff1 or locBooleans.policeGarageSheriff2 then
		return true
	end
	return false	
end	

-- fungsi utama

RegisterNetEvent('policegarage:menu')
AddEventHandler("policegarage:menu", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		TriggerEvent('nh-context:createMenu', {
			{
				id= 1,
				header = "Open garage",
				context = "Open police garage",
				event = "ubi-garage:OpenJobGarageRadial"
			},
			{
				id= 2,
				header = "Buy Vehicle",
				context = "Open police vehicle shop",
				event = "ubi-policejob:client:openVehicleShop"
			},
		})
	end
end)

RegisterNetEvent('EMSgarage:menu')
AddEventHandler("EMSgarage:menu", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		TriggerEvent('nh-context:createMenu', {
			{
				id= 1,
				header = "Open garage",
				context = "Open EMS garage",
				event = "ubi-garage:OpenJobGarageRadial"
			},
			{
				id= 2,
				header = "Buy Vehicle",
				context = "Open police vehicle shop",
				event = "esx_ambulancejob:buyemscar"
			},
		})
	end
end)
-- civ garage
RegisterNetEvent("ubi-garage:Opengarageall")
AddEventHandler("ubi-garage:Opengarageall", function()
	if not IsPedSittingInAnyVehicle(PlayerPedId()) then
		OpenGarageAll()
end)

function OpenGarageAll()
	local cars = {}
	local i = 1
	local wait = true
	
		ESX.TriggerServerCallback('ubi-garage:garageall', function(ownedCars)
			local menu = {}

        if ownedCars ~= nil then
            for k, v in pairs(ownedCars) do
				local vehModel = v.vehicle.model
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle =  ' ' .. vehName
                local fuel = v.fuel
                if Config.SplitGarages then
                    if (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
                                args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }  
                        })
                    elseif (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = '',
                            txt = Locale('plate') .. ': ' .. v.plate .. ' <br>' .. Locale('garage') .. ': ' .. GetGarageLabel(v.garage),
                        })
                    end
                else
                    if v.stored == 'in' or v.stored == true then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..' | State : '..v.stored..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }
                        })
                    elseif v.stored == 'out' or v.stored == true then
						table.insert(menu, {
							id = k,
							header = vehTitle,
							txt = 'Plate : ' .. v.plate ..' | State : '..v.stored..'',
							params = {
								event = 'ininponund:Garage',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
							}
						})
					end
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
				exports['mythic_notify']:SendAlert('inform', "No Vehicle in this garage.")
            end
        end		
		end, currentLoc)
		
		while wait do
			Citizen.Wait(5)
		end
end			
-- ambulance garage
function OpenAmbulanceGarageMenu()
	local cars = {}
	local i = 1
	local wait = true

	ESX.TriggerServerCallback('ubi-garage:ownedAmbulanceCars', function(ownedAmbulanceCars)
		local menu = {}

				TriggerEvent('nh-context:sendMenu', {
				{
					id = 0,
					header = '< Go Back',
					txt = '',
					params = {
						event = 'EMSgarage:menu'
					}
				},
			})

        if ownedAmbulanceCars ~= nil then
            for k, v in pairs(ownedAmbulanceCars) do
				local vehModel = v.vehicle.model
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle =  ' ' .. vehName
                local fuel = v.fuel
                if Config.SplitGarages then
                    if (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
                                args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }  
                        })
                    elseif (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = '',
                            txt = Locale('plate') .. ': ' .. v.plate .. ' <br>' .. Locale('garage') .. ': ' .. GetGarageLabel(v.garage),
                        })
                    end
                else
                    if v.stored == 'in' or v.stored == true then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }
                        })
                    elseif v.stored == 'out' or v.stored == true then
						table.insert(menu, {
							id = k,
							header = vehTitle,
							txt = 'Plate : ' .. v.plate ..' | State : '..v.stored..'',
							params = {
								event = 'ininponund:Garage',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
							}
						})
					end
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
				TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'no vehicle in garages',
                        txt = ''
                    }
                })
            end
        end		
		end, 'ambulance', 'cars')
		
		while wait do
			Citizen.Wait(5)
		end
	end


-- policegarage
function OpenPoliceGarageMenu()
	local cars = {}
	local i = 1
	local wait = true
	if checkPDGarage() then
		ESX.TriggerServerCallback('ubi-garage:policegarage', function(ownedPoliceCars)
			local menu = {}

			TriggerEvent('nh-context:sendMenu', {
				{
					id = 0,
					header = '< Go Back',
					txt = '',
					params = {
						event = 'policegarage:menu'
					}
				},
			})

        if ownedPoliceCars ~= nil then
            for k, v in pairs(ownedPoliceCars) do
				local vehModel = v.vehicle.model
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle =  ' ' .. vehName
                local fuel = v.fuel
                if Config.SplitGarages then
                    if (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
                                args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }  
                        })
                    elseif (v.stored == 'in' or v.stored == true) then
                        table.insert(menu, {
                            id = k,
                            header = '',
                            txt = Locale('plate') .. ': ' .. v.plate .. ' <br>' .. Locale('garage') .. ': ' .. GetGarageLabel(v.garage),
                        })
                    end
                else
                    if v.stored == 'in' or v.stored == true then
                        table.insert(menu, {
                            id = k,
                            header = vehTitle,
                            txt = 'Fuel : ' .. v.fuel ..  '% | Plate : ' .. v.plate .. ' | Garage : '.. v.location ..' | State : '..v.stored..'',
                            params = {
                                event = 'ubi-garages:VehicleMenu',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
                            }
                        })
                    elseif v.stored == 'out' or v.stored == true then
						table.insert(menu, {
							id = k,
							header = vehTitle,
							txt = 'Plate : ' .. v.plate ..' | State : '..v.stored..'',
							params = {
								event = 'ininponund:Garage',
								args = {name = vehTitle, fuel = v.fuel, plate = v.plate, model = vehModel, vehicle = v.vehicle, location = v.location}
							}
						})
					end
                end
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
				TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'no vehicle in garages',
                        txt = ''
                    }
                })
            end
        end		
		end, 'police', 'cars')
		
		while wait do
			Citizen.Wait(5)
		end
		
	end
	
end			


-- stored vehicle
RegisterNetEvent('ubi-garage:StoreOwnedVehicle')
AddEventHandler('ubi-garage:StoreOwnedVehicle', function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
	StoreOwnedVehicle()
end)

function StoreOwnedVehicle()
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local plate = vehicleProps.plate
		local tyre = {IsVehicleTyreBurst(vehicle, 0, false),IsVehicleTyreBurst(vehicle, 1, false),IsVehicleTyreBurst(vehicle, 4, false),IsVehicleTyreBurst(vehicle, 5, false)}
		local doors = {IsVehicleDoorDamaged(vehicle, 0),IsVehicleDoorDamaged(vehicle, 1),IsVehicleDoorDamaged(vehicle, 2),IsVehicleDoorDamaged(vehicle, 3),IsVehicleDoorDamaged(vehicle, 4),IsVehicleDoorDamaged(vehicle, 5)}
		local windows = {IsVehicleWindowIntact(vehicle, 0), IsVehicleWindowIntact(vehicle, 1), IsVehicleWindowIntact(vehicle, 2), IsVehicleWindowIntact(vehicle, 3), IsVehicleWindowIntact(vehicle, 4), IsVehicleWindowIntact(vehicle, 5)}
		vehicleProps['tyre'] = tyre
		vehicleProps['doors'] = doors
		vehicleProps['windows'] = windows
		vehicleProps['dirt'] = GetVehicleDirtLevel(vehicle)
		if vehicleProps.bodyHealth == 1000.0 then
			vehicleProps.bodyHealth = 999.9
		end
		ESX.TriggerServerCallback('ubi-garage:storeVehicle', function(valid)
			if valid then
					StoreVehicle(vehicle, vehicleProps, currentLoc)	
			else
				exports['mythic_notify']:SendAlert('error', "can't store vehicle.")
			end
		end, vehicleProps)
	else
		exports['mythic_notify']:SendAlert('error', 'No vehicle.')
	end
end

-- end fungsi utama

RegisterNetEvent("ininponund:Garage", function()
	exports['mythic_notify']:SendAlert('error', 'Vehicle is out of garage!')
end)


RegisterNetEvent("ubi-garages:VehicleMenu", function(data, menu)
local ped = PlayerPedId()
if ESX.Game.IsSpawnPointClear(vector3(GetEntityCoords(ped)-1), 2.0) then	   
	SpawnVehicle(data.vehicle, data.plate, data.fuel, locToSpawn, headingToSpawn)
else
	exports['mythic_notify']:SendAlert('error', "No Parking Spot.")
   end
end)


exports("NearVehicle", function(pType)
    if pType == "Distance" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return true
        else
            return false
        end
    elseif pType == "plate" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    elseif pType == "Fuel" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return exports['LegacyFuel']:GetFuel(vehicle) 
        else
            return false
        end
    elseif pType == "sittingplate" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    end
end)

-- End of Car Code
RegisterNetEvent('admin:car')
AddEventHandler('admin:car', function(vehicleProps, plate, fuel, modelveh)
	ESX.TriggerServerCallback('garage:checkAdmin', function(admin)
		if admin == true then
		local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed, false) then
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local plate = vehicleProps.plate
		local modelveh = GetEntityModel(vehicle)
		local fuel = exports['LegacyFuel']:GetFuel(vehicle) 
		local tyre = {IsVehicleTyreBurst(vehicle, 0, false),IsVehicleTyreBurst(vehicle, 1, false),IsVehicleTyreBurst(vehicle, 4, false),IsVehicleTyreBurst(vehicle, 5, false)}
		local doors = {IsVehicleDoorDamaged(vehicle, 0),IsVehicleDoorDamaged(vehicle, 1),IsVehicleDoorDamaged(vehicle, 2),IsVehicleDoorDamaged(vehicle, 3),IsVehicleDoorDamaged(vehicle, 4),IsVehicleDoorDamaged(vehicle, 5)}
		local windows = {IsVehicleWindowIntact(vehicle, 0), IsVehicleWindowIntact(vehicle, 1), IsVehicleWindowIntact(vehicle, 2), IsVehicleWindowIntact(vehicle, 3), IsVehicleWindowIntact(vehicle, 4), IsVehicleWindowIntact(vehicle, 5)}
		vehicleProps['tyre'] = tyre
		vehicleProps['doors'] = doors
		vehicleProps['windows'] = windows
		vehicleProps['dirt'] = GetVehicleDirtLevel(vehicle)
	ESX.TriggerServerCallback('ubi-garage:getvehown', function(owened)
		if owened == true then
			exports['mythic_notify']:SendAlert('error', 'The vehicle is already owned!')
			return
		else
			if vehicleProps.bodyHealth == 1000.0 then
				vehicleProps.bodyHealth = 999.9
			end
	
			TriggerServerEvent("admin:svcar", vehicleProps, fuel, plate, modelveh)
			exports['mythic_notify']:SendAlert('inform', 'Saved Vehicle.')
			end
		end, vehicleProps)
	else
		exports['mythic_notify']:SendAlert('error', 'No vehicle.')
		return
	end
		else 
			exports['mythic_notify']:SendAlert('error', 'Admin Only!')
		end
	end)
end) 
	
-- Store Vehicles
function StoreVehicle(vehicle, vehicleProps, location, data)
	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
			table.remove(vehInstance, k)
		end
	end
	local ped = GetPlayerPed(-1)
	local veh = GetVehiclePedIsIn(ped, false)
	local model = GetEntityModel(veh)
	local displaytext = GetDisplayNameFromVehicleModel(model)
	local name = GetLabelText(displaytext)
	local modelveh = GetEntityModel(veh)
	TriggerServerEvent('ubi-garage:setVehiclename', vehicleProps.plate, name)
	
	currentFuel = exports['LegacyFuel']:GetFuel(vehicle)
	TriggerServerEvent('ubi-garage:setVehicleFuel', vehicleProps.plate, currentFuel)

	TriggerServerEvent('ubi-garage:setvehmodel', modelveh, vehicleProps.plate)
	TriggerEvent("hud:seatbelt")
	Wait(500)
	TaskLeaveVehicle(PlayerPedId(), vehicle)
	Citizen.Wait(2000)
	NetworkFadeOutEntity(vehicle, true, true)
	Citizen.Wait(100)
	SetEntityCollision(vehicle, false, false)
	SetEntityAlpha(vehicle, 0.0, true)
	SetEntityAsMissionEntity(vehicle, false, true)
	DeleteEntity(vehicle)
	TriggerServerEvent('ubi-garage:setVehicleState', vehicleProps.plate, "in", currentLoc, "1")
	exports['mythic_notify']:SendAlert('inform', 'Vehicle stored in garage : ' ..currentLoc)
end

function doCarDamages(eh, bh, veh, tyres, doors, windows)
	Citizen.Wait(100)
    local tobreakW = 0
    local tobreakD = 0
    if eh and bh and tyres then
        local engine = eh + 0.0
        local body = bh + 0.0
        local dif = (1000.0 - body) + 1.0
        local toDmg = math.floor(dif/100)
        local currentVehicle = (veh and IsEntityAVehicle(veh)) and veh or GetVehiclePedIsIn(PlayerPedId(), false)
        if windows then 
			for i, w in pairs(windows) do
				if w ~= 1 then
					RemoveVehicleWindow(currentVehicle, i-1)		
				end
			end
		end	
        SetVehicleEngineHealth(currentVehicle, engine)
		if tyres then
			local toPop = {0,1,4,5}
            for i, t in pairs(tyres) do
				if t == 1 then
					SetVehicleTyreBurst(currentVehicle, toPop[i], true, 1000.0)	
				end
			end
        end
        if tyres then
			local toPop = {0,1,4,5}
            for i, t in pairs(tyres) do
				if t == 1 then
					SetVehicleTyreBurst(currentVehicle, toPop[i], true, 1000.0)	
				end
			end
        end
		if doors then 
			for i, d in pairs(doors) do
				if d == 1 then 
					SetVehicleDoorBroken(currentVehicle, i-1, true)
				end
			end
		end
    end
end


-- Check Vehicles
function DoesAPlayerDrivesVehicle(plate)
	local isVehicleTaken = false
	local players = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
		exports['aw3-ui']:hideInteraction()
		TriggerEvent('nh-context:closeMenu')
	end
end)

function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

--- name of vehicle
Citizen.CreateThread(function()
	AddTextEntry("evo9", "mitsubishi evo9")
	AddTextEntry("g65amg", "amg g65")
	AddTextEntry("HDIron883", "HDIron883")
	AddTextEntry("laferrari17", "ferrari f17")
	AddTextEntry("lfa", "lamborghini lp670")
	AddTextEntry("m1000rr", "bmw m1000rr")
	AddTextEntry("m3e46", "bmw m3e46")
	AddTextEntry("m4", "bmw m4 m3e46")
	AddTextEntry("m5e60", "bmw m5e60")
	AddTextEntry("mansamgt21", "Mercedes Amgt21")
	AddTextEntry("panamera17turbo", "prosche panamera")
	AddTextEntry("pistas", "maclaren pistas")
	AddTextEntry("por930", "prosche 930")
	AddTextEntry("r1", "Yamaha r1")
	AddTextEntry("r1250", "bwm r1250")
	AddTextEntry("ksd", "KTM SuperDuke")
	AddTextEntry("r35", "nissan r35")
	AddTextEntry("rcf", "lexus rcf")
	AddTextEntry("rmodmustang", "mustang gt")
	AddTextEntry("s15rb", "Nissan S15RB")
	AddTextEntry("s63c217", "mercedes c63")
	AddTextEntry("senna", "maclaren senna")
	AddTextEntry("srt8b", "jeep srt8")
	AddTextEntry("xz10", "Kawasaki ZX10R")
	AddTextEntry("emsnspeedo", "NP ambulance")
	AddTextEntry("fordambo", "ambulance BOX")
	AddTextEntry("emsaw139", "EMS helicopter")
	AddTextEntry("npolvette", "Police Corvet")
	AddTextEntry("deluxo6str", "deluxo6str")
	AddTextEntry("contss18", "contss18")
	AddTextEntry("npolvic", "police victory")
	AddTextEntry("npolstang", "police mustang")
	AddTextEntry("npolmm", "police BMW1200gs")
	AddTextEntry("npolcoach", "police bus")
	AddTextEntry("20x5m", "BMW X5M")
	AddTextEntry("a80","Toyota Supra")
	AddTextEntry("a90e", "Toyota Supra a90e")
	AddTextEntry("e36prb", "bmw e36")
	AddTextEntry("allnewnmax", "nmax 155")
	AddTextEntry("zx6r", "zx6r")
end)

