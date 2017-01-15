addEventHandler("onClientPlayerSpawn", localPlayer, function ()
    exports["bk_hud"]:setVisible(true)
    setCameraTarget(localPlayer)
    fadeCamera(true)

    toggleAllControls(true, true)
end)