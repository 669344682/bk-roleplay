local accountDataToLoad = {
    money = 0,
    xp    = 1,
}

local accountDataToSave = {
    "money"
}

function loadAccountData(player, account)
    if not account then
        account = player.account
    end
    if not account or account.guest then
        return false
    end

    player:setData("username", account.name)

    -- Загрузка даты
    for name, defaultValue in pairs(accountDataToLoad) do
        local value = account:getData(name)
        if value == nil then
            value = defaultValue
        end
        player:setData(name, value)
    end
end

function saveAccountData(player, account)
    if not account then
        account = player.account
    end
    if not account or account.guest then
        return false
    end    

    player:removeData("username")

    -- Сохранение даты
    for i, name in ipairs(accountDataToSave) do
        local value = player:getData(name)
        account:setData(name, value)
        player:removeData(name)
    end
end

-- Вход в аккаунт
addEvent("bkLogin", true)
addEventHandler("bkLogin", root, function (username, password)
    if type(username) ~= "string" then
        triggerClientEvent("bkLogin", client, false, "invalid_username")
        return
    end
    if type(password) ~= "string" then
        triggerClientEvent("bkLogin", client, false, "invalid_password")
        return
    end
    if not Account(username) then
        triggerClientEvent("bkLogin", client, false, "not_exists")
        return
    end 
    local account = Account(username, password)
    if not account then
        triggerClientEvent("bkLogin", client, false, "wrong_password")
        return
    end
    if not client:logIn(account, password) then
        triggerClientEvent("bkLogin", client, false, "account_in_use")
        return
    end
    -- Дальше управление передаётся в эвент onPlayerLogin
end)

-- Регистрация
addEvent("bkRegister", true)
addEventHandler("bkRegister", root, function (username, password)
    -- TODO

    triggerClientEvent("bkRegister", client, false)
end)

addEventHandler("onPlayerLogout", root, function (account)
    saveAccountData(source, account)
    source:fadeCamera(false)
end)

addEventHandler("onPlayerLogin", root, function (_, account)
    loadAccountData(source)
    triggerClientEvent("bkLogin", source, true)
    triggerEvent("bkPlayerLoggedIn", source)
end)

addEventHandler("onResourceStart", resourceRoot, function ()
    for i, player in ipairs(getElementsByType("player")) do
        player:logOut()
    end
end)