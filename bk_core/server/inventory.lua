function getPlayerInventory(player)
    local account = getPlayerAccount(player)
    if not account then
        return false
    end

    local inventoryJSON = account:getData("inventory")
    if not inventoryJSON then
        return false
    end
    return fromJSON(inventoryJSON)
end

function setPlayerInventory(player, inventory)
    local account = getPlayerAccount(player)
    if not account then
        return false
    end

    if type(inventory) ~= "table" then
        return false
    end

    local inventoryJSON = toJSON(inventory)
    if not inventoryJSON then
        return false
    end

    return account:setData("inventory", inventoryJSON)
end

function addPlayerInventoryItem(player, vehicleName, componentName, componentId)
    local inventory = getPlayerInventory(player)
    if not inventory then
        return false
    end
    local item = {
        vehicleName   = vehicleName, 
        componentName = componentName, 
        componentId   = componentId
    }
    table.insert(inventory, item)
    return setPlayerInventory(player, inventory)
end