local isActive = false
local currentCarshop = nil

addEvent("bkEnterCarshop", true)
addEventHandler("bkEnterCarshop", localPlayer, function ()
    local vx, vy, vz = unpack(currentCarshop.vehiclePosition)
    startVehiclePreview(vx, vy, vz)

    local cx, cy, cz = unpack(currentCarshop.cameraPosition)
    setCameraMatrix(cx, cy, cz, vx, vy, vz - 0.5)
    exports["bk_hud"]:setVisible(false)

    toggleAllControls(false, true)
    localPlayer.frozen = true

    fadeCamera(true)
    setPanelVisible(true)
end)

addEvent("bkExitCarshop", true)
addEventHandler("bkExitCarshop", localPlayer, function ()
    stopVehiclePreview()
    currentCarshop = nil
    exports["bk_hud"]:setVisible(true)
    setCameraTarget(localPlayer)

    toggleAllControls(true, true)
    fadeCamera(true)
end)

function enterCarshop(carshop)
    if localPlayer:getData("activeDimensionName") then
        return false
    end
    isActive = true
    currentCarshop = carshop
    fadeCamera(false)
    setTimer(function ()
        exports["bk_dimensions"]:enterPrivateDimension("Carshop")
    end, 1000, 1)

    bindKey("backspace", "down", exitCarshop)
    bindKey("enter", "down", buyVehicle)
end

function exitCarshop()
    if localPlayer:getData("activeDimensionName") ~= "Carshop" then
        return false
    end
    isActive = false

    setPanelVisible(false)
    fadeCamera(false)
    localPlayer.frozen = false
    setTimer(function ()
        exports["bk_dimensions"]:exitPrivateDimension()
    end, 1000, 1)

    unbindKey("backspace", "down", exitCarshop)
    unbindKey("enter", "down", buyVehicle)
end

function buyVehicle()
    local info = getSelectedVehicleInfo()
    if info.price < localPlayer:getData("money") then
        return false
    end
    triggerServerEvent("bkCarshopBuyVehicle", resourceRoot, info, currentCarshop)
end

addEvent("bkCarshopBuyVehicle", true)
addEventHandler("bkCarshopBuyVehicle", resourceRoot, function (success, errorType)
    if success then
        exitCarshop()
    else
        outputDebugString("Buy error: " .. tostring(errorType))
    end
end)