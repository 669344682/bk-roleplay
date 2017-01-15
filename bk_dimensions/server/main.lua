local currentPrivateDimension = 1000 

addEvent("bkEnterPrivateDimension", true)
addEventHandler("bkEnterPrivateDimension", resourceRoot, function (name, ...)
    if client:getData("activeDimensionName") then
        return
    end
    local playerId = client:getData("id")
    if not playerId then
        math.random(1, 500)
    end

    client.dimension = 1000 + playerId
    client:setData("activeDimensionName", name)

    triggerClientEvent(client, "bkEnter" .. name, client, ...)
end)

addEvent("bkExitPrivateDimension", true)
addEventHandler("bkExitPrivateDimension", resourceRoot, function (...)
    local activeDimensionName = client:getData("activeDimensionName")
    if not activeDimensionName then
        return
    end

    client.dimension = 0
    client:removeData("activeDimensionName")
    triggerClientEvent(client, "bkExit" .. activeDimensionName, client, ...)
end)    

addEventHandler("onResourceStart", resourceRoot, function ()
    for i, player in ipairs(getElementsByType("player")) do
        if player:getData("activeDimensionName") then
            player.dimension = 0
            player:removeData("activeDimensionName")
        end
    end
end)