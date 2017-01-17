local spawnPosition = Vector3(1755.174, -1894.117, 13)
local spawnAngle = -90

addEvent("bkPlayerLoggedIn")
addEventHandler("bkPlayerLoggedIn", root, function ()
    source:spawn(spawnPosition, spawnAngle)
end)

addEventHandler("onPlayerWasted", root, function ()
    local player = source
    setTimer(function ()
        if isElement(player) then
            player:spawn(spawnPosition, spawnAngle)
        end
    end, 3000, 1)
end)