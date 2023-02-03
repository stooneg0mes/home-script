vRP = Proxy.getInterface("vRP")

local tunnel = module("vrp", "lib/Tunnel")
local proxy = module("vrp", "lib/Proxy")
local src = {}

-- On script start

AddEventHandler('onServerResourceStart', function(name)
    if (name ~= "testscript") then
        return
    end

    -- print("Script enabled client side")
end)