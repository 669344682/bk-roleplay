panel = {}

local PANEL_WIDTH = 200
local PANEL_HEIGHT = 300

local UI = exports["bk_ui"]
local screenSize = Vector2(guiGetScreenSize())
local canvas = UI:createCanvas()

local buttons = {}
local vehiclesList = {}

local updateUnlockTimer
local updateLocked = false

addEvent("onLuckyGUIClick")
addEventHandler("onLuckyGUIClick", root, function ()
    local vehicleId = source:getData("spawnVehicleId")
    if not vehicleId then
        return false
    end
    triggerServerEvent("bkSpawnVehicle", resourceRoot, vehicleId)
    setVisible(false)
end)

local function updateButtons(vehicles)
    local slotsCount = localPlayer:getData("slots")
    if not slotsCount then
        setVisible(false)
        return
    end
    vehiclesList = vehicles
    local y = 10
    for i = 1, slotsCount do
        local button = buttons[i]
        if not button then
            buttons[i] = UI:createButton(10, y, PANEL_WIDTH - 20, 35, panel.window, "")
            button = buttons[i]
        end
        UI:getSource(button):setData("spawnVehicleId", i)  
        if vehicles[i] then
            UI:setText(button, vehicles[i].name)
            UI:setEnabled(button, true)
        else
            UI:setText(button, "Пустой слот")
            UI:setEnabled(button, false)
        end
        y = y + 34
    end
    y = y + 10
    UI:setPosition(panel.buySlot, 40, y)
    y = y + 45
    UI:setSize(panel.window, PANEL_WIDTH, y)
    UI:setPosition(panel.window, screenSize.x - PANEL_WIDTH - 10, screenSize.y - y - 20)    
end

addEvent("bkSpawnPanelData", true)
addEventHandler("bkSpawnPanelData", resourceRoot, updateButtons)

function setVisible(visible)
    visible = not not visible
    if UI:isVisible(panel.window) == visible then
        return
    end
    UI:setVisible(panel.window, visible)
    showCursor(visible)
    if visible and not updateLocked then
        updateUnlockTimer = setTimer(function () updateLocked = false end, 10000, 1)
        updateLocked = true
        triggerServerEvent("bkSpawnPanelFetchData", resourceRoot)
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    panel.window = UI:createWindow(-1000, 0, 0, 0, canvas, "Мои автомобили", true)
    panel.buySlot = UI:createButton(40, 40, PANEL_WIDTH - 80, 35, panel.window, "Купить слот")
    UI:setVisible(panel.window, false)
end)

bindKey("F1", "down", function ()
    setVisible(not UI:isVisible(panel.window))
end)