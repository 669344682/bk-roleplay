function enterPrivateDimension(name)
    if localPlayer:getData("activeDimensionName") then
        return false
    end    
    return triggerServerEvent("bkEnterPrivateDimension", resourceRoot, name)
end

function exitPrivateDimension()
    if not localPlayer:getData("activeDimensionName") then
        return false
    end
    return triggerServerEvent("bkExitPrivateDimension", resourceRoot)
end