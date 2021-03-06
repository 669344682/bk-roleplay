local vehicle
local vehiclesList = {}
local selectedVehicle = 1

local function updateVehicle()
    if not isElement(vehicle) then
        return
    end

    local info = getSelectedVehicleInfo()
    vehicle.model = info.model
    vehicle:setColor(255, 255, 255) 
    updatePanel(info)
end

function showNextVehicle()
    selectedVehicle = selectedVehicle + 1
    if selectedVehicle > #vehiclesList then
        selectedVehicle = 1
    end

    updateVehicle()
end

function showPrevVehicle()
    selectedVehicle = selectedVehicle - 1
    if selectedVehicle < 1 then
        selectedVehicle = #vehiclesList
    end

    updateVehicle()
end

function getSelectedVehicleInfo()
    return vehiclesList[selectedVehicle]
end

function startVehiclePreview(x, y, z)
    vehicle = createVehicle(411, x, y, z)
    vehicle.dimension = localPlayer.dimension

    for name, model in pairs(exports["bk_vehicles"]:getVehiclesList()) do
        local price = exports.bk_shared:getVehiclePrice(name) or 0
        local realName = exports.bk_shared:getVehicleRealName(name) or ""
        table.insert(vehiclesList, { 
            price = price, 
            level = 1,
            realName = realName,
            name = name,
            model = model 
        })
    end

    selectedVehicle = 1
    updateVehicle()

    bindKey("arrow_r", "down", showNextVehicle)
    bindKey("arrow_l", "down", showPrevVehicle)

    addEventHandler("onClientElementStreamIn", vehicle, updateVehicle)
end

function stopVehiclePreview()
    if isElement(vehicle) then
        destroyElement(vehicle)
    end

    unbindKey("arrow_r", "down", showNextVehicle)
    unbindKey("arrow_l", "down", showPrevVehicle)    
end