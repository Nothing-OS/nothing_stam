-- QBCore Client-side Unlimited Oxygen + Stamina using protected GlobalState
-- author 'QBStevie'

local unlimitedStam = false
local stamThreadRunning = false

local function StartStamThread()
    if stamThreadRunning then return end

    stamThreadRunning = true

    CreateThread(function()
        while unlimitedStam do
            local sleep = 1000

            local player = PlayerId()
            local ped = PlayerPedId()

            if DoesEntityExist(ped) and not IsEntityDead(ped) then
                -- Oxygen / underwater breath
                SetPedMaxTimeUnderwater(ped, 50.0)
                SetPlayerUnderwaterTimeRemaining(player, 50.0)

                -- Stamina only gets restored when it is being used
                if IsPedRunning(ped)
                    or IsPedSprinting(ped)
                    or IsPedSwimming(ped)
                    or IsPedSwimmingUnderWater(ped)
                then
                    RestorePlayerStamina(player, 1.0)
                    sleep = 0
                end
            end

            Wait(sleep)
        end

        stamThreadRunning = false
    end)
end

local function ApplyCurrentGlobalState()
    -- Do not trust event payloads. Always read the real GlobalState value.
    unlimitedStam = GlobalState[Config.StateKey] == true

    if unlimitedStam then
        StartStamThread()
    end
end

CreateThread(function()
    Wait(1500)
    ApplyCurrentGlobalState()
end)

AddStateBagChangeHandler(Config.StateKey, nil, function()
    ApplyCurrentGlobalState()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1500)
    ApplyCurrentGlobalState()
end)
