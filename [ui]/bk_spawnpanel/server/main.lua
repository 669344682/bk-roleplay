addEvent("bkSpawnPanelFetchData", true)
addEventHandler("bkSpawnPanelFetchData", resourceRoot, function ()
    triggerClientEvent(
        client, 
        "bkSpawnPanelData", 
        resourceRoot, 
        exports.bk_vehicles:getAccountVehicles(client.account))
end)

addEvent("bkSpawnVehicle", true)
addEventHandler("bkSpawnVehicle", resourceRoot, function (id)
    local position = client.position
    local rotation = client.rotation
    if client.vehicle then
        position = client.vehicle.position
        rotation = client.vehicle.rotation
    end
    client.vehicle = nil
    local vehicle = exports.bk_vehicles:spawnVehicle(client.account, id, position, rotation)
    client.vehicle = vehicle
end)