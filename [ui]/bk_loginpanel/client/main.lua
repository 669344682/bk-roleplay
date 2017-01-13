local isVisible = false
local background = {}

local function drawBackground()
    dxDrawImage(0, 0, background.width, background.height, "assets/background.png")
end

function showPanel()
    if isVisible then
        return false
    end
    isVisible = true

    UI:setVisible(panels.login.window, true)
    exports["bk_hud"]:setVisible(false)
    showCursor(true)

    background.image = dxCreateTexture("assets/background.png")
    local tmpWidth, tmpHeight = dxGetMaterialSize(background.image)
    background.height = tmpHeight * screenSize.x / tmpWidth
    background.width = screenSize.x

    addEventHandler("onClientRender", root, drawBackground)
end

function hidePanel()
    if not isVisible then
        return false
    end
    isVisible = false

    UI:setVisible(panels.login.window, false)
    UI:setVisible(panels.register.window, false)
    showChat(true)
    showCursor(false)

    removeEventHandler("onClientRender", root, drawBackground)

    if isElement(background.image) then
        destroyElement(background.image)
    end
    background = {}
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    if not localPlayer:getData("username") then
        showPanel()
    end
end)

addEvent("bkLogin", true)
addEventHandler("bkLogin", localPlayer, function (success, errorType)
    if success then
        hidePanel()
        return
    end

    outputDebugString("ERROR: " .. tostring(errorType))
    if errorType then

    end
end)