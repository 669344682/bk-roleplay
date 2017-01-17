local DOOR_OPEN_DISTANCE = 10

local garages = {
    [8] = {2072.40, -1831.38, 13.55},
    [10] = {1041.42, -1026.78, 32.10},
    [11] = {1025.09, -1030.52, 32.04},
}

addEventHandler("onClientResourceStart", resourceRoot, function ()
    for id, position in pairs(garages) do
        local x, y, z = unpack(position)
        local colshape = createColSphere(x, y, z, DOOR_OPEN_DISTANCE)
        colshape:setData("openGarageId", id)
    end    
end)

addEventHandler("onClientColShapeHit", resourceRoot, function (element)
    if element.type ~= "vehicle" then
        return
    end 
    local id = source:getData("openGarageId")
    if not id then
        return
    end
    setGarageOpen(id, true)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function (element)
    if element.type ~= "vehicle" then
        return
    end  
    local id = source:getData("openGarageId")
    if not id then
        return
    end    
    setGarageOpen(id, false)    
end)