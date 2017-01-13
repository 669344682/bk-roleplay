local defaultVehicleData = {
    -- Основное
    Name            = nil, -- Название машины
    Mileage         = 0,   -- Пробег

    -- Цвета
    BodyColor       = {255, 255, 255}, -- Кузов
    SpoilerColor    = {255, 255, 255}, -- Спойлер
    GubaColor       = {255, 255, 255}, -- Губа

    -- Компоненты
    FrontBump       = 0, -- Передний бампер
    Guba            = 0, -- Губа
    RearBump        = 0, -- Задний бампер
    Seats           = 0, -- Сиденья
    Bonnets         = 0, -- Капот
    RearLights      = 0, -- Задние фары
    FrontLights     = 0, -- Передние фары
    FrontFends      = 0, -- Передние фендеры
    RearFends       = 0, -- Задние фендеры
    Acces           = 0, -- Аксессуары
    FrontWindow     = 0, -- Лобовое стекло
    FrontSticker    = 0, -- Лобовые наклейки
    RearSticker     = 0, -- Задние наклейки
    LeftSticker     = 0, -- Левые наклейки
    RightSticker    = 0, -- Правые наклейки
}

function getNewVehicleData(extendData)
    if not extendData then
        return false
    end
    -- Название должно быть обязательно указано
    if not extendData.Name then
        return false
    end

    local data = {}
    for name, defaultValue in pairs(defaultVehicleData) do
        data[name] = defaultValue
        if extendData[name] ~= nil then
            data[name] = extendData[name]
        end
    end
    return data
end