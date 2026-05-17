# nothing_stam

QBCore server-wide unlimited stamina and oxygen toggle using FiveM GlobalState/state bags.

Licensed under QCSL-1.0
https://github.com/Nothing-OS
## Features

- Enabled by default
- Server-wide toggle
- QBCore admin/god permission check
- No client-to-server toggle event
- Uses GlobalState for clean sync
- Client stamina/oxygen thread only runs while enabled

## Install

1. Drop `nothing_stam` into your resources folder.
2. Add this after `qb-core` in `server.cfg`:

```cfg
ensure qb-core
ensure nothing_stam
```

## Command

```text
/stam
```

The command toggles unlimited stamina and oxygen for everyone.

## Config

Edit `init.lua`:

```lua
Config.Command = 'stam'
Config.EnabledByDefault = true
Config.AllowedPermissions = {
    'god',
    'admin'
}
```

## Notes

Cheaters cannot use this resource to toggle the server-wide state because there is no client-to-server toggle event. The server owns the GlobalState value, and clients only read it.
