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
end

function exitCarshop()
    if localPlayer:getData("activeDimensionName") ~= "Carshop" then
        return false
    end
    isActive = false

    fadeCamera(false)
    localPlayer.frozen = false
    setTimer(function ()
        exports["bk_dimensions"]:exitPrivateDimension()
    end, 1000, 1)
end

bindKey("backspace", "down", exitCarshop)