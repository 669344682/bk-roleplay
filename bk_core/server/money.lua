function givePlayerMoney(player, amount)
    if not isElement(player) then
        return false
    end
    if type(amount) ~= "number" then
        return false
    end

    local money = player:getData("money")
    if type(money) ~= "number" then
        return false
    end

    player:setData("money", money + amount)
    return true
end

function takePlayerMoney(player, amount)
    if not isElement(player) then
        return false, "no_player"
    end
    if type(amount) ~= "number" then
        return false, "bad_amount"
    end

    local money = player:getData("money")
    if type(money) ~= "number" then
        return false, "not_logged_in"
    end
    if money < amount then
        return false, "not_enough_money"
    end
    
    player:setData("money", money - amount)
    return true
end