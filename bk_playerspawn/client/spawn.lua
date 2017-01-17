addEventHandler("onClientPlayerSpawn", localPlayer, function ()
    exports["bk_hud"]:setVisible(true)
    setCameraTarget(localPlayer)
    fadeCamera(true)

    toggleAllControls(true, true)
end)

addEventHandler("onClientPlayerWasted", localPlayer, function ()
    fadeCamera(false, 2)
end)