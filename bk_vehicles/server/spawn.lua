local spawnedVehicles = {}

function destroyPlayerVehicle(player)
    if isElement(player) and spawnedVehicles[player] then
        if isElement(spawnedVehicles[player]) then
            destroyElement(spawnedVehicles[player])
        end
        spawnedVehicles[player] = nil
        return true
    end
    return false
end

function getPlayerSpawnedVehicle(player)
    if not isElement(player) then
        return false
    end
    if not isElement(spawnedVehicles[player]) then
        spawnedVehicles[player] = nil
        return false
    end
    return spawnedVehicles[player]
end

-- Спавн автомобиля
function spawnVehicle(account, id, position, rotation)
    if not checkAccount(account) then
        return false, "not_logged_in"
    end
    if type(id) ~= "number" then
        return false, "invalid_id"
    end
    if not position then 
        position = Vector3()
    end
    if not rotation then
        rotation = Vector3()
    end

    local data = getAccountVehicle(account, id)
    if not data then
        return false, "no_vehicle"
    end
    local model = getModelFromName(data.name)  
    if not model then
        return false, "no_such_model"
    end  

    destroyPlayerVehicle(account.player)
    local vehicle = createVehicle(model, position, rotation)
    vehicle:setColor(255, 255, 255)
    if account.player then
        spawnedVehicles[account.player] = vehicle
        vehicle:setData("ownerPlayer", account.player)
    end
    vehicle:setData("id", id)
    vehicle:setData("owner", account.name)

    -- TODO: Set data
    return vehicle
end

addEventHandler("onPlayerQuit", root, function ()
    destroyPlayerVehicle(source)
end)

addEventHandler("onElementDestroy", resourceRoot, function ()
    if source.type ~= "vehicle" then
        return
    end
    local player = source:getData("ownerPlayer")
    if player then
        spawnedVehicles[player] = nil
    end
end)

addEventHandler("onVehicleExplode", resourceRoot, function ()
    destroyPlayerVehicle(source:getData("ownerPlayer"))
end)