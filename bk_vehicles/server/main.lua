local vehicleTableCache = {}

-- Добавление автомобиля в аккаунт
function addVehicle(account, name)
    if not checkAccount(account) then
        return false, "not_logged_in"
    end
    local data = getNewVehicleData({name = name})
    if not data then
        return false, "bad_vehicle_data"
    end
    local vehicles = getAccountVehicles(account)
    local slots = tonumber(account:getData("slots"))
    outputDebugString("SLOTS: " .. tostring(slots) .. " " .. tostring(#vehicles)) 
    if not slots or #vehicles >= slots then
        return false, "no_slots"
    end
    local id = insertVehicleData(vehicles, data)
    if not id then
        return false, "failed_to_add"
    end
    if not setAccountVehicles(account, vehicles) then
        return false, "account_save_error"
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
    if not vehicles[id] then
        return false
    end
    if id == #vehicles then
        table.remove(vehicles, id)
        local i = id - 1
        while i >= 1 and not vehicles[i] do
            table.remove(vehicles, id)
        end
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
    error("Not implemented")
end

-- Все автомобили
function getAccountVehicles(account)
    if not checkAccount(account) then
        return false
    end
    if vehicleTableCache[account] then
        return vehicleTableCache[account]
    end
    local vehiclesJSON = account:getData("vehicles")
    if not vehiclesJSON then
        return {}
    end
    local vehiclesTable = fromJSON(vehiclesJSON)
    vehicleTableCache[account] = vehiclesTable
    if not vehiclesTable then
        return {}
    end
    return vehiclesTable
end

-- Один автомобиль
function getAccountVehicle(account, id)
    if not checkAccount(account) then
        return false
    end
    if type(id) ~= "number" then
        return false
    end
    local vehicles = getAccountVehicles(account)
    if not vehicles[id] then
        return false
    end
    return vehicles[id]
end

function setAccountVehicles(account, vehicles)
    if not checkAccount(account) then
        return false
    end
    if type(vehicles) ~= "table" then
        return false
    end
    local vehiclesJSON = toJSON(vehicles)
    if not vehiclesJSON then
        return false
    end
    if vehicleTableCache[account] then
        vehicleTableCache[account] = vehicles
    end    
    return account:setData("vehicles", vehiclesJSON)
end

function insertVehicleData(vehicles, data)
    if #vehicles > 0 then
        for i = 1, #vehicles do
            if not vehicles[i] then
                vehicles[i] = data
                return i
            end
        end
    end
    table.insert(vehicles, data)
    return #vehicles
end

addEventHandler("onPlayerLogout", root, function (account)
    vehicleTableCache[account] = nil 
end)