local vehiclesList = {
    vaz_2101 = 445,
    vaz_2104 = 546
}

function getVehiclesList()
    return vehiclesList
end

function getModelFromName(name)
    if not name then
        return false
    end
    return vehiclesList[name]
end

function getNameFromModel(model)
    if type(model) ~= "number" then
        return false
    end
    for name, m in ipairs(vehiclesList) do
        if model == m then
            return name
        end 
    end
    return false
end