local screenSize = Vector2(guiGetScreenSize())

local SPEEDO_SIZE = 300
local SPEEDO_OFFSET_X = 20
local SPEEDO_OFFSET_Y = 0

local barOffsetX = 116 / 340 * SPEEDO_SIZE
local barOffsetY = 102 / 340 * SPEEDO_SIZE
local barWidth = 107 / 340 * SPEEDO_SIZE
local barHeight = 32 / 340 * SPEEDO_SIZE

local textures = {}

local function getVehicleSpeed()
    if localPlayer.vehicle then
        local vx, vy, vz = getElementVelocity(localPlayer.vehicle)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161
    end
    return 0
end

local function draw()
    if not exports["bk_hud"]:isVisible() or not localPlayer.vehicle then
        return 
    end

    local x = screenSize.x - SPEEDO_OFFSET_X - SPEEDO_SIZE
    local y = screenSize.y - SPEEDO_OFFSET_Y - SPEEDO_SIZE
    dxDrawImage(x, y, SPEEDO_SIZE, SPEEDO_SIZE, textures.disc)

    local speed = getVehicleSpeed()
    dxDrawImage(x, y, SPEEDO_SIZE, SPEEDO_SIZE, textures.needle, speed, 0, 0)
    dxDrawText(
        tostring(math.floor(speed * 1.4)) .. " км/ч", 
        x + barOffsetX, 
        y + barOffsetY, 
        x + barOffsetX + barWidth, 
        y + barOffsetY + barHeight, 
        tocolor(255, 255, 255), 
        1.2, 
        "default", 
        "center", 
        "center")
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    textures.disc = dxCreateTexture("assets/disc.png")
    textures.needle = dxCreateTexture("assets/needle.png")
    addEventHandler("onClientRender", root, draw)
end)