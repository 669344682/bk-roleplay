-- Порядок запуска ресурсов
local bootResources = {
    "bk_shared",
    "bk_ui",
    
    "bk_core",
    "bk_dimensions",
    "bk_playerspawn",
    "bk_vehicles",
    "bk_tuning",
    "bk_carshop",
    "bk_partshop",
    "bk_driftpoints",
    "bk_garagetuning",
    "bk_garagedoors",
    "bk_safezones",

    "bk_hud",
    "bk_alert",
    "bk_loginpanel",
    "bk_spawnpanel",

    "bk_speedo"
}

local function processResourceByName(name, action)
    local resource = getResourceFromName(name)
    if not resource then
        return false
    end
    if action == "start" then
        startResource(resource)
        return resource.state == "running"
    elseif action == "stop" then
        return stopResource(resource)
    else
        error("Unknown action '" .. tostring(action) .. "'")
    end
end

function startResources()
    outputDebugString("Starting " .. tostring(#bootResources) .. " resource(s)...")
    -- Счётчик успешно запущенных ресурсов
    local counter = 0
    for i, name in ipairs(bootResources) do
        if processResourceByName(name, "start") then
            counter = counter + 1
        else
            outputDebugString("Boot: failed to start '" .. tostring(name) .. "'")
        end
    end
    local failedWarning = ""
    -- Если не все ресурсы удалось запустить
    if counter < #bootResources then
        failedWarning = "Failed to start " .. tostring(#bootResources - counter) .. " resource(s)."
    end
    outputDebugString("Done. " .. failedWarning)
end

function stopResources()
    outputDebugString("Stopping gamemode...")
    for i = #bootResources, 1, -1 do
        processResourceByName(bootResources[i], "stop")
    end
    outputDebugString("Done.")
end

addEventHandler("onResourceStart", resourceRoot, startResources)
addEventHandler("onResourceStop", resourceRoot, stopResources)