local ids = {}

local function assignPlayerId(player)
    for i, p in ipairs(ids) do
        if not p then
            ids[i] = player
            player:setData("id", i)
            return true
        end
    end
    table.insert(ids, player)
    return player:setData("id", #ids)
end

local function clearPlayerId(player)
    local id = player:getData("id")
    if not id then
        return false
    end
    if id == #ids then
        table.remove(ids, id)
        return true
    end
    ids[id] = false
    return true
end

addEventHandler("onPlayerJoin", root, function ()
    assignPlayerId(source)
end)

addEventHandler("onPlayerQuit", root, function ()
    clearPlayerId(source)
end)

addEventHandler("onResourceStart", resourceRoot, function ()
    for i, player in ipairs(getElementsByType("player")) do
        assignPlayerId(player)
    end
end)