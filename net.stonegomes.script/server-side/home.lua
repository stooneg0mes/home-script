-- Home cache

HomeCache = {}

function containsHomeKey(key)    
    return HomeCache[key] ~= nil
end

function putHomeValue(key, value)
    HomeCache[key] = value
end

function removeHomeKey(key) 
    local value = HomeCache[key]
    if (value == nil) then
        return
    end

    HomeCache[key] = nil
end

-- Home table

Home = {}
Home.metaTable = {}

function Home.new(id, x, y, z)
    local home = {}
    setmetatable(home, Home.metaTable)

    home.id = id
    home.x = x
    home.y = y
    home.z = z

    return home
end