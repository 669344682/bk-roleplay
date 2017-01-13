local isVisible = false

function setVisible(visible)
    setPlayerHudComponentVisible("all", false)

    setPlayerHudComponentVisible("radar", visible)
    setPlayerHudComponentVisible("money", visible)

    showChat(visible)

    isVisible = visible
end

function isVisible()
    return isVisible
end