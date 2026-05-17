-- QBCore Protected GlobalState Unlimited Stamina/Oxygen Toggle
-- author 'QBStevie'

local QBCore = exports['qb-core']:GetCoreObject()

local function HasPermission(src)
    if src == 0 then
        return true
    end

    for _, permission in ipairs(Config.AllowedPermissions) do
        if QBCore.Functions.HasPermission(src, permission) then
            return true
        end
    end

    return false
end

local function Notify(src, message, notifyType)
    notifyType = notifyType or 'primary'

    if src == 0 then
        print(('[nothing_stam] %s'):format(message))
        return
    end

    TriggerClientEvent('QBCore:Notify', src, message, notifyType)
end

local function LogUnauthorized(src)
    if not Config.LogUnauthorizedAttempts then return end

    local name = GetPlayerName(src) or 'Unknown'
    local license = 'Unknown'

    for _, identifier in ipairs(GetPlayerIdentifiers(src)) do
        if identifier:find('license:', 1, true) then
            license = identifier
            break
        end
    end

    print(('[nothing_stam] Unauthorized /%s attempt by %s [%s]'):format(
        Config.Command,
        name,
        license
    ))
end

local function SetStamState(state)
    -- Server owns this. Clients only read it.
    GlobalState[Config.StateKey] = state == true
end

local function GetStamState()
    return GlobalState[Config.StateKey] == true
end

RegisterCommand(Config.Command, function(source)
    if not HasPermission(source) then
        LogUnauthorized(source)
        Notify(source, 'You do not have permission to use this command.', 'error')
        return
    end

    local newState = not GetStamState()
    SetStamState(newState)

    local message = newState
        and 'Unlimited stamina and oxygen disabled for everyone.'
        or 'Unlimited stamina and oxygen enabled for everyone.'

    if Config.NotifyEveryone then
        TriggerClientEvent('QBCore:Notify', -1, message, newState and 'success' or 'error')
    else
        Notify(source, message, newState and 'success' or 'error')
    end

    print(('[nothing_stam] %s'):format(message))
end, false)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    Wait(1000)

    SetStamState(Config.EnabledByDefault)

    print(('[nothing_stam] Loaded protected GlobalState version. Current state: %s'):format(
        GetStamState() and 'enabled' or 'disabled'
    ))
end)
