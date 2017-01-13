-- Добавление автомобиля в аккаунт
function addVehicle(account, name)
    if not checkAccount(account) then
        return false
    end

    local data = getNewVehicleData({Name = name})
    local vehicles = getAccountVehicles(account)
    local id = insertVehicleData(vehicles, data)
    if not setAccountVehicles(account, vehicles) then
        return false
    end
    return id, vehicles
end

-- Удаление автомобиля из аккаунта
function removeVehicle(account, id)
    if not checkAccount(account) then
        return false
    end
    if type(id) ~= "number" then
        return false
    end
    if id < 1 then
        return false
    end
    local vehicles = getAccountVehicles(account)
    if id > #vehicles then
        return false
    end
    if id == #vehicles then
        table.remove(vehicles, id)
    else
        vehicles[id] = false
    end
    return setAccountVehicles(account, vehicles)
end

-- Передача автомобиля на другой аккаунт
function transferVehicle(ownerAccount, id, targetAccount)
    if not checkAccount(ownerAccount) then
        return false
    end
    if not checkAccount(targetAccount) then
        return false
    end    
end

function getAccountVehicles(account)
    if not checkAccount(account) then
        return false
    end

    local vehiclesJSON = account:getData("vehicles")
    if not vehiclesJSON then
        return {}
    end
    local vehiclesTable = fromJSON(vehiclesJSON)
    if not vehiclesTable then
        return {}
    end
    return vehiclesTable
end

function setAccountVehicles(account, vehicles)
    if not checkAccount(account) then
        return false
    end
    if type(vehicles) ~= "table" then
        return false
    end
    local vehiclesJSON = toJSON(vehicles)
    if not vehiclesJSONle then
        return false
    end
    return account:setData("vehicles", vehiclesJSON)
end

function insertVehicleData(vehicles, data)
    for i = 1, #vehicles do
        if not vehicles[i] then
            vehicles[i] = data
            return i
        end
    end
    table.insert(vehicles, data)
    return #vehicles
end