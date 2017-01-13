function checkAccount(account)
    if not account then
        return false
    end
    if account.guest then
        return false
    end
    return true
end