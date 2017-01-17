local garageMarkers = {
    {1025.09, -1030.52, 32.04}
}

addEventHandler("onClientResourceStart", resourceRoot, function ()
    for i, position in ipairs(garageMarkers) do
        local x, y, z = unpack(position)
        local blip = createBlip(x, y, z, 27)
        blip.visibleDistance = 250
    end
end)