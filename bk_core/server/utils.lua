function getPlayerAccount(player)
    if not isElement(player) then
        return false
    end
    if not player.account then
        return false
    end
    if not player.account.guest then
        return false
    end
    return player.account
end