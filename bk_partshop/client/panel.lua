panel = {}

local sectionsWindowWidth = 350
local sectionsWindowHeight = 60

local listWindowWidth = 350
local listWindowHeight = 450

local items = {}
local selectedItem = 1
local textures = {}

local sections = {
    wheels = "Диски",
    components = "Обвесы",
    other = "Другое"
}

function loadSection(name)
    items = {}

    if name == "components" then
        local components = exports.bk_shared:getComponentsList()
        for name, component in pairs(components) do
            local item = {
                realName = component.name,
                price = component.price,
                name = name
            }
            table.insert(items, item)
        end
    end
end

function updateItem()
    local item = items[selectedItem]

    UI:setText(panel.nameLabel, "Название: " .. tostring(item.realName))
    UI:setText(panel.priceLabel, "Цена: " .. tostring(item.price) .. " руб.")

    local texture = textures[item.name]
    if not texture then
        textures[item.name] = dxCreateTexture("assets/images/" .. tostring(item.name) .. ".png")
        texture = textures[item.name]
    end
    UI:setImageTexture(panel.image, texture)
end

function setPanelVisible(visible)
    visible = not not visible
    if UI:isVisible(panel.sectionsWindow) == visible then
        return
    end
    UI:setVisible(panel.sectionsWindow, visible)
    UI:setVisible(panel.listWindow, visible)
    showCursor(visible)
end 

addEventHandler("onClientResourceStart", resourceRoot, function ()
    local windowY = screenSize.y / 2 - (sectionsWindowHeight + listWindowHeight) / 2
    panel.sectionsWindow = UI:createWindow(screenSize.x / 2 - sectionsWindowWidth / 2, windowY, sectionsWindowWidth, sectionsWindowHeight, canvas, "Магазин", true)

    local x = 10
    local y = 5
    local buttonWidth = (sectionsWindowWidth - 20) / 3
    local buttonHeight = 50

    for name, text in pairs(sections) do
        local button = UI:createButton(x, y, buttonWidth, buttonHeight, panel.sectionsWindow, text)
        x = x + buttonWidth
    end

    windowY = windowY + sectionsWindowHeight + 5
    panel.listWindow = UI:createWindow(screenSize.x / 2 - listWindowWidth / 2, windowY, listWindowWidth, listWindowHeight, canvas, "Магазин", false)

    x = 10
    y = 10
    local imageSize = listWindowWidth - 20
    panel.image = UI:createImage(x, y, imageSize, imageSize, panel.listWindow)

    y = listWindowHeight - 50
    buttonWidth = (sectionsWindowWidth - 20) / 4
    buttonHeight = 40
    panel.prevButton = UI:createButton(x, y, buttonWidth, buttonHeight, panel.listWindow, "<<")
    x = x + buttonWidth
    UI:createButton(x, y, buttonWidth, buttonHeight, panel.listWindow, "Купить")
    x = x + buttonWidth
    panel.exitButton = UI:createButton(x, y, buttonWidth, buttonHeight, panel.listWindow, "Выход")
    x = x + buttonWidth    
    panel.nextButton = UI:createButton(x, y, buttonWidth, buttonHeight, panel.listWindow, ">>")

    x = 10
    y = y - 55
    panel.nameLabel = UI:createLabel(x, y, listWindowWidth, 25, panel.listWindow, "Название")
    y = y + 25
    panel.priceLabel = UI:createLabel(x, y, listWindowWidth, 25, panel.listWindow, "Цена")

    loadSection("components")
    updateItem()

    addEvent("onLuckyGUIClick")
    addEventHandler("onLuckyGUIClick", UI:getSource(panel.nextButton), function ()
        selectedItem = selectedItem + 1
        if selectedItem > #items then
            selectedItem = 1
        end
        updateItem()
    end)    

    addEventHandler("onLuckyGUIClick", UI:getSource(panel.prevButton), function ()
        selectedItem = selectedItem - 1
        if selectedItem < 1 then
            selectedItem = #items
        end
        updateItem()
    end)      

    addEventHandler("onLuckyGUIClick", UI:getSource(panel.exitButton), function ()
        exitShop()
    end)                    

    UI:setVisible(panel.sectionsWindow, false)  
    UI:setVisible(panel.listWindow, false)  

    setPanelVisible(false)
end)