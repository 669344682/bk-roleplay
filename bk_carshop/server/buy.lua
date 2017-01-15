addEvent("bkCarshopBuyVehicle", true)
addEventHandler("bkCarshopBuyVehicle", resourceRoot, function (info, carshop)
    if not info then
        triggerClientEvent(client, "bkCarshopBuyVehicle", resourceRoot, false, "no_info")
        return
    end
    -- Проверить деньги
    local money = client:getData("money")
    if not money or info.price > money then
        triggerClientEvent(client, "bkCarshopBuyVehicle", resourceRoot, false, "no_money")
        return
    end
    -- Снять деньги
    local success, errorType = exports["bk_core"]:takePlayerMoney(client, info.price)
    if not success then
        triggerClientEvent(client, "bkCarshopBuyVehicle", resourceRoot, false, errorType)
        return 
    end
    local vehicleId, errorType = exports["bk_vehicles"]:addVehicle(client.account, info.name)
    if not vehicleId then
        triggerClientEvent(client, "bkCarshopBuyVehicle", resourceRoot, false, errorType)
        return
    end
    -- Заспавнить автомобиль и посадить в него игрока
    if not carshop then
        carshop = {}
    end
    local vehiclePosition = Vector3()
    if carshop.vehiclePosition then
        vehiclePosition = Vector3(unpack(carshop.vehiclePosition))
    end
    local vehicleRotation = Vector3()
    if carshop.vehicleRotation then
        vehicleRotation = Vector3(unpack(carshop.vehicleRotation))
    end
    local vehicle, errorType = exports["bk_vehicles"]:spawnVehicle(client.account, vehicleId, vehiclePosition, vehicleRotation)
    if vehicle then
        client.vehicle = vehicle
        vehicle.dimension = 0
    end
    triggerClientEvent(client, "bkCarshopBuyVehicle", resourceRoot, true)
end)