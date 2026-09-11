Config = {}


Config.DefaultImpoundPed = `s_m_y_construct_01`

Config.BlipColors = {
    Car = 3,
    Boat = 51,
    Aircraft = 81
}

Config.ImpoundPrices = {
    -- These are vehicle classes
    ['0'] = 300, -- Compacts
    ['1'] = 500, -- Sedans
    ['2'] = 500, -- SUVs
    ['3'] = 800, -- Coupes
    ['4'] = 1200, -- Muscle
    ['5'] = 800, -- Sports Classics
    ['6'] = 1500, -- Sports
    ['7'] = 2500, -- Super
    ['8'] = 300, -- Motorcycles
    ['9'] = 500, -- Off-road
    ['10'] = 1000, -- Industrial
    ['11'] = 500, -- Utility
    ['12'] = 600, -- Vans
    ['13'] = 100, -- Cylces
    ['14'] = 2800, -- Boats
    ['15'] = 3500, -- Helicopters
    ['16'] = 3800, -- Planes
    ['17'] = 500, -- Service
    ['18'] = 0, -- Emergency
    ['19'] = 100, -- Military
    ['20'] = 1500, -- Commercial
    ['21'] = 0 -- Trains (lol)
}

Config.PayInCash = true-- whether you want to pay impound price in cash, otherwise uses bank

Config.Impounds = {
    {
        type = 'car', -- car, boat or aircraft
        BlipsCoords = vector4(409.25, -1623.08, 28.29, 228.84),
        zone = {name = 'innocence', x = -191.12, y = -1169.44, z = 23.67, l = 17.95, w = 20.2, h = 0, minZ = 22.12, maxZ = 26.67}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            vector4(-184.38247680664,-1173.4378662109,23.04404258728, 193.77),
            vector4(-187.8157043457,-1173.4968261719,22.684078216553, 197.87),
            vector4(-191.22888183594,-1173.7080078125,22.684078216553, 197.87),
            vector4(-194.72969055176,-1174.0512695313,22.684078216553, 206.87),
            vector4(-198.17250061035,-1173.8702392578,22.684078216553, 206.87)
        }
    },
    {
        type = 'boat',
        BlipsCoords = vector4(-462.92, -2443.44, 5.00, 322.40),
        zone = {name = 'lsboat impound', x = -451.72, y = -2440.42, z = 6.0, l = 22.6, w = 29.4, h = 325, minZ = 5.0, maxZ = 9.0},
        spawns = {
            vector4(-493.48, -2466.38, -0.06, 142.26),
            vector4(-471.09, -2483.94, 0.28, 152.74),
        }
    },
    {
        type = 'aircraft',
        BlipsCoords = vector4(1758.29, 3297.50, 40.15, 148.27),
        zone = {name = 'sandy air', x = 1757.71, y = 3296.72, z = 41.15, l = 14.4, w = 18.0, h = 50, minZ = 40.13, maxZ = 44.13},
        spawns = {
            vector4(1753.72, 3272.12, 41.99, 105.71),
            vector4(1746.85, 3252.57, 42.30, 105.58),
        }
    },
}

  
