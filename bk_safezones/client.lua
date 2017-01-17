local safeZonesList = {
    -- Магазин обвесов
    {Vector2( { x = 1017.187, y = -1293.950} ), Vector2( { x = 969.035, y = -1310.823 })},
    -- Тюнинг гараж
    {Vector2( { x = 1066.266, y = -1067.708} ), Vector2( { x = 978.392, y = -1007.807 })},
    -- Автомагазин
    {Vector2( { x = 2140.910, y = -1161.726} ), Vector2( { x = 2112.749, y = -1121.841 })},
    -- Спавн
    {Vector2( { x = 1810.794, y = -1881.103} ), Vector2( { x = 1742.388, y = -1942.416 })},
}

function createSafeZone(pos1, pos2)
    local rectMin = Vector2(0, 0)
    rectMin.x = math.min(pos1.x, pos2.x)
    rectMin.y = math.min(pos1.y, pos2.y)
    local rectMax = Vector2(0, 0)
    rectMax.x = math.max(pos1.x, pos2.x)
    rectMax.y = math.max(pos1.y, pos2.y)
    local size = rectMax - rectMin
    local colShape = ColShape.Rectangle(rectMin, size)
    colShape:setData("dpSafeZone", true)
    return colShape
end

for _, zone in ipairs(safeZonesList) do
    createSafeZone(unpack(zone))
end

local function handleColShapeHit(colshape, element, matchingDimension)
    if not matchingDimension or not colshape:getData("dpSafeZone") then
        return
    end
    if not isElement(element) then
        return
    end
    if element == localPlayer then
        setCameraClip(true, false)
    end
    if element.type == "player" or element.type == "vehicle" then
        for i, e in ipairs(colshape:getElementsWithin("player")) do
            if isElement(e) then
                element:setCollidableWith(e, false)
            end
        end
        for i, e in ipairs(colshape:getElementsWithin("vehicle")) do
            if isElement(e) then
                element:setCollidableWith(e, false)
            end
        end
    end
end

local function handleColShapeOut(colshape, element, matchingDimension)
    if not matchingDimension or not colshape:getData("dpSafeZone") then
        return
    end
    if element == localPlayer then
        setCameraClip(true, true)
    end
    if not isElement(element) then
        return
    end
    local elementType = getElementType(element)
    if elementType and elementType == "player" or elementType == "vehicle" then
        for i, e in ipairs(colshape:getElementsWithin("player")) do
            element:setCollidableWith(e, true)
        end
        for i, e in ipairs(colshape:getElementsWithin("vehicle")) do
            element:setCollidableWith(e, true)
        end
    end
end

addEventHandler("onClientColShapeLeave", resourceRoot, function (element, matchingDimension)
    handleColShapeOut(source, element, matchingDimension)
end)

addEventHandler("onClientColShapeHit", resourceRoot, function (element, matchingDimension)
    handleColShapeHit(source, element, matchingDimension)
end)

function leaveSafeZones()
    for _, colshape in ipairs(getElementsByType("colshape")) do
        for _, element in ipairs(colshape:getElementsWithin()) do
            handleColShapeOut(colshape, element, true)
        end
    end
end

for _, colshape in ipairs(getElementsByType("colshape")) do
    for _, element in ipairs(colshape:getElementsWithin()) do
        handleColShapeHit(colshape, element, element.dimension == colshape.dimension)
    end
end
