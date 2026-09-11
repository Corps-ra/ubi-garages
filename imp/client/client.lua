local garages = {}
local impounds = {}

local currentGarage = nil
local currentImpound = nil
local jobBlips = {}

local ped = nil

local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
local displayed = false
local vehToSpawn = {}
local pgarage = false
local supers = false
local totalCars 




function VehicleSpawnimpound(data, spawn, price, vehicle)
    TriggerServerEvent('ubi-garages:SpawnVehicle', data.vehicle.model, data.vehicle.plate, vector3(spawn.x, spawn.y, spawn.z-1), type(spawn) == 'vector4' and spawn.w or spawn.h, price)
end
    

function IsInsideZone(type, entity)
    local entityCoords = GetEntityCoords(entity)
    if type == 'impound' then
        for k, v in pairs(impounds) do
            if impounds[k]:isPointInside(entityCoords) then
                currentImpound = Config.Impounds[k]
                return true 
            end
            if k == #impounds then return false end
        end
    else
        for k, v in pairs(garages) do
            if garages[k]:isPointInside(entityCoords) then
                currentGarage = Config.Garages[k]
                return true
            end
            if k == #garages then return false end
        end
    end
end

exports("IsInsideZone", function(pType)
    local entityCoords = GetEntityCoords(entity)
    if type == 'impound' then
        for k, v in pairs(impounds) do
            if impounds[k]:isPointInside(entityCoords) then
                currentImpound = Config.Impounds[k]
                return true 
            end
            if k == #impounds then return false end
        end
    elseif type == 'garages' then
        for k, v in pairs(garages) do
            if garages[k]:isPointInside(entityCoords) then
                currentGarage = Config.Garages[k]
                return true
            end
            if k == #garages then return false end
        end
    end
end)


local impoundPeds = {Config.DefaultImpoundPed}
for k, v in pairs(Config.Impounds) do


    impounds[k] = BoxZone:Create(
        vector3(v.zone.x, v.zone.y, v.zone.z),
        v.zone.l, v.zone.w, {
            name = v.zone.name,
            heading = v.zone.h,
            debugPoly = false,
            minZ = v.zone.minZ,
            maxZ = v.zone.maxZ
        }
    )

    impounds[k].type = v.type

    table.insert(impoundPeds, v.ped)

end

exports['ubi-target']:AddBoxZone('impound', vector3(-192.5, -1161.92, 23.67), 0.5, 0.3, {
    name="1",
    heading=354,
    --debugPoly=true,
    minZ=23.32,
    maxZ=23.62
},{
    options = {
        {
            event = 'ubi-garages:GetImpoundedVehicles',
            icon = "fas fa-key",
            label = "Impound",
            canInteract = function(entity)
                hasChecked = false
                if IsInsideZone('impound', entity) and not hasChecked then
                    hasChecked = true
                    return true
                end
            end
        },
    },
    distance = 2.5,
})


RegisterNetEvent('ubi-garages:GetImpoundedVehicles')
AddEventHandler('ubi-garages:GetImpoundedVehicles', function()
    ESX.TriggerServerCallback('ubi-garages:GetImpound', function(vehicles)
        local menu = {}

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = ' ' .. "Impound",
                txt = ''
            },
        })

        if vehicles ~= nil then
            for k, v in pairs(vehicles) do
                local vehModel = v.vehicle.model
                local vehName = GetLabelText(GetDisplayNameFromVehicleModel(vehModel))
                local vehTitle =  ' ' .. vehName
                
                local impoundPrice = Config.ImpoundPrices['' .. GetVehicleClassFromName(vehModel)]

                table.insert(menu, {
                    id = k,
                    header = vehTitle,
                    txt = "plate" .. ': ' .. v.plate,
                    params = {
                        event = 'ubi-garages:ImpoundVehicleMenu',
                        args = {name = vehTitle, plate = v.plate, model = vehModel, vehicle = v.vehicle, health = v.health, price = impoundPrice}
                    }
                })
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = "No Vehicle In Impound",
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = "no Vehicle In Impound",
                    txt = ''
                }
            })
        end
    end, currentImpound.type)
end)

RegisterNetEvent('ubi-garages:ImpoundVehicleMenu')
AddEventHandler('ubi-garages:ImpoundVehicleMenu', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 0,
            header = "< Go back",
            txt = '',
            params = {
                event = 'ubi-garages:GetImpoundedVehicles',
            }
        },
        {
            id = 1,
            header = "Take Out Vehicle From Impound",
            txt = "car" .. ': ' .. data.name .. ' <br> ' .. "plate" .. ': ' .. data.plate .. ' <br> ' .. "price" .. ': ' .. "$" .. data.price,
            params = {
                event = 'ubi-garages:RequestVehicleimpound',
                args = {
                    vehicle = data.vehicle,
                    health = data.health,
                    price = data.price,
                    type = 'impound'
                }
            }
        }
    })
end)


RegisterNetEvent('ubi-garages:RequestVehicleimpound')
AddEventHandler('ubi-garages:RequestVehicleimpound', function(data)
    local spawn = nil

    if data.type == 'garage' then
        spawn = currentGarage.spawns
    else
        spawn = currentImpound.spawns
    end

    for i = 1, #spawn do
        if ESX.Game.IsSpawnPointClear(vector3(spawn[i].x, spawn[i].y, spawn[i].z), 1.0) then
            exports['mythic_notify']:SendAlert('error', " Kamu membayar sebesar $" ..data.price)
            return VehicleSpawnimpound(data, spawn[i], data.type == 'impound' and data.price or nil)
        end
        if i == #spawn then exports['mythic_notify']:SendAlert('error',"Lokasi asuransi penuh") end
    end
end)

