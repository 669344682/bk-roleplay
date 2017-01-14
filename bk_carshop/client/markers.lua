local function createCarshopMarker(carshop)
    local x, y, z = unpack(carshop.markerPosition)
    local marker = createMarker(x, y, z, "cylinder", 2, 255, 0, 0)
    local blip = createBlip(x, y, z, 55)
    blip.visibleDistance = 250

    addEventHandler("onClientMarkerHit", marker, function ()
        enterCarshop(carshop)
    end)
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    for i, carshop in ipairs(CarshopsList) do
        createCarshopMarker(carshop)
    end
end)