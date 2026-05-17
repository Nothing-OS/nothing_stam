Config = {}

-- Command: /stam
Config.Command = 'stam'

-- Enabled automatically when the resource starts
Config.EnabledByDefault = true

-- QBCore permissions allowed to toggle it
Config.AllowedPermissions = {
    'god',
    'admin'
}

-- GlobalState key used by state bags
Config.StateKey = 'NothingStamEnabled'

-- Notify everyone when toggled
Config.NotifyEveryone = true

-- Log failed toggle attempts
Config.LogUnauthorizedAttempts = true
