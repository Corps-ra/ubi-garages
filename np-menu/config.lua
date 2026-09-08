local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local PlayerData = {}
local prop
local propertyNames = {'GenericApartment', 'LowEndApartment', 'IntegrityWay'}
local sandygaragename = {'sandyGarage1', 'sandyGarage2', 'sandyGarage3', 'sandyGarage4',}
local elginGarageNmae =  {'elginGarage1', 'elginGarage2', 'elginGarage3', 'elginGarage4'}
local paletogaragename = {'paletoGarage1', 'paletoGarage2','paletoGarage3', 'paletoGarage4'}
local impoundgetname = {'impoundget'}
local bankGaragename = {'bankGarage1', 'bankGarage2', 'bankGarage3', 'bankGarage4', 'bankGarage5'}
local kotGaragename = {'kotGarage1', 'kotGarage2', 'kotGarage3', 'kotGarage4', 'kotGarage5'}
local policegaragename = {'policeGarage1', 'policeGarage2', 'policeGarage3', 'policeGarage4'}
local policegarageSheriffName = {'policeGarageSheriff1', 'policeGarageSheriff2'}
local impoundname = {'impoundParking1', 'impoundParking2'}
local ambulancegaragenmae = {'ambulanceGarage1', 'ambulanceGarage2'}
local casinogaragename = {'casinoGarage1', 'casinoGarage2', 'casinoGarage3', 'casinoGarage4', 'casinoGarage5', 'casinoGarage6'}
local civGarageNames = {'apartmentGarage1', 'apartmentGarage2', 'apartmentGarage3', 'apartmentGarage4', 'apartmentGarage5', 'apartmentGarage6'}
local repairpolice = {'policerepair'}
local polyzoneBooleans = {policeGarageSheriff1 = false, policeGarageSheriff2 = false, policerepair = false, kotGarage5 = false,kotGarage4 =false,bankGarage1 = false,bankGarage4 = false,bankGarage5 = false,bankGarage3 = false, bankGarage2 = false,casinoGarage5= false, casinoGarage4 = false, casinoGarage6 = false ,kotGarage1 = false, kotGarage2 = false, kotGarage3 = false, casinoGarage1 = false, casinoGarage2 = false, casinoGarage3 = false,policeGarage4 = false, impoundParking2 = false, apartmentGarage6 = false, apartmentGarage1 = false, apartmentGarage2 = false, impoundget = false, apartmentGarage3 = false, apartmentGarage4 = false, apartmentGarage5 = false, elginGarage1 = false, elginGarage2 = false, elginGarage3 = false, 
elginGarage4 = false, paletoGarage1 = false, paletoGarage2 = false, paletoGarage3 = false, paletoGarage4 = false, sandyGarage1 = false, sandyGarage2 = false, sandyGarage3 = false, sandyGarage4 = false, 
policeGarage1 = false, policeGarage2 = false, policeGarage3 = false, bennysMrpd = false, bennysOlympic = false, bennysSandy = false, GenericApartment = false, GenericApartmentExit = false, LowEndApartment = false,
LowEndApartmentExit = false, IntegrityWay = false, policeCloset = false, mosleyCloset = false, mosleyBennys = false, impoundLocal = false, impoundParking1 = false, towCloset = false, towGarage = false,
ambulanceGarage1 = false, ambulanceGarage2 = false}
ESX = nil
local inApartment = false
local exit = false
local roomMenu = false
local player,dis


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    exports["bt-polyzone"]:AddBoxZone("policerepair", vector3(449.82, -975.97, 25.7), 4.0, 6.8, {
        name="policerepair",
        heading=0,
        --debugPoly=true,
        minZ=24.7,
        maxZ=27.5
    })
    exports["bt-polyzone"]:AddBoxZone("policeGarage1", vector3(445.83, -997.0, 25.7), 2.4, 4.2, {
        name="policeGarage1",
        heading=0,
        -- debugPoly=true,
        minZ=24.7,
        maxZ=27.3
    })
    exports["bt-polyzone"]:AddBoxZone("policeGarage2", vector3(445.9648,-988.9055,25.6908), 2.5, 4, {
        name="policeGarage2",
        heading=0,
        -- debugPoly=true,
        minZ=24.5,
        maxZ=27.17
    })
    exports["bt-polyzone"]:AddBoxZone("policeGarage3", vector3(446.2286,-994.2879,25.6908), 2.5, 4, {
        name="policeGarage3",
        heading=0,
        -- debugPoly=true,
        minZ=24.5,
        maxZ=27.17
    })
    exports["bt-polyzone"]:AddBoxZone("policeGarage4", vector3(445.89, -991.65, 25.7), 2.4, 4.2, {
        name="policeGarage4",
        heading=0,
        -- debugPoly=true,
        minZ=24.7,
        maxZ=27.1
    })    
   
    exports["bt-polyzone"]:AddBoxZone("bennysOlympic", vector3(731.2879,-1089.007,21.52893), 4, 8, {
		name="bennysOlympic",
		heading=0,
		minZ=21,
		maxZ=24
	})
	exports["bt-polyzone"]:AddBoxZone("bennysSandy", vector3(110.2549, 6626.624, 31.36926), 4, 8, {
		name="bennysSandy",
		heading=135,
		minZ=30,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage1", vector3(-297.5900, -989.6500, 31.0800), 2.5, 4, {
		name="apartmentGarage1",
		heading=158,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage2", vector3(-301.2132,-988.7868,31.06592), 2.5, 4, {
		name="apartmentGarage2",
		heading=158,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage3", vector3(-304.7736,-987.5472,31.06592), 2.5, 4, {
		name="apartmentGarage3",
		heading=158,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage4", vector3(-308.3736,-986.4132,31.06592), 2.5, 4, {
		name="apartmentGarage4",
		heading=158,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage5", vector3(-311.62, -985.19, 31.08), 5.2, 3.4, {
		name="apartmentGarage5",
        heading=340,
        --debugPoly=true,
        minZ=30.08,
        maxZ=32.93
	})
    --start of elgin ave, pillboxhill
    exports["bt-polyzone"]:AddBoxZone("elginGarage1", vector3(247.7143,-758.3735,30.81323), 2.5, 4, {
		name="elginGarage1",
		heading=160,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("elginGarage2", vector3(251.3539, -759.1121, 30.81323), 2.5, 4, {
		name="elginGarage2",
		heading=160,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("elginGarage3", vector3(254.2945,-760.9319,30.81323), 2.5, 4, {
		name="elginGarage3",
		heading=160,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("elginGarage4", vector3(257.4857, -762, 30.81323), 2.5, 4, {
		name="elginGarage4",
		heading=160,
		minZ=29,
		maxZ=33
	})
    --start of paleto truck stop garage
    exports["bt-polyzone"]:AddBoxZone("paletoGarage1", vector3(145.73, 6602.37, 31.8), 2.5, 6, {
		name="paletoGarage1",
		heading=180,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("paletoGarage2", vector3(151.04, 6597.12, 31.8), 2.5, 6, {
		name="paletoGarage2",
		heading=180,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("paletoGarage3", vector3(151.12, 6609.01, 31.8), 2.5, 6, {
		name="paletoGarage3",
		heading=180,
		minZ=29,
		maxZ=33
	})
    exports["bt-polyzone"]:AddBoxZone("paletoGarage4", vector3(145.48, 6612.71, 31.8), 2.5, 6, {
		name="paletoGarage4",
		heading=180,
		minZ=29,
		maxZ=33
	})
    --start of sandy garage
    exports["bt-polyzone"]:AddBoxZone("sandyGarage1", vector3(1949.47, 3759.19, 32.21), 2.5, 4, {
		name="sandyGarage1",
		heading=210,
		minZ=31,
		maxZ=34
	})
    exports["bt-polyzone"]:AddBoxZone("sandyGarage2", vector3(1953.08, 3760.69,32.2), 2.5, 4, {
		name="sandyGarage2",
		heading=210,
		minZ=31,
		maxZ=34
	})
    exports["bt-polyzone"]:AddBoxZone("sandyGarage3", vector3(1956.13, 3762.66, 32.2), 2.5, 4, {
		name="sandyGarage3",
		heading=210,
		minZ=31,
		maxZ=34
	})
    exports["bt-polyzone"]:AddBoxZone("sandyGarage4", vector3(1959.19, 3764.9, 32.2), 2.5, 4, {
		name="sandyGarage4",
		heading=210,
		minZ=31,
		maxZ=34
	})
    exports["bt-polyzone"]:AddBoxZone("policeCloset", vector3(461.38, -997.48, 30.8), 10, 5, {
        name="policeCloset",
        heading=275.0,
        minZ=30,
        maxZ=32
    })
    exports["bt-polyzone"]:AddBoxZone("mosleyCloset", vector3(0.0527, -1660.66, 29.46), 10, 5, {
        name="mosleyCloset",
        heading=51.5,
        minZ=29,
        maxZ=31
    })
    exports["bt-polyzone"]:AddBoxZone("mosleyBennys", vector3(-8.93, -1668.08, 29.48), 15, 15, {
        name="mosleyBennys",
        heading=145.4,
        minZ=29,
        maxZ=31
    })
    -- exports["bt-polyzone"]:AddBoxZone("impoundLocal", vector3(-239.208,-1183.80, 23.02), 10, 6, {
    --     name="impoundLocal",
    --     heading=88.0,
    --     minZ=20,
    --     maxZ=25
    -- })
    exports["bt-polyzone"]:AddBoxZone("impoundParking1", vector3(-152.44,-1169.88, 23.77), 2.5, 4, {
        name="impoundParking1",
        heading=89.78,
        minZ=20,
        maxZ=25
    })
    exports["bt-polyzone"]:AddBoxZone("impoundParking2", vector3(-152.87, -1166.54, 23.77), 3.2, 4.0, {
        name="impoundParking2",
        heading=0,
        --debugPoly=true,
        minZ=22.82,
        maxZ=25.37
    })
    -- exports["bt-polyzone"]:AddBoxZone("towCloset", vector3(-185.04,-1164.61, 23.67), 3, 5, {
    --     name="towCloset",
    --     heading=177.42,
    --     minZ=20,
    --     maxZ=25
    -- })
    -- exports["bt-polyzone"]:AddBoxZone("towGarage", vector3(-209.75,-1169.98, 23.04), 3, 5, {
    --     name="towCloset",
    --     heading=83.01,
    --     minZ=22.5,
    --     maxZ=24.5
    -- })
    exports["bt-polyzone"]:AddBoxZone("ambulanceGarage1", vector3(-848.78, -1228.19, 6.68), 6.2, 3.4, {
        name="ambulanceGarage1",
        heading=320,
        --debugPoly=true,
        minZ=5.53,
        maxZ=8.88
    })
    exports["bt-polyzone"]:AddBoxZone("ambulanceGarage2", vector3(-852.73, -1225.81, 6.63), 5.0, 3.4, {
        name="ambulanceGarage2",
        heading=320,
        --debugPoly=true,
        minZ=5.63,
        maxZ=8.23
    })
    exports["bt-polyzone"]:AddBoxZone("impoundget", vector3(-191.15, -1162.29, 23.67), 2.4, 2.2, {
        name="impoundget",
        heading=358,
        --debugPoly=true,
        minZ=22.67,
        maxZ=24.87
    })
    exports["bt-polyzone"]:AddBoxZone("apartmentGarage6", vector3(-315.24, -984.25, 31.08), 5.4, 3.3, {
        name="apartmentGarage6",
        heading=340,
        --debugPoly=true,
        minZ=30.13,
        maxZ=32.88
    })
    exports["bt-polyzone"]:AddBoxZone("casinoGarage1", vector3(895.11, -5.13, 78.76), 5.6, 2.8, {
        name="casinoGarage1",
        heading=328,
        --debugPoly=true,
        minZ=77.76,
        maxZ=80.51
    })
    exports["bt-polyzone"]:AddBoxZone("casinoGarage2", vector3(898.57, -7.15, 78.76), 5.6, 3.2, {
        name="casinoGarage2",
        heading=328,
        --debugPoly=true,
        minZ=77.76,
        maxZ=80.56
    })
    exports["bt-polyzone"]:AddBoxZone("casinoGarage3", vector3(901.93, -9.46, 78.76), 5.8, 2.8, {
        name="casinoGarage3",
        heading=327,
        --debugPoly=true,
        minZ=77.76,
        maxZ=80.56
    })
    exports["bt-polyzone"]:AddBoxZone("kotGarage1", vector3(276.9, -339.96, 44.92), 3.0, 5.2, {
        name="kotGarage1",
        heading=340,
        --debugPoly=true,
        minZ=43.92,
        maxZ=47.12
    })
    exports["bt-polyzone"]:AddBoxZone("kotGarage2", vector3(278.48, -336.7, 44.92), 2.8, 5.8, {
        name="kotGarage2",
        heading=340,
        --debugPoly=true,
        minZ=43.92,
        maxZ=46.92
    })
    exports["bt-polyzone"]:AddBoxZone("kotGarage3", vector3(279.73, -333.58, 44.92), 3.0, 5.6, {
        name="kotGarage3",
        heading=339,
        --debugPoly=true,
        minZ=43.92,
        maxZ=46.72
    })
    exports["bt-polyzone"]:AddBoxZone("casinoGarage4", vector3(905.21, -11.45, 78.76), 2.6, 5.6, {
        name="casinoGarage4",
        heading=57,
        --debugPoly=true,
        minZ=77.81,
        maxZ=80.36
    })
    exports["bt-polyzone"]:AddBoxZone("casinoGarage5", vector3(908.68, -13.85, 78.76), 3.0, 5.6, {
        name="casinoGarage5",
        heading=57,
        --debugPoly=true,
        minZ=77.76,
        maxZ=80.76
    })

    exports["bt-polyzone"]:AddBoxZone("casinoGarage6", vector3(911.97, -15.82, 78.76), 5.6, 2.8, {
        name="casinoGarage6",
        heading=329,
        --debugPoly=true,
        minZ=77.76,
        maxZ=80.36
    })

    exports["bt-polyzone"]:AddBoxZone("bankGarage1", vector3(-349.46, 272.37, 85.16), 3.2, 5.0, {
        name="bankGarage1",
        heading=0,
        --debugPoly=true,
        minZ=83.96,
        maxZ=86.81
    })
    exports["bt-polyzone"]:AddBoxZone("bankGarage2", vector3(-349.57, 275.84, 85.07), 3.0, 4.8, {
        name="bankGarage2",
        heading=4,
        --debugPoly=true,
        minZ=84.07,
        maxZ=86.92
    })
    exports["bt-polyzone"]:AddBoxZone("bankGarage3", vector3(-349.68, 279.25, 85.05), 3.0, 4.4, {
        name="bankGarage3",
        heading=2,
        --debugPoly=true,
        minZ=84.0,
        maxZ=86.85
    })
    exports["bt-polyzone"]:AddBoxZone("bankGarage4", vector3(-349.9, 282.57, 84.96), 3.2, 4.6, {
        name="bankGarage4",
        heading=2,
        --debugPoly=true,
        minZ=83.96,
        maxZ=86.36
    })
    exports["bt-polyzone"]:AddBoxZone("bankGarage5", vector3(-349.67, 286.13, 85.05), 3.0, 4.6, {
        name="bankGarage5",
        heading=0,
        --debugPoly=true,
        minZ=84.1,
        maxZ=86.65
    })
    exports["bt-polyzone"]:AddBoxZone("kotGarage4", vector3(280.76, -330.25, 44.92), 3.0, 5.6, {
        name="kotGarage4",
        heading=340,
        --debugPoly=true,
        minZ=43.92,
        maxZ=46.52
    })
    exports["bt-polyzone"]:AddBoxZone("kotGarage5", vector3(282.17, -327.13, 44.92), 3.0, 5.6, {
        name="kotGarage5",
        heading=340,
        --debugPoly=true,
        minZ=43.92,
        maxZ=46.92
    })
    exports["bt-polyzone"]:AddBoxZone("policeGarageSheriff1", vector3(1879.33, 3690.1, 33.54),5.4, 3.4,  {
        name="policeGarageSheriff1",
        heading = 30,
        --debugPoly = true,
        minZ = 31.54,
        maxZ = 35.54
    })

    exports["bt-polyzone"]:AddBoxZone("policeGarageSheriff2", vector3(1882.31, 3691.82, 33.54), 3.4, 5.8,  {
        name="policeGarageSheriff2",
        heading = 300,
        --debugPoly = true,
        minZ = 31.94,
        maxZ = 35.94
    })



	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('bt-polyzone:enter')
AddEventHandler('bt-polyzone:enter', function(name)
    if polyzoneBooleans[name] ~= nil then
        polyzoneBooleans[name] = true
    end
    if string.find(name, "Exit") then 
        exit = true
    end
    if string.find(name, "Room_Menu") then 
        roomMenu = true
    end
    -- exports['aw3-ui']:showInteraction("Parking")
end)

RegisterNetEvent('bt-polyzone:exit')
AddEventHandler('bt-polyzone:exit', function(name)
    if polyzoneBooleans[name] ~= nil then
        polyzoneBooleans[name] = false
    end
    if string.find(name, "Exit") then 
        exit = false
    end
    if string.find(name, "Room_Menu") then 
        roomMenu = false
    end
    -- exports['aw3-ui']:hideInteraction()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('np_menu:propertyEntered')
AddEventHandler('np_menu:propertyEntered', function(o)
	inApartment = o
end)

function atGarageCiv() 
    for i, value in ipairs(civGarageNames) do
       if polyzoneBooleans[value] then
            return true
       end
    end   
end

function atpolicerepair()
     for i, value in pairs(repairpolice) do 
        if polyzoneBooleans[value] then
            return true
        end
    end
end
            

function elginGarage()
    for i, value in ipairs(elginGarageNmae) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atpolicegarage()
    for i, value in ipairs(policegaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end
function atpolicegarageSheriff()
    for i, value in ipairs(policegarageSheriffName) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end


function atambualancegarage()
    for i, value in ipairs(ambulancegaragenmae) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atpaletogarage()
    for i, value in ipairs(paletogaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atimpoundparking()
    for i, value in ipairs(impoundname) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atkotgarage()
    for i, value in ipairs(kotGaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end



function atcasinogarage()
    for i, value in ipairs(casinogaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atsandygarage()
    for i, value in ipairs(sandygaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end


function atbankgarage()
    for i, value in ipairs(bankGaragename) do
        if polyzoneBooleans[value] then
            return true
        end
    end
end

function atProperty() 
    for i, value in ipairs(propertyNames) do
       if polyzoneBooleans[value] then
            TriggerEvent('esx_property:setLocation', value)
            return true
       end
    end   
end

rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:escort",  "general:checkoverself", "general:checktargetstates","general:keysgive",  "general:emotes", "general:putinvehicle"}
         
    },
    {
        id = "open armory",
    displayName = "open armory",
    icon = "#mdt",
    functionName = "ubi:openarmory",
    enableMenu = function()
        return ((not isDead and polyzoneBooleans.armory) and (PlayerData.job.name == 'police'))
    end
         
    },
    {
        id = "blips",
        displayName = "Blip",
        icon = "#blips",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "blips:gasstations", "blips:barbershop", "blips:tattooshop", "blips:clothes", "blips:garages", "blips:banka", "blips:dövmeci"}
    },
    {
        id = "medic",
        displayName = "EMS Menu",
        icon = "#medic",
        enableMenu = function()
        local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "ambulance" and not fuck then
                return (not isDead and not IsPedInAnyVehicle(PlayerPedId(), false))
            end
        end,
        subMenus = { "medic:revive", "medic:heal", "medic:bigheal", "kursidorada:spawn"}
    },
    {
        id = "judge-actions",
        displayName = "Mechanic Menu",
        icon = "#mechanic-tool",
        enableMenu = function()
            local ped = PlayerPedId()
           PlayerData = ESX.GetPlayerData()
            
            if PlayerData.job.name == "mechanic" and not fuck then
               return (not isDead and not IsPedInAnyVehicle(PlayerPedId(), false))
            end
        end,
        subMenus = { "mechanic:hijack", "mechanic:clean", "mechanic:impound", "mechanic:repair"}
    },
    {
        id = "police-action",
        displayName = "Radio",
        icon = "#police-vehicle-radar",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead and exports["ubi-inventory"]:hasEnoughOfItem("radio",1,false))
        end,
        subMenus = {"radio:1", "radio:2", "radio:3", "radio:leave"}
    },
    {
        id = "police-action",
        displayName = "Radio",
        icon = "#police-vehicle-radar",
        enableMenu = function()
            return (PlayerData.job.name == 'ambulance' and not isDead and exports["ubi-inventory"]:hasEnoughOfItem("radio",1,false))
        end,
        subMenus = {"radio:1", "radio:2", "radio:3", "radio:leave"}
    },
    {
        id = "police-action",
        displayName = "police action",
        icon = "#police-action",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead and not IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = {"police:putInVeh", "general:unseatnearest", "police:escort", "police:runplate", "cuffs:remmask", "police:removeweapons", "police:frisk"}
    },
    {
        id = "police-check",
        displayName = "Police Checks",
        icon = "#police-check",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead and not IsPedInAnyVehicle(PlayerPedId(), false)) 
        end,
        subMenus = {"general:checktargetstates", "police:checkbank", "police:checklicenses", "cuffs:checkinventory", "police:gsr", "police:dnaswab" }
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = { "police:runplate", "police:toggleradar"}
    },
    {
        id = "vehicle-repair",
        displayName = "Mechanic Menu",
        icon = "#vehicle-vehicleList",
         functionName = "Repair:menu",
         enableMenu = function()
            return  not isDead and PlayerData.job.name ==  'police' and atpolicerepair() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    -- {
    --     id = "ems-storekursiroda",
    --     displayName = "save wheelchair",
    --     icon = "#general-put-in-veh",
    --      functionName = "ubi-base1:store",
    --      enableMenu = function()
    --         return not isDead and PlayerData.job.name == 'ambulance' and exports['ubi-garage']:NearVehicle('plate') and not IsPedInAnyVehicle(PlayerPedId(), false)
    --     end
    -- },
       --garage apart
       {
        id = "vehicle-vehicleList",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return  not isDead and atGarageCiv() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    {
        id = "vehicle-parkvehicle",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and atGarageCiv() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    {
        id = "vehicle-vehicleListpoliceGarageSheriff",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return  not isDead and atpolicegarageSheriff() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    {
        id = "vehicle-parkvehiclepoliceGarageSheriff",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and atpolicegarageSheriff() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    {
        id = "vehicle-vehicleListesandygarage",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return  not isDead and atsandygarage() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
        ---garage bekangrs
        {
        id = "vehicle-parkvehicleelegigarage",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and elginGarage() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
    -- garage sandy
        {
        id = "vehicle-parkvehiclesandy",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and atsandygarage() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
-- garage paleto
    {
        id = "vehicle-vehicleListpalto",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return  not isDead and atpaletogarage() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
        {
        id = "vehicle-parkvehiclepaleto",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and atpaletogarage() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
--- garage impouind
    {
        id = "vehicle-vehicleListpalto",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return  not isDead and atimpoundparking() and not IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
        {
        id = "vehicle-parkvehiclepaleto",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return  not isDead and atimpoundparking() and IsPedInAnyVehicle(PlayerPedId(), false)
        end
    },
--impound

 
    
    
    --ambluance
    {
        id = "vehicle-vehiclesdadwambluance",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "EMSgarage:menu",
         enableMenu = function()
            return not isDead and atambualancegarage() and PlayerData.job.name == 'ambulance' and not IsPedInAnyVehicle(PlayerPedId(), false)  
        end
    },
        {
        id = "vehicle-parkvehiclesdwadambluance",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return not isDead and atambualancegarage() and PlayerData.job.name == 'ambulance' and IsPedInAnyVehicle(PlayerPedId(), false) 
        end
    },
    ---police ---
    {
        id = "vehicle-vehiclesdadwapolice",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "policegarage:menu",
         enableMenu = function()
            return not isDead and atpolicegarage() and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(PlayerPedId(), false)  
        end
    },
        {
        id = "vehicle-parkvehiclesdwadpolice",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return not isDead and atpolicegarage() and PlayerData.job.name == 'police' and IsPedInAnyVehicle(PlayerPedId(), false) 
        end
    },
    --- casino garage --
    {
        id = "vehicle-vehiclesdadwapolice",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return not isDead and atcasinogarage() and not IsPedInAnyVehicle(PlayerPedId(), false)  
        end
    },
        {
        id = "vehicle-parkvehiclesdwadpolice",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return not isDead and atcasinogarage() and IsPedInAnyVehicle(PlayerPedId(), false) 
        end
    },
--garage D
    {
        id = "vehicle-vehiclesdadwapolice",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return not isDead and atkotgarage() and not IsPedInAnyVehicle(PlayerPedId(), false)  
        end
    },
        {
        id = "vehicle-parkvehiclesdwadpolice",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return not isDead and atkotgarage() and IsPedInAnyVehicle(PlayerPedId(), false) 
        end
    },
--Garage E
    {
        id = "vehicle-vehiclesdadwapolice",
        displayName = "Garage",
        icon = "#vehicle-vehicleList",
         functionName = "ubi-garage:Opengarageall",
         enableMenu = function()
            return not isDead and atbankgarage() and not IsPedInAnyVehicle(PlayerPedId(), false)  
        end
    },
        {
        id = "vehicle-parkvehiclesdwadpolice",
        displayName = "Parking Vehicle",
        icon = "#mechanic-impon",
         functionName = "ubi-garage:StoreOwnedVehicle",
         enableMenu = function()
            return not isDead and atbankgarage() and IsPedInAnyVehicle(PlayerPedId(), false) 
        end
    },

    
    -- {
    --     id = "general",
    --     displayName = "Store Vehicle",
    --     icon = "#blips-garages",
    --      functionName = "advancedGarage:StoreOwnedPoliceRadial",
    --      enableMenu = function()
    --     return  not isDead and atGarageCiv() and  IsPedInAnyVehicle(PlayerPedId(), false)
    -- end
    -- },

    
    -- {
    --     id = "general",
    --     displayName = "Open Garage",
    --     icon = "#general-keys-give",
    --      functionName = "ubi-garages:car",
    --      enableMenu = function()
    --         return  not isDead and atGarageCiv() and not IsPedInAnyVehicle(PlayerPedId(), false)
    --     end
    -- },
    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
            return not isDead and not IsPedInAnyVehicle(PlayerPedId(), false)
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            return not isDead and not IsPedInAnyVehicle(PlayerPedId(), false)
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "clothes",
        displayName = "Clothing",
        icon = "#walking",
        enableMenu = function()
            return not isDead and not IsPedInAnyVehicle(PlayerPedId(), false) and ((polyzoneBooleans['policeCloset'] and PlayerData.job.name == 'police') or (polyzoneBooleans['towCloset'] and PlayerData.job.name == 'towing') or (polyzoneBooleans['mosleyCloset'] and PlayerData.job.name == 'mosleys_mech'))
        end,
        subMenus = { "clothes:store", "propertyMenu:outfits"}
    },
    {
        id = "judge-raid",
        displayName = "DoJ Menu",
        icon = "#judge-raid",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "judge-raid:checkowner", "judge-raid:seizeall", "judge-raid:takecash", "judge-raid:takedm"}
    },
    {
        id = "judge-licenses",
        displayName = "DoJ Licenses",
        icon = "#judge-licenses",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:checklicenses", "judge:grantDriver", "judge:grantBusiness", "judge:grantWeapon", "judge:grantHouse", "judge:grantBar", "judge:grantDA", "judge:removeDriver", "judge:removeBusiness", "judge:removeWeapon", "judge:removeHouse", "judge:removeBar", "judge:removeDA", "judge:denyWeapon", "judge:denyDriver", "judge:denyBusiness", "judge:denyHouse" }
    },
    {
        id = "judge-actions",
        displayName = "DoJ Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    },
    {
        id = "da-actions",
        displayName = "DA Actions",
        icon = "#judge-actions",
        enableMenu = function()
            return (not isDead and isJudge)
        end,
        subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory"}
    },
    {
        id = "laport",
        displayName = "35-45",
        icon = "#expressions-sulking",
        functionName= "ubi:kunci",
        enableMenu = function()
            return ( isDead )
        end,
    },
    {
        id = "mati",
        displayName = "Out Vehicle",
        icon = "#general-put-in-veh",
        functionName= "out:veh",
        enableMenu = function()
            return ( isDead and IsPedInAnyVehicle(PlayerPedId(), false) )
        end,
    },
    -- {
    --     id = "cuff",
    --     displayName = "Cuff",
    --     icon = "#cuffs",
    --     enableMenu = function()
    --         if not isDead and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) and not isHandcuffed and not isHandcuffedAndWalking then
    --             if isPolice then
    --                 return true
    --             elseif not isPolice then
    --                 t, distance = GetClosestPlayer()
    --                 local serverId = GetPlayerServerId(t)
    --                 if(distance ~= -1 and distance < 3 and not IsPedRagdoll(PlayerPedId())) then
    --                     if cuffStates[serverId] == nil then
    --                         return false
    --                     else
    --                         return cuffStates[serverId]
    --                     end
    --                 end
    --             end
    --         end
    --         return false
    --     end,
    --     subMenus = { "cuffs:uncuff", "cuffs:remmask", "cuffs:checkinventory", "cuffs:unseat", "police:seat", "cuffs:checkphone" }
    -- },
    {
        id = "bennys",
        displayName = "Bennys",
        icon = "#general-check-vehicle",
        functionName = "esx_lscustom:bennysRadial",
        enableMenu = function()
            return not isDead and polyzoneBooleans.bennysOlympic or not isDead and polyzoneBooleans.bennysSandy or (not isDead and polyzoneBooleans.mosleyBennys and PlayerData.job.name == 'mosleys_mech')
        end
    },
    {
        id = "lcokveh",
        displayName = "lock vehicle",
        icon = "#general-key",
        functionName= "ubi:kunci",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "cuff",
        displayName = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "handcuff-police",
        enableMenu = function()
            return (not isDead and not isHandcuffed and not isHandcuffedAndWalking and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "repair",
        displayName = "Benny's",
        icon = "#general-check-vehicle",
        functionName = "esx_policejob:bennysRepairRadial",
        enableMenu = function()
            return (not isDead and not isHandcuffed and not isHandcuffedAndWalking and PlayerData.job.name == 'police' and IsPedInAnyVehicle(PlayerPedId(), false) and polyzoneBooleans.bennysMrpd)
        end
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
            return (PlayerData.job.name == 'ambulance' and not isDead)
        end,
        subMenus = {"medic:revive", "medic:heal", "medic:escort", "medic:putInVeh", "medic:putOutVeh"}
    },
    {
        id = "burgershot",
        displayName = "burgershot",
        icon = "#burger",
        enableMenu = function()
            return (PlayerData.job.name == 'burgershot' and not isDead)
        end,
        subMenus = {"medic:putOutVeh"}
    },
    {
        id = "strecther",
        displayName = "Put on Stretcher",
        icon = "#general-put-in-veh",
        functionName = "stretcher:findPlayer",
        enableMenu = function()
            return (checkStrechter() and PlayerData.job.name == 'mount_zonah')
        end
    },
    {
        id = "news",
        displayName = "Weazel News",
        icon = "#news",
        enableMenu = function()
            return (PlayerData.job.name == 'reporter' and not isDead)
        end,
        subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
    },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "vehcontrol:openExternal",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
	{
        id = "impound",
        displayName = "Impound",
        icon = "#impound-vehicle",
        functionName = "impon:veh",
        enableMenu = function()
            if (PlayerData.job.name == 'police' and not isDead) then
                return true
            end
            return false
        end,
        subMenus = {}
    }, {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
            return not isDead and hasOxygenTankOn
        end
    },  
	{
        id = "mdt",
        displayName = "MDT",
        icon = "#mdt",
        functionName = "mdt:radialopen",
        enableMenu = function()
            return (PlayerData.job.name == 'police' and not isDead)
        end
    },
    {
        id = "propertyMenu",
        displayName = "Property Menu",
        icon = "#judge-licenses-grant-house",
        enableMenu = function()
            return not isDead and roomMenu
        end,
        subMenus = {"propertyMenu:outfits", "propertyMenu:inventory"}
    },
    -- {
    --     id = "enterProperty",
    --     displayName = "Enter Property",
    --     icon = "#judge-licenses-grant-house",
    --     functionName = "esx_property:enterPropertyRadial",
    --     enableMenu = function()
    --         return not isDead 
    --     end,
    --     subMenus = {}
    -- },
    {
        id = "exitProperty",
        displayName = "Exit Property",
        icon = "#judge-licenses-grant-house",
        functionName = "esx_property:exitPropertyRadial",
        enableMenu = function()
            return not isDead and exit
        end,
        subMenus = {}
    },
    {
        id = "towing",
        displayName = "Tow Options",
        icon = "#vehicle-options-vehicle",
        functionName = "erp_towscript:depositRadial",
        enableMenu = function()
            return (not isDead and PlayerData.job.name == 'towing' and polyzoneBooleans.impoundLocal)
        end,
        subMenus = {"towing:impound"}
    },
    -- {
    --     id = "rob",
    --     displayName = "Rob",
    --     icon = "#cuffs-check-inventory",
    --     functionName = "np-menu:intiateRobbing",
    --     enableMenu = function()
    --         return canPlayerBeRobbed()
    --     end
    -- }

}

newSubMenus = {
    ['general:emotes'] = {
        title = "Emotes",
        icon = "#general-emotes",
        functionName = "dp:RecieveMenu"
    },

    ['general:keysgive'] = {
        title = "Give Key",
        icon = "#general-keys-give",
        functionName = "onyx:checkKeys"
    },
    ['general:checkoverself'] = {
        title = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "Evidence:CurrentDamageList"
    },
    ['general:checktargetstates'] = {
        title = "Examine Target",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    },
    ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "towgarage:annoyedBouce"
    },
    ['general:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "carry:command"
    },
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "carry:putInVeh"
        
        --esx_policejob:putInVehicleRadial
    },
    ['general:openamroy'] = {
        title = "Open Armory",
        icon = "#general-put-in-veh",
        functionName = "ubi:openarmory"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "ubi-policejob:OutVehicle"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    ['propertyMenu:outfits'] = {
        title = "Outfits",
        icon = "#walking",
        functionName = "raid_clothes:oufitsMenuRadial"
    },
    ['propertyMenu:inventory'] = {
        title = "Storage",
        icon = "#cuffs-check-inventory",
        functionName = "esx_property:openInventoryPropertyRadial"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "dpemote:walkBraveRadial"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "dpemote:walkHurryRadial"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "dpemote:walkBusinessRadial"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "dpemote:walkTipsyRadial"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "dpemote:walkInjuredRadial"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "dpemote:walkToughRadial"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "dpemote:walkSassyRadial"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "dpemote:walkSadRadial"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "dpemote:walkPoshRadial"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "dpemote:walkAlienRadial"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "dpemote:walkHoboRadial"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "dpemote:walkMoneyRadial"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "dpemote:walkSwaggerRadial"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "dpemote:walkShadyRadial"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "dpemote:walkManEaterRadial"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "dpemote:walkChiChiRadial"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "dpemote:walkDefaultRadial"
    },
    ['clothes:store'] = {
        title = "Closet",
        icon = "#police-check",
        functionName = "raid_clothes:openmenu"
    },
    ['k9:spawn'] = {
        title = "Summon",
        icon = "#k9-spawn",
        functionName = "K9:Create"
    },
    ['k9:delete'] = {
        title = "Dismiss",
        icon = "#k9-dismiss",
        functionName = "K9:Delete"
    },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "K9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get in/out",
        icon = "#k9-vehicle",
        functionName = "K9:Vehicle"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "K9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "K9:Lay"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "K9:Stand"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "K9:Sniff"
    },
    ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "sniffVehicle"
    },
    ['k9:huntfind'] = {
        title = "Hunt nearest",
        icon = "#k9-huntfind",
        functionName = "K9:Huntfind"
    },
    ['blips:gasstations'] = {
        title = "Gas Stations",
        icon = "#blips-gasstations",
        functionName = "CarPlayerHud:ToggleGas"
    },    
    ['blips:trainstations'] = {
        title = "Train Stations",
        icon = "#blips-trainstations",
        functionName = "Trains:ToggleTainsBlip"
    },
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:barbershop'] = {
        title = "Barber Shop",
        icon = "#blips-barbershop",
        functionName = "hairDresser:ToggleHair"
    },    
    ['blips:tattooshop'] = {
        title = "Tattoo Shop",
        icon = "#blips-tattooshop",
        functionName = "tattoo:ToggleTattoo"
    },
    ['drivinginstructor:drivingtest'] = {
        title = "Driving Test",
        icon = "#drivinginstructor-drivingtest",
        functionName = "drivingInstructor:testToggle"
    },
    ['drivinginstructor:submittest'] = {
        title = "Submit Test",
        icon = "#drivinginstructor-submittest",
        functionName = "drivingInstructor:submitTest"
    },
    ['judge-raid:checkowner'] = {
        title = "Check Owner",
        icon = "#judge-raid-check-owner",
        functionName = "appartment:CheckOwner"
    },
    ['judge-raid:seizeall'] = {
        title = "Seize All Content",
        icon = "#judge-raid-seize-all",
        functionName = "appartment:SeizeAll"
    },
    ['judge-raid:takecash'] = {
        title = "Take Cash",
        icon = "#judge-raid-take-cash",
        functionName = "appartment:TakeCash"
    },
    ['judge-raid:takedm'] = {
        title = "Take Marked Bills",
        icon = "#judge-raid-take-dm",
        functionName = "appartment:TakeDM"
    },
    ['cuffs:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "esx_policejob:handCuffRadial"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "police:uncuffMenu"
    },
    ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "raid_clothes:policeRemovePropsRadial"
    },
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "ubi:policesrc"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "esx_policejob:OutVehicleRadial"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "esx_ambulancejob:revivePlayerRadial"
    },
    ['kursidorada:spawn'] = {
        title = "Spawn WChair",
        icon = "#drivinginstructor-drivingtest",
        functionName = "spanw:kuirsoda"
    },
    ['medic:heal'] = {
        title = "Heal",
        icon = "#medic-heal",
        functionName = "esx_ambulancejob:healPlayerRadial"
    },
    ['medic:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "esx_ambulancejob:dragRadial"
    },
    ['medic:putInVeh'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "esx_ambulancejob:putInVehicleRadial"
    },
    ['medic:putOutVeh'] = {
        title = "Unseat Vehicle",
        icon = "#general-unseat-nearest",
        functionName = "esx_ambulancejob:OutVehicleRadial"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "esx_policejob:handCuffRadial"
    },
    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:checkBank"
    },
    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:checkLicenses"
    },
    ['police:removeweapons'] = {
        title = "Remove Weapons License",
        icon = "#police-action-remove-weapons",
        functionName = "remove:weaponlis"
    },
    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "police:gsr"
    },
    ['radio:1'] = {
        title = "Radio 1",
        icon = "#police-vehicle-radar",
        functionName = "radio1:joint"
    },
    ['radio:2'] = {
        title = "Radio 2",
        icon = "#police-vehicle-radar",
        functionName = "radio2:joint"
    },
    ['radio:3'] = {
        title = "Radio 3",
        icon = "#police-vehicle-radar",
        functionName = "radio3:joint"
    },
    ['radio:leave'] = {
        title = "Leave Radio",
        icon = "#news-job-news-microphone",
        functionName = "radio:leave"
    },
    ['police:dnaswab'] = {
        title = "DNA Swab",
        icon = "#police-action-dna-swab",
        functionName = "evidence:dnaSwab"
    },
    ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    },
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "esx_policejob:runPlateRadial"
    },
    ['police:frisk'] = {
        title = "Frisk",
        icon = "#police-action-frisk",
        functionName = "esx_policejob:FriskRadial"
    },
    ['police:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "ubi-policejob:drag"
    },
    ['police:putInVeh'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "ubi-policejob:putInVehicle"
    },
    -- ['garage:putaway'] = {
    --     title = "Put Away",
    --     icon = "#blips-garages",
    --     functionName = "ubi-garage:StoreOwnedVehicle"
    -- },
    -- ['garage:takeout'] = {
    --     title = "Take Out",
    --     icon = "#general-keys-give",
    --     functionName = "advancedGarage:OpenJobGarageRadial"
    -- },
    -- ['garageCiv:putaway'] = {
    --     title = "Put Away",
    --     icon = "#blips-garages",
    --     functionName = "ubi-garage:StoreOwnedVehicle"
    -- },
    -- ['garageCiv:takeout'] = {
    --     title = "Take Out",
    --     icon = "#general-keys-give",
    --     functionName = "MojiaGarages:client:openGarage"
    -- },
    ['judge:grantDriver'] = {
        title = "Grant Drivers",
        icon = "#judge-licenses-grant-drivers",
        functionName = "police:grantDriver"
    }, 
    ['judge:grantBusiness'] = {
        title = "Grant Business",
        icon = "#judge-licenses-grant-business",
        functionName = "police:grantBusiness"
    },  
    ['judge:grantWeapon'] = {
        title = "Grant Weapon",
        icon = "#judge-licenses-grant-weapon",
        functionName = "police:grantWeapon"
    },
    ['judge:grantHouse'] = {
        title = "Grant House",
        icon = "#judge-licenses-grant-house",
        functionName = "police:grantHouse"
    },
    ['judge:grantBar'] = {
        title = "Grant BAR",
        icon = "#judge-licenses-grant-bar",
        functionName = "police:grantBar"
    },
    ['judge:grantDA'] = {
        title = "Grant DA",
        icon = "#judge-licenses-grant-da",
        functionName = "police:grantDA"
    },
    ['judge:removeDriver'] = {
        title = "Remove Drivers",
        icon = "#judge-licenses-remove-drivers",
        functionName = "police:removeDriver"
    },
    ['judge:removeBusiness'] = {
        title = "Remove Business",
        icon = "#judge-licenses-remove-business",
        functionName = "police:removeBusiness"
    },
    ['judge:removeWeapon'] = {
        title = "Remove Weapon",
        icon = "#judge-licenses-remove-weapon",
        functionName = "police:removeWeapon"
    },
    ['judge:removeHouse'] = {
        title = "Remove House",
        icon = "#judge-licenses-remove-house",
        functionName = "police:removeHouse"
    },
    ['judge:removeBar'] = {
        title = "Remove BAR",
        icon = "#judge-licenses-remove-bar",
        functionName = "police:removeBar"
    },
    ['judge:removeDA'] = {
        title = "Remove DA",
        icon = "#judge-licenses-remove-da",
        functionName = "police:removeDA"
    },
    ['judge:denyWeapon'] = {
        title = "Deny Weapon",
        icon = "#judge-licenses-deny-weapon",
        functionName = "police:denyWeapon"
    },
    ['judge:denyDriver'] = {
        title = "Deny Drivers",
        icon = "#judge-licenses-deny-drivers",
        functionName = "police:denyDriver"
    },
    ['judge:denyBusiness'] = {
        title = "Deny Business",
        icon = "#judge-licenses-deny-business",
        functionName = "police:denyBusiness"
    },
    ['judge:denyHouse'] = {
        title = "Deny House",
        icon = "#judge-licenses-deny-house",
        functionName = "police:denyHouse"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "Cam:ToggleCam"
    },
    ['mechanic:hijack'] = {
        title = "hijack Vehicle",
        icon = "#mechanic-hijac",
        functionName = "esx_mechanicjob:onHijack"
    },
    ['mechanic:repair'] = {
        title = "repair vehicle",
        icon = "#mechanic-repair",
        functionName = "Repair:menu"
    },
    ['mechanic:clean'] = {
        title = "clean Vehicle",
        icon = "#mechanic-clean",
        functionName = "clean:veh"
    },
    ['mechanic:impound'] = {
        title = "impound Vehicle",
        icon = "#mechanic-impon",
        functionName = "impon:veh"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "Mic:ToggleMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "Mic:ToggleBMic"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Angry" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Drunk" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Dumb" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Electrocuted" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "dpemotes:emoteRadial", 
        functionParameters =  { "Grumpy2" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Happy" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Injured" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "dpemotes:emoteRadial",
        functionParameters =  { "Joyful" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Mouthbreather" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Never Blink" }
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "One Eye" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Shocked" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Sleeping2" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Smug" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Speculative" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Stressed" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Sulking" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Weird" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "dpemotes:emoteRadial",
        functionParameters = { "Weird2" }
    },
    ["towing:impound"]  = {
        title="Impound",
        icon="#judge-licenses-remove-drivers",
        functionName = "erp_towscript:depositRadial",
        functionParameters = {}
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "reporter" then isNews = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "reporter" then isNews = true end
    if job == "doctor" then isDoctor = true end
    myJob = job
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function checkStrechter()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closestObject = GetClosestVehicle(pedCoords, 3.0, GetHashKey("stretcher"), 70)
    return DoesEntityExist(closestObject)
end
function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

-- function GetClosestPlayer()
--     local players = GetPlayers()
--     local closestDistance = -1
--     local closestPlayer = -1
--     local closestPed = -1
--     local ply = PlayerPedId()
--     local plyCoords = GetEntityCoords(ply, 0)
--     if not IsPedInAnyVehicle(PlayerPedId(), false) then
--         for index,value in ipairs(players) do
--             local target = GetPlayerPed(value)
--             if(target ~= ply) then
--                 local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
--                 local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
--                 if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
--                     closestPlayer = value
--                     closestPed = target
--                     closestDistance = distance
--                 end
--             end
--         end
--         return closestPlayer, closestDistance, closestPed
--     end
-- end

local idToRob

-- function canPlayerBeRobbed()
--     player,dis = ESX.Game.GetClosestPlayer()
--     local id = GetPlayerServerId(player)
--     local robbable = nil
--     if player ~= -1 then 
--         ESX.TriggerServerCallback('esx_thief:getValue', function(result)
--             local result = result
--             if result.value then
--                 robbable = true
--                 idToRob = id
--             else
--                 robbable = false
--                 idToRob = nil
--             end
--         end, id)
--     else
--         robbable= false
--     end
--     while robbable == nil do
--         Wait(10)
--     end
--     -- print(robbable)
--     return robbable
-- end

RegisterNetEvent('np-menu:intiateRobbing')
AddEventHandler('np-menu:intiateRobbing', function()
	TriggerServerEvent('esx_policejob:getPlayerID', idToRob, distance, 'rob')
end)

RegisterNetEvent('np-menu:robPlayer')
AddEventHandler('np-menu:robPlayer', function(distance, identifier)
    local player = PlayerPedId()
    if distance < 2 then
        exports['progressBars']:startUI(7000, "Robbing player")
        FreezeEntityPosition(player, true)
        TaskStartScenarioInPlace(player, "PROP_HUMAN_BUM_BIN", 0, true)
        Citizen.Wait(7000)
        FreezeEntityPosition(player, false)
        ClearPedTasks(player)
        exports["mf-inventory"]:openOtherInventory(identifier)
    end
end)

trainstations = {
    {-547.34057617188,-1286.1752929688,25.3059978411511},
    {-892.66284179688,-2322.5168457031,-13.246466636658},
    {-1100.2299804688,-2724.037109375,-8.3086919784546},
    {-1071.4924316406,-2713.189453125,-8.9240007400513},
    {-875.61907958984,-2319.8686523438,-13.241264343262},
    {-536.62890625,-1285.0009765625,25.301458358765},
    {270.09558105469,-1209.9177246094,37.465930938721},
    {-287.13568115234,-327.40936279297,8.5491418838501},
    {-821.34295654297,-132.45257568359,18.436864852905},
    {-1359.9794921875,-465.32354736328,13.531299591064},
    {-498.96591186523,-680.65930175781,10.295949935913},
    {-217.97073364258,-1032.1605224609,28.724565505981},
    {113.90325164795,-1729.9976806641,28.453630447388},
    {117.33223724365,-1721.9318847656,28.527353286743},
    {-209.84713745117,-1037.2414550781,28.722997665405},
    {-499.3971862793,-665.58514404297,10.295639038086},
    {-1344.5224609375,-462.10494995117,13.531820297241},
    {-806.85192871094,-141.39852905273,18.436403274536},
    {-302.21514892578,-327.28854370117,8.5495929718018},
    {262.01733398438,-1198.6135253906,37.448017120361},
    {2072.4086914063,1569.0856933594,76.712524414063},
    {664.93090820313,-997.59942626953,22.261747360229},
    {190.62687683105,-1956.8131103516,19.520135879517},
    {2611.0278320313,1675.3806152344,26.578210830688},
    {2615.3901367188,2934.8666992188,39.312232971191},
    {2885.5346679688,4862.0146484375,62.551517486572},
    {47.061096191406,6280.8969726563,31.580261230469},
    {2002.3624267578,3619.8029785156,38.568252563477},
    {2609.7016601563,2937.11328125,39.418235778809}
}

RegisterNetEvent("out:veh", function()
local playerPed = PlayerPedId()

	-- if isDead and IsPedSittingInAnyVehicle(playerPed) then
	local vehicle = GetVehiclePedIsIn(playerPed, false)
    TriggerEvent("hud:seatbelt")
    Wait(500)
	TaskLeaveVehicle(playerPed, vehicle, 64)
    -- else
    --     exports['mythic_notify']:SendAlert('error', 'only for dead player')
	-- end
end)


--garage 

