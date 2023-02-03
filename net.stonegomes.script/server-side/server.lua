vRP = Proxy.getInterface("vRP")

local tunnel = module("vrp", "lib/Tunnel")
local proxy = module("vrp", "lib/Proxy")
local src = {}

-- On server script start

AddEventHandler('onServerResourceStart', function(name)
    if (name ~= "testscript") then
        return
    end

    MySQL.Async.execute("CREATE TABLE IF NOT EXISTS homes(id VARCHAR(32) NOT NULL PRIMARY KEY, x FLOAT NOT NULL, y FLOAT NOT NULL, z FLOAT NOT NULL)")

    MySQL.Async.fetchAll("SELECT * FROM homes", function(result)
        if result then
            for i = 1, #result do
                local queryResult = result[i]
                local home = Home.new(queryResult.id, queryResult.x, queryResult.y, queryResult.z)

                putHomeValue(home.id, home)
                print("Loaded " .. home.id .. " successfully.")
            end
        end
    end)
end)

-- On script stop

AddEventHandler('onResourceStop', function(name)
    if (name ~= "testscript") then
        return
    end

    for key, value in pairs(HomeCache) do
        -- INSERT INTO homes (id, x, y, z) VALUES (@id, @x, @y, @z) ON DUPLICATE KEY UPDATE (x = @x, y = @y, z = @z)
        MySQL.Async.execute("REPLACE INTO homes (id, x, y, z) VALUES (?, ?, ?, ?)", {
            value.id,
            value.x,
            value.y,
            value.z
        })
        print("Replaced home " .. key .. " successfully.")
    end
end)

-- Set home command

RegisterCommand('sethome', function(source, args)
    if (#args == 0) then
        print("You need to run an argument.")
        return
    end

    local homeId = args[1]
    if (containsHomeKey(homeId)) then
        print("There is already a home with that ID.")
        return
    end

    local pedPlayer = GetPlayerPed(source)
    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(pedPlayer))

    local home = Home.new(homeId, playerX, playerY, playerZ)
    putHomeValue(homeId, home)

    print("Created the home " .. homeId .. " successfully.")
end)