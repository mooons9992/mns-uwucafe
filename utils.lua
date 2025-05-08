local QBCore = exports['qb-core']:GetCoreObject()

-- Make Utils a global object
Utils = {}

-- Check current inventory system
Utils.InventorySystem = Config.Inventory or 'qb-inventory'

-- Check current target system
Utils.TargetSystem = Config.Target or 'qb-target'

-- Check current UI/Menu system
Utils.UISystem = Config.UI or 'qb-menu'

-- Debug output function
Utils.Debug = function(message)
    if Config.Debug then
        print("^2UwU Cafe^7: " .. message)
    end
end

-- Inventory wrapper to handle different inventory systems
Utils.OpenInventory = function(name, slots, maxWeight)
    if Utils.InventorySystem == "qb-inventory" then
        TriggerEvent('inventory:client:SetCurrentStash', name)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
            maxweight = maxWeight or 250000,
            slots = slots or 40,
        })
    elseif Utils.InventorySystem == "ox_inventory" then
        -- Using ox_inventory's export directly
        exports.ox_inventory:openInventory('stash', {id = name})
    elseif Utils.InventorySystem == "ps-inventory" then
        -- ps-inventory uses similar events to qb-inventory
        TriggerEvent('inventory:client:SetCurrentStash', name)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', name)
    else
        -- Default to qb-inventory
        TriggerEvent('inventory:client:SetCurrentStash', name)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
            maxweight = maxWeight or 250000,
            slots = slots or 40,
        })
    end
end

-- Notification wrapper to handle different notification systems
Utils.Notify = function(src, text, notifyType, duration)
    if src == nil then return end
    
    notifyType = notifyType or 'primary' -- default notification type
    duration = duration or 5000 -- default duration
    
    TriggerClientEvent('QBCore:Notify', src, text, notifyType, duration)
end

-- Add BoxZone wrapper to handle different target systems
Utils.AddBoxZone = function(name, coords, length, width, options)
    -- Default to qb-target's direct export 
    exports['qb-target']:AddBoxZone(name, coords, length, width, options.data or {
        name = name,
        heading = options.heading or 0,
        debugPoly = options.debug or false, -- Use debugPoly instead of debug
        minZ = options.minZ,
        maxZ = options.maxZ,
    }, options.options, {
        distance = options.options.distance
    })
end

-- Add TargetModel wrapper to handle different target systems
Utils.AddTargetModel = function(model, options)
    -- Use direct qb-target export
    exports['qb-target']:AddTargetModel(model, options)
end

-- Progress bar wrapper to handle different progress systems
Utils.ProgressBar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
end

-- Create Job Blip helper function
Utils.CreateBlip = function(coords, sprite, display, scale, color, shortRange, name)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    return blip
end

-- Helper function for inventory checks
Utils.HasItem = function(src, item, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    amount = amount or 1
    local itemData = Player.Functions.GetItemByName(item)
    
    if itemData and itemData.amount >= amount then
        return true
    end
    
    return false
end

-- Helper function to fix stash access
Utils.OpenStash = function(name, slots, weight)
    TriggerEvent('inventory:client:SetCurrentStash', name)
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', name, {
        maxweight = weight or 250000,
        slots = slots or 40,
    })
end

-- Direct stash access functions for fridges, counter and trays
-- These are kept for backward compatibility but won't be used in the new system
Utils.OpenFoodFridge = function()
    Utils.OpenStash('UwUFoodFridge', 40, 250000)
end

Utils.OpenIngredientFridge = function()
    Utils.OpenStash('UwUIngredientFridge', 40, 250000)
end

Utils.OpenCounter = function()
    Utils.OpenStash('UwUCounter', 20, 10000)
end

Utils.OpenTray1 = function()
    Utils.OpenStash('UwUTray1', 6, 10000)
end

Utils.OpenTray2 = function()
    Utils.OpenStash('UwUTray2', 6, 10000)
end

Utils.OpenStorage = function()
    Utils.OpenStash('UwUStorage', 40, 250000)
end

-- Handle item use
Utils.UseItem = function(itemName, cb)
    QBCore.Functions.CreateUseableItem(itemName, cb)
end

-- A function to check if a player has the UwU job
Utils.HasJob = function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    return Player.PlayerData.job.name == Config.Job
end

-- A function to check if a player is on duty
Utils.IsOnDuty = function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    return Player.PlayerData.job.onduty
end

-- Check if a player has the required job grade
Utils.HasGrade = function(src, grade)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    return Player.PlayerData.job.name == Config.Job and Player.PlayerData.job.grade.level >= grade
end

-- A function to get a player's data
Utils.GetPlayer = function(src)
    return QBCore.Functions.GetPlayer(src)
end

-- A function to check if a player has enough money
Utils.HasEnoughMoney = function(src, account, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    if account == 'cash' then
        return Player.PlayerData.money.cash >= amount
    elseif account == 'bank' then
        return Player.PlayerData.money.bank >= amount
    end
    
    return false
end

-- A function to remove money from a player
Utils.RemoveMoney = function(src, account, amount, reason)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    reason = reason or 'UwU Cafe transaction'
    Player.Functions.RemoveMoney(account, amount, reason)
    return true
end

-- A function to add money to a player
Utils.AddMoney = function(src, account, amount, reason)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    reason = reason or 'UwU Cafe transaction'
    Player.Functions.AddMoney(account, amount, reason)
    return true
end

-- A function to add an item to a player's inventory
Utils.AddItem = function(src, item, amount, metadata)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    amount = amount or 1
    local added = Player.Functions.AddItem(item, amount, nil, metadata)
    
    if added then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
    end
    
    return added
end

-- A function to remove an item from a player's inventory
Utils.RemoveItem = function(src, item, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    amount = amount or 1
    local removed = Player.Functions.RemoveItem(item, amount)
    
    if removed then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
    end
    
    return removed
end

-- Distance check function (client-side only, must be called from a client event)
Utils.IsInDistance = function(playerCoords, targetCoords, maxDistance)
    return #(playerCoords - targetCoords) <= maxDistance
end

-- Add money to society account with compatibility for different versions
Utils.AddSocietyMoney = function(job, amount)
    TriggerEvent('qb-management:server:addAccountMoney', job, amount)
    
    if Config.Debug then
        print("^2UwU Cafe^7: Added $" .. amount .. " to " .. job .. " society account")
    end
end

-- Remove money from society account with compatibility for different versions
Utils.RemoveSocietyMoney = function(job, amount)
    TriggerEvent('qb-management:server:removeAccountMoney', job, amount)
    
    if Config.Debug then
        print("^2UwU Cafe^7: Removed $" .. amount .. " from " .. job .. " society account")
    end
end

-- Create an invoice with compatibility for different versions
Utils.CreateInvoice = function(src, target, amount, reason, title)
    title = title or "UwU Cafe"
    reason = reason or "UwU Cafe Services"
    
    TriggerEvent('qb-management:server:createInvoice', target, amount, reason, title, Config.Job)
    
    if Config.Debug then
        print("^2UwU Cafe^7: Created invoice for player " .. target .. " for $" .. amount)
    end
end

-- Initialize utils system
CreateThread(function()
    Utils.Debug("Utils system initialized")
    Utils.Debug("Using inventory system: " .. Utils.InventorySystem)
    Utils.Debug("Using target system: " .. Utils.TargetSystem)
    Utils.Debug("Using UI system: " .. Utils.UISystem)
end)

-- Provide direct event handlers for targets
-- These event handlers are kept for backward compatibility but the main targets are removed
RegisterNetEvent('mns-UwUCafe:client:FoodFridge', function()
    Utils.OpenFoodFridge()
end)

RegisterNetEvent('mns-UwUCafe:client:IngredientFridge', function()
    Utils.OpenIngredientFridge()
end)

RegisterNetEvent('mns-UwUCafe:client:Counter', function()
    Utils.OpenCounter()
end)

RegisterNetEvent('mns-UwUCafe:client:Tray1', function()
    Utils.OpenTray1()
end)

RegisterNetEvent('mns-UwUCafe:client:Tray2', function()
    Utils.OpenTray2()
end)

RegisterNetEvent('mns-UwUCafe:client:Storage', function()
    Utils.OpenStorage()
end)

-- Map deprecated event names to the proper ones for backwards compatibility
RegisterNetEvent('mns-UwUCafe:client:FoodRefrigerator', function()
    Utils.Debug("Using deprecated event: FoodRefrigerator, use FoodFridge instead")
    Utils.OpenFoodFridge()
end)

RegisterNetEvent('mns-UwUCafe:client:IngredientRefrigerator', function()
    Utils.Debug("Using deprecated event: IngredientRefrigerator, use IngredientFridge instead")
    Utils.OpenIngredientFridge()
end)

RegisterNetEvent('mns-UwUCafe:client:StorageBox', function()
    Utils.Debug("Using deprecated event: StorageBox, use Storage instead")
    Utils.OpenStorage()
end)

return Utils