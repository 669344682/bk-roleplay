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

    local vehicle = createVehicle(model, position, rotation)
    -- TODO: Set data
    return vehicle
end