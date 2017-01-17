local shopMarkers = {
    {994.3, -1296.5, 12.5 }
}

addEventHandler("onClientResourceStart", resourceRoot, function ()
    for i, position in ipairs(shopMarkers) do
        local x, y, z = unpack(position)
        local blip = createBlip(x, y, z, 51)
        blip.visibleDistance = 250
        local marker = createMarker(x, y, z, "cylinder", 2, 255, 0, 0)

        addEventHandler("onClientMarkerHit", marker, function (player)
            if player ~= localPlayer or localPlayer.vehicle then
                return
            end
            setPanelVisible(true)
        end)        
    end
end)

function exitShop()
    setPanelVisible(false)
end