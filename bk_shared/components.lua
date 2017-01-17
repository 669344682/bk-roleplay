local components = {
    -- Спойлеры
    spoiler_vfts = {
        data     = "Spoilers",
        price    = 0,
        name     = "Спойлер VFTS",
        vehicles = {
            vaz_2101 = 2,
            vaz_2102 = nil,
            vaz_2103 = nil,
            vaz_2104 = nil,
            vaz_2105 = 2,
            vaz_2106 = 2,
            vaz_2107 = 2,
        }
    },
    spoiler_avr = {
        data     = "Spoilers",
        price    = 0,
        name     = "Спойлер AVR",
        vehicles = {
            vaz_2101 = 3,
            vaz_2102 = 1,
            vaz_2103 = 2,
            vaz_2104 = 1,
            vaz_2105 = 3,
            vaz_2106 = 3,
            vaz_2107 = 3,
        }
    },
    spoiler_sniper = {
        data     = "Spoilers",
        price    = 0,
        name     = "Спойлер \"Снайпер\"",
        vehicles = {
            vaz_2101 = 1,
            vaz_2102 = nil,
            vaz_2103 = 1,
            vaz_2104 = nil,
            vaz_2105 = 1,
            vaz_2106 = 1,
            vaz_2107 = 1,
        }
    },    

    -- Губа
    guba_vihur = {
        data     = "Guba",
        price    = 0,
        name     = "Губа \"Вихур\"",
        vehicles = {
            vaz_2101 = 1,
            vaz_2102 = 1,
            vaz_2103 = nil,
            vaz_2104 = 1,
            vaz_2105 = 1,
            vaz_2106 = 1,
            vaz_2107 = 1,
        }
    },
    guba_vfts = {
        data     = "Guba",
        price    = 0,
        name     = "Губа VFTS",
        vehicles = {
            vaz_2101 = nil,
            vaz_2102 = nil,
            vaz_2103 = nil,
            vaz_2104 = 2,
            vaz_2105 = 2,
            vaz_2106 = nil,
            vaz_2107 = 2,         
        }
    },

    -- Решетка на заднее стекло
    reshetka = {
        data     = "RearSticker",
        price    = 0,
        name     = "Решетка на заднее стекло",
        vehicles = {
            vaz_2101 = 1,
            vaz_2102 = 1,
            vaz_2103 = 1,
            vaz_2104 = 1,
            vaz_2105 = 1,
            vaz_2106 = 1,
            vaz_2107 = 1,         
        }
    },

    -- Фендеры
    fender_rear_vfts = {
        data     = "RearFends",
        price    = 0,
        name     = "Задний фендер VFTS",
        vehicles = {
            vaz_2101 = nil,
            vaz_2102 = nil,
            vaz_2103 = nil,
            vaz_2104 = 2,
            vaz_2105 = 2,
            vaz_2106 = nil,
            vaz_2107 = 2,
        }
    },
    fender_front_vfts = {
        data     = "FrontFends",
        price    = 0,
        name     = "Передний фендер VFTS",
        vehicles = {
            vaz_2101 = nil,
            vaz_2102 = nil,
            vaz_2103 = nil,
            vaz_2104 = 2,
            vaz_2105 = 2,
            vaz_2106 = nil,
            vaz_2107 = 2,
        }
    },
    fender_rear_plastic = {
        data     = "RearFends",
        price    = 0,
        name     = "Пластиковый задний фендер",
        vehicles = {
            vaz_2101 = 1,
            vaz_2102 = 1,
            vaz_2103 = 2,
            vaz_2104 = 1,
            vaz_2105 = 1,
            vaz_2106 = 2,
            vaz_2107 = 1,
        }
    }, 
    fender_front_plastic = {
        data     = "FrontFends",
        price    = 0,
        name     = "Пластиковый передний фендер",
        vehicles = {
            vaz_2101 = 1,
            vaz_2102 = 1,
            vaz_2103 = 2,
            vaz_2104 = 1,
            vaz_2105 = 1,
            vaz_2106 = 2,
            vaz_2107 = 1,
        }
    },       
}

function getComponentsList()
    return components
end

function getVehicleComponents(name)
    local result = {}
    for componentName, data in pairs(components) do
        for vehicleName, id in pairs(data.vehicles) do
            if vehicleName == name then
                local newData = {}
                for k, v in pairs(data) do
                    newData[k] = v
                end
                newData.vehicles = nil
                newData.name = componentName
                table.insert(result, newData)
            end
        end
    end
    return result
end