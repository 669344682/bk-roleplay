local panel = {}

local PANEL_WIDTH = 300
local PANEL_HEIGHT = 110

local UI = exports["bk_ui"]
local screenSize = Vector2(guiGetScreenSize())
local canvas = UI:createCanvas()

function setPanelVisible(visible)
    visible = not not visible
    if UI:isVisible(panel.window) == visible then
        return
    end
    UI:setVisible(panel.window, visible)
    showCursor(visible)
end

function updatePanel(data)
    UI:setText(panel.nameLabel, "Модель: " .. data.realName)
    UI:setText(panel.priceLabel, "Цена: " .. tostring(data.price) .. " руб.")
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    panel.window = UI:createWindow(screenSize.x / 2 - PANEL_WIDTH / 2, screenSize.y - PANEL_HEIGHT - 20, PANEL_WIDTH, PANEL_HEIGHT, canvas, "Автомагазин", true)
    local y = 10
    panel.nameLabel = UI:createLabel(10, y, PANEL_WIDTH - 20, 20, panel.window, "Название автомобиля")
    y = y + 25
    panel.priceLabel = UI:createLabel(10, y, PANEL_WIDTH - 20, 20, panel.window, "Цена")
    y = y + 35
    local buttonSpacing = 5
    local buttonWidth = (PANEL_WIDTH - 20) / 4 - buttonSpacing
    panel.prevButton = UI:createButton(12, y, buttonWidth, 35, panel.window, "<<")
    panel.buyButton = UI:createButton(12 + buttonWidth + buttonSpacing * 1, y, buttonWidth, 35, panel.window, "Купить")
    panel.cancelButton = UI:createButton(12 + buttonWidth * 2 + buttonSpacing * 2, y, buttonWidth, 35, panel.window, "Выход")
    panel.nextButton = UI:createButton(12 + buttonWidth * 3 + buttonSpacing * 3, y, buttonWidth, 35, panel.window, ">>")
    y = y + 35 + 10
    UI:setSize(panel.window, PANEL_WIDTH, y)
    UI:setVisible(panel.window, false)

    addEvent("onLuckyGUIClick")

    addEventHandler("onLuckyGUIClick", UI:getSource(panel.nextButton), function ()
        showNextVehicle()
    end)    

    addEventHandler("onLuckyGUIClick", UI:getSource(panel.prevButton), function ()
        showPrevVehicle()
    end)            
    addEventHandler("onLuckyGUIClick", UI:getSource(panel.buyButton), function ()
        buyVehicle()
    end)    

    addEventHandler("onLuckyGUIClick", UI:getSource(panel.cancelButton), function ()
        exitCarshop()
    end)       
end)