local PANEL_WIDTH = 300
local PANEL_HEIGHT = 200

addEventHandler("onClientResourceStart", resourceRoot, function ()
    local panel = {}

    panel.window = UI:createWindow(
        (screenSize.x - PANEL_WIDTH)  / 2,
        (screenSize.y - PANEL_HEIGHT + 150) / 2,
        PANEL_WIDTH, 
        PANEL_HEIGHT,
        canvas,
        "Вход на сервер",
        true
    )

    local y = 10
    -- Логин
    UI:createLabel(10, y, PANEL_WIDTH, 20, panel.window, "Логин")
    y = y + 25
    panel.loginEdit = UI:createEdit(10, y, PANEL_WIDTH - 20, 35, panel.window, "")

    -- Пароль
    y = y + 45
    UI:createLabel(10, y, PANEL_WIDTH, 20, panel.window, "Пароль")
    y = y + 25
    panel.passwordEdit = UI:createEdit(10, y, PANEL_WIDTH - 20, 35, panel.window, "")
    UI:setEditMasked(panel.passwordEdit, true)

    -- Кнопка "Войти"
    y = y + 50
    local buttonSpacing = 7
    local buttonWidth = (PANEL_WIDTH - 20) / 2 - buttonSpacing
    UI:createButton(10, y, buttonWidth, 35, panel.window, "Войти")
    panel.registerButton = UI:createButton(10 + buttonWidth + buttonSpacing * 2, y, buttonWidth, 35, panel.window, "Регистрация")

    UI:setVisible(panel.window, false)
    if not panels then 
        panels = {} 
    end
    panels.login = panel

    addEvent("onLuckyGUIClick")
    addEventHandler("onLuckyGUIClick", UI:getSource(panel.registerButton), function ()
        UI:setVisible(panels.login.window, false)
        UI:setVisible(panels.register.window, true)
    end)
end)