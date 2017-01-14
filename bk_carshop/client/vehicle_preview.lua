local vehicle

function startVehiclePreview(x, y, z)
    vehicle = createVehicle(411, x, y, z)
    vehicle.dimension = localPlayer.dimension
end

function stopVehiclePreview()
    if isElement(vehicle) then
        destroyElement(vehicle)
    end
end