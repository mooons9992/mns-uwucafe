fx_version 'cerulean'
game 'gta5'

name 'mns-uwucafe'
description 'UwU Cat Cafe Resource - QBCore Framework'
author 'Original by Mooons, Enhanced by User'
version '2.0.0'

lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'utils.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'functions.lua',
    'client.lua',
    'targets.lua',
}

dependencies {
    'qb-core',
    'PolyZone',
    'qb-management'
}

-- Define optional dependencies that might be used based on config
optional_dependencies {
    'qb-target',         -- Default target system
    'ox_target',         -- Alternative target system
    'qb-inventory',      -- Default inventory system
    'ox_inventory',      -- Alternative inventory system
    'ps-inventory',      -- Alternative inventory system
    'qb-menu',           -- Used for menus
    'qb-input',          -- Used for input dialogues
    'oxlib'              -- Alternative UI system
}

provides {
    'uwu_cafe'
}

-- Note about optional dependencies
dependency_notes [[
This resource supports multiple target, inventory, and UI systems:
- Target systems: qb-target (default), ox_target
- Inventory systems: qb-inventory (default), ps-inventory, ox_inventory
- UI systems: qb-menu, qb-input, ox_lib (partial support)

Configure your preferred systems in config.lua
]]

-- Files to ignore for encryption if using FiveM's Tebex/escrow
escrow_ignore {
    'config.lua',        -- Allow users to modify configuration
    'utils.lua',         -- Allow users to extend utility functions
    'functions.lua',     -- Allow users to modify functionality
    'README.md',
    'LICENSE.md'
}

-- Metadata for the resource store
fx_info {
    ui_page = false,
    requires_baseevents = false,
    requires_big_update = false,
    requires_license = false,
    requires_map = false,
    requires_map_anims = false,
    requires_map_vehicles = false,
    requires_natural_motion = false,
    requires_streamed_scripts = false,
    requires_txadmin = false,
    compatibility_version = "2.0.0",
}