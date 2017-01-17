local isHUDVisible = false

function setVisible(visible)
    setPlayerHudComponentVisible("all", false)

    setPlayerHudComponentVisible("radar", visible)
    setPlayerHudComponentVisible("money", visible)

    showChat(visible)

    isHUDVisible = visible
end

function isVisible()
    return not not isHUDVisible
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    setVisible(true)
end)