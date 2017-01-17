local vehiclePrices = {
    vaz_2101 = 15000,
    vaz_2102 = 17500,
    vaz_2103 = 22000,
    vaz_2104 = 24000,
    vaz_2105 = 27000,
    vaz_2106 = 27000,
    vaz_2107 = 30000
}

local vehicleRealNames = {
    vaz_2101 = "ВАЗ-2101",
    vaz_2102 = "ВАЗ-2102",
    vaz_2103 = "ВАЗ-2103",
    vaz_2104 = "ВАЗ-2104",
    vaz_2105 = "ВАЗ-2105",
    vaz_2106 = "ВАЗ-2106",
    vaz_2107 = "ВАЗ-2107"
}

function getVehiclePrices()
    return vehiclePrices
end

function getVehiclePrice(name)
    if not name then
        return false
    end
    return vehiclePrices[name]
end

function getVehicleRealName(name)
    if not name then
        return false
    end    
    return vehicleRealNames[name]
end