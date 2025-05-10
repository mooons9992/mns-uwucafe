local QBCore = exports['qb-core']:GetCoreObject()

-- Utils is already defined globally in utils.lua
-- No need to use require anymore

------------------------------------
----- Generic Recipe Function ------
------------------------------------

-- A generic function to handle all food/drink creation
local function ProcessRecipe(source, recipeKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Find recipe in config
    local recipe = Config.Recipes[recipeKey]
    if not recipe then 
        print("Recipe not found: " .. recipeKey)
        return 
    end
    
    -- Check if player has all required items
    local hasAllItems = true
    local items = {}
    
    -- Check for all ingredients
    for _, ingredient in ipairs(recipe.requiredItems) do
        local item = Player.Functions.GetItemByName(ingredient)
        if not item or item.amount < 1 then
            hasAllItems = false
            break
        end
        table.insert(items, ingredient)
    end
    
    if hasAllItems then
        -- Remove all ingredients
        for _, ingredient in ipairs(items) do
            if not Player.Functions.RemoveItem(ingredient, 1) then
                hasAllItems = false
                break
            end
        end
        
        -- If all items were successfully removed
        if hasAllItems then
            -- Add the result item
            Player.Functions.AddItem(recipe.receivedItem, 1, nil, {quality = 100, created = os.time()})
            
            -- Use appropriate inventory notification based on config
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[recipe.receivedItem], "add")
        end
    else
        -- Use our utility notify function based on config
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the required items.', 'error')
    end
end

-- Check if player has required ingredients
QBCore.Functions.CreateCallback('mns-UwUCafe:server:HasIngredients', function(source, cb, ingredients)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb(false) end
    
    local hasAll = true
    
    -- Check each ingredient
    for item, amount in pairs(ingredients) do
        if not item or not amount then
            hasAll = false
            break
        end
        
        local itemInfo = Player.Functions.GetItemByName(item)
        if not itemInfo or itemInfo.amount < amount then
            hasAll = false
            break
        end
    end
    
    cb(hasAll)
end)

-- Craft food server event
RegisterNetEvent('mns-UwUCafe:server:CraftFood', function(itemName, ingredients)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Check if player has the job
    if Player.PlayerData.job.name ~= Config.Job then
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the required job.', 'error')
        return
    end
    
    -- Check if player is on duty
    if not Player.PlayerData.job.onduty then
        TriggerClientEvent('QBCore:Notify', src, 'You must be on duty to craft items.', 'error')
        return
    end
    
    -- Check if player has all ingredients
    local hasAllItems = true
    for item, amount in pairs(ingredients) do
        if not Player.Functions.GetItemByName(item) or Player.Functions.GetItemByName(item).amount < amount then
            hasAllItems = false
            break
        end
    end
    
    if hasAllItems then
        -- Remove ingredients
        for item, amount in pairs(ingredients) do
            Player.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
        end
        
        -- Add crafted item
        Player.Functions.AddItem(itemName, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")
        
        -- Notify success
        TriggerClientEvent('QBCore:Notify', src, 'You crafted a ' .. (QBCore.Shared.Items[itemName] and QBCore.Shared.Items[itemName].label or itemName), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have all the required ingredients.', 'error')
    end
end)

------------------------------------
----------- Food Crafting ----------
------------------------------------

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryCupcake', function()
    ProcessRecipe(source, "StrawberryCupcake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeLemonCupcake', function()
    ProcessRecipe(source, "LemonCupcake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateCupcake', function()
    ProcessRecipe(source, "ChocolateCupcake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryIceCream', function()
    ProcessRecipe(source, "StrawberryIceCream")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateIceCream', function()
    ProcessRecipe(source, "ChocolateIceCream")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeVanillaIceCream', function()
    ProcessRecipe(source, "VanillaIceCream")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeNutellaPancake', function()
    ProcessRecipe(source, "NutellaPancake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeOreoPancake', function()
    ProcessRecipe(source, "OreoPancake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateMuffin', function()
    ProcessRecipe(source, "ChocolateMuffin")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChickenPastel', function()
    ProcessRecipe(source, "ChickenPastry")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeNutellaWaffle', function()
    ProcessRecipe(source, "NutellaWaffle")
end)

------------------------------------
----------- Drink Crafting ---------
------------------------------------

RegisterNetEvent('mns-UwUCafe:server:MakeCoffee', function()
    ProcessRecipe(source, "Coffee")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeLatte', function()
    ProcessRecipe(source, "Latte")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeBlackberryBubbleTea', function()
    ProcessRecipe(source, "BlackberryBubbleTea")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryBubbleTea', function()
    ProcessRecipe(source, "StrawberryBubbleTea")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeMintBubbleTea', function()
    ProcessRecipe(source, "MintBubbleTea")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryMilkshake', function()
    ProcessRecipe(source, "StrawberryMilkshake")
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateMilkshake', function()
    ProcessRecipe(source, "ChocolateMilkshake")
end)

------------------------------------
------- Ingredient Purchasing ------
------------------------------------

-- Check if player can afford ingredients
QBCore.Functions.CreateCallback('mns-UwUCafe:server:CanAffordIngredients', function(source, cb, price)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return cb(false) end
    
    -- Check if player has enough money in bank
    local bankBalance = Player.PlayerData.money and Player.PlayerData.money.bank or 0
    cb(bankBalance >= price)
end)

-- Purchase ingredients event
RegisterNetEvent('mns-UwUCafe:server:PurchaseIngredients', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Check job
    if Player.PlayerData.job.name ~= Config.Job then
        TriggerClientEvent('QBCore:Notify', src, 'You are not authorized to purchase ingredients.', 'error')
        return
    end
    
    -- Check if on duty
    if not Player.PlayerData.job.onduty then
        TriggerClientEvent('QBCore:Notify', src, 'You must be on duty to purchase ingredients.', 'error')
        return
    end
    
    -- Check bank balance
    if not Player.PlayerData.money or Player.PlayerData.money.bank < price then
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money in your bank account.', 'error')
        return
    end
    
    -- Remove money from player
    Player.Functions.RemoveMoney('bank', price, 'UwU Cafe Ingredients Purchase')
    
    -- Use society money - FIXED with compatibility for different qb-management versions
    -- Use event rather than direct export for better compatibility
    if price > 0 then
        TriggerEvent('qb-management:server:removeAccountMoney', Config.Job, math.floor(price / 2))
    end
    
    -- Add items to player
    local success = Player.Functions.AddItem(item, amount)
    if success then
        -- Send single notification with the proper item label
        local itemLabel = QBCore.Shared.Items[item] and QBCore.Shared.Items[item].label or item
        TriggerClientEvent('QBCore:Notify', src, 'You purchased ' .. amount .. 'x ' .. itemLabel, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Couldn't add item to inventory.", "error")
        -- Refund money
        Player.Functions.AddMoney('bank', price, 'UwU Cafe Ingredients Purchase Refund')
    end
end)

------------------------------------
------- Consumable Items -----------
------------------------------------

-- Generic function to handle item use
local function UseConsumableItem(source, item, eventName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    if Player.Functions.GetItemBySlot(item.slot) then
        TriggerClientEvent(eventName, src)
        Player.Functions.RemoveItem(item.name, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove")
    end
end

-- Register a helper function to create usable items
local function RegisterConsumableItem(itemName, eventName)
    QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        UseConsumableItem(source, item, eventName)
    end)
end

-- Register all drink items
RegisterConsumableItem("uwu-coffee", 'mns-UwUCafe:client:DrinkCoffee')
RegisterConsumableItem("uwu-latte", 'mns-UwUCafe:client:DrinkLatte')
RegisterConsumableItem("bubble-blackberry", 'mns-UwUCafe:client:DrinkBubbleTea')
RegisterConsumableItem("bubble-strawberry", 'mns-UwUCafe:client:DrinkBubbleTea')
RegisterConsumableItem("bubble-mint", 'mns-UwUCafe:client:DrinkBubbleTea')
RegisterConsumableItem("milkshake-chocolate", 'mns-UwUCafe:client:DrinkMilkshake')
RegisterConsumableItem("milkshake-strawberry", 'mns-UwUCafe:client:DrinkMilkshake')

-- Register all food items
RegisterConsumableItem("strawberry-cupcake", 'mns-UwUCafe:client:EatCupcake')
RegisterConsumableItem("chocolate-cupcake", 'mns-UwUCafe:client:EatCupcake')
RegisterConsumableItem("lemon-cupcake", 'mns-UwUCafe:client:EatCupcake')
RegisterConsumableItem("strawberry-icecream", 'mns-UwUCafe:client:EatIceCream')
RegisterConsumableItem("chocolate-icecream", 'mns-UwUCafe:client:EatIceCream')
RegisterConsumableItem("vanilla-icecream", 'mns-UwUCafe:client:EatIceCream')
RegisterConsumableItem("nutella-pancake", 'mns-UwUCafe:client:EatPancake')
RegisterConsumableItem("oreo-pancake", 'mns-UwUCafe:client:EatPancake')
RegisterConsumableItem("chocolate-muffin", 'mns-UwUCafe:client:EatMuffin')
RegisterConsumableItem("nutella-waffle", 'mns-UwUCafe:client:EatWaffle')
RegisterConsumableItem("chicken-pastry", 'mns-UwUCafe:client:EatChickenPastel')

------------------------------------------------
---------- Bill Player ----------------------

RegisterNetEvent("mns-UwUCafe:server:BillPlayer", function(playerId, amount)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    
    -- Add nil check for biller
    if not biller then return end
    
    -- Check if valid playerId and amount
    if not playerId or not amount then
        TriggerClientEvent('QBCore:Notify', src, "Invalid player ID or amount.", "error")
        return
    end
    
    local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    
    if not biller then return end
    
    if biller.PlayerData.job.name == Config.Job then
        if billed then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    -- Use qb-management's event for billing instead of direct export
                    TriggerEvent('qb-management:server:createInvoice', billed.PlayerData.source, amount, "UwU Cafe Services", "UwU Cafe", Config.Job)
                    
                    -- Notify both players
                    TriggerClientEvent('QBCore:Notify', src, 'Invoice successfully sent.', 'success')
                    TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'You have received a new invoice.', 'info')
                else
                    TriggerClientEvent('QBCore:Notify', src, 'The amount must be greater than 0.', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'You cannot bill yourself.', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'The specified player is not online.', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to bill players.', 'error')
    end
end)

-- Self-service purchase handler
RegisterNetEvent('mns-UwUCafe:server:PurchaseMenuItem', function(item, price, useBank)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Debug
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Player " .. GetPlayerName(src) .. " is purchasing item: " .. item)
        print("^3UwU Cafe Debug^7: Checking if item exists in QBCore.Shared.Items")
    end
    
    -- Check if the item exists in the shared items database
    if not QBCore.Shared.Items[item] then
        print("^1UwU Cafe ERROR^7: Item " .. item .. " is missing from QBCore.Shared.Items!")
        TriggerClientEvent('QBCore:Notify', src, "This item doesn't exist in the database: " .. item, "error")
        return
    end
    
    -- Check if player has enough money
    local moneyType = useBank and 'bank' or 'cash'
    if Player.PlayerData.money[moneyType] < price then
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money in your " .. moneyType, "error")
        return
    end
    
    -- Remove money
    Player.Functions.RemoveMoney(moneyType, price)
    
    -- Try to add the item, check if successful
    local success = Player.Functions.AddItem(item, 1)
    if not success then
        -- Refund the money if item couldn't be added
        Player.Functions.AddMoney(moneyType, price)
        TriggerClientEvent('QBCore:Notify', src, "Couldn't add item to inventory. Money refunded.", "error")
        return
    end
    
    -- Send single notification using the proper item label
    local itemLabel = QBCore.Shared.Items[item].label or item
    TriggerClientEvent('QBCore:Notify', src, "You purchased a " .. itemLabel, "success")
    
    -- Update inventory UI
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add")
    
    -- Add money to society using the event instead of direct export
    -- This is more compatible across different versions of qb-management
    local societyAmount = math.floor(price / (Config.SelfServiceMarkup or 1.5))
    if societyAmount > 0 then
        TriggerEvent('qb-management:server:addAccountMoney', Config.Job, societyAmount)
    end
end)

-- Give food to player (from kitchen)
RegisterNetEvent('mns-UwUCafe:server:GiveFood', function(itemName, ingredients)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- First check if player is on duty and has job
    if Player.PlayerData.job.name ~= Config.Job or not Player.PlayerData.job.onduty then
        TriggerClientEvent('QBCore:Notify', src, 'You are not authorized to prepare food.', 'error')
        return
    end
    
    -- Check ingredients
    local hasAllItems = true
    for item, amount in pairs(ingredients or {}) do
        if not Player.Functions.GetItemByName(item) or Player.Functions.GetItemByName(item).amount < amount then
            hasAllItems = false
            break
        end
    end
    
    if hasAllItems and ingredients then
        -- Remove ingredients
        for item, amount in pairs(ingredients) do
            Player.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
        end
        
        -- Add crafted item
        Player.Functions.AddItem(itemName, 1)
        
        -- Get the label for a better notification message
        local itemLabel = QBCore.Shared.Items[itemName] and QBCore.Shared.Items[itemName].label or itemName
        
        -- Send single combined notification
        TriggerClientEvent('QBCore:Notify', src, 'You prepared a ' .. itemLabel, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the required ingredients.', 'error')
    end
end)

-- Reduce player stress when petting cats
RegisterNetEvent('mns-UwUCafe:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Get current stress level
    local currentStress = Player.PlayerData.metadata["stress"] or 0
    
    -- Calculate new stress level
    local newStress = math.max(0, currentStress - amount)
    
    -- Set new stress level
    Player.Functions.SetMetaData("stress", newStress)
    
    -- Debug message if enabled
    if Config.Debug then
        print("^2UwU Cafe^7: Player ^3" .. Player.PlayerData.charinfo.firstname .. "^7 stress reduced by ^3" .. amount .. "^7. New stress: ^3" .. newStress .. "^7")
    end
end)

-- Add cash to player (when picking up cash)
RegisterNetEvent('mns-UwUCafe:server:AddCash', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    if amount and amount > 0 then
        Player.Functions.AddMoney('cash', amount, 'UwU Cafe pickup')
    end
end)

-- Debug information on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    
    -- Check which version of qb-management we have and log compatibility info
    if Config.Debug then
        print("^2UwU Cafe^7: Server script started")
        print("^2UwU Cafe^7: Using server events for qb-management instead of direct exports for better compatibility")
    end
end)

-- Version check display on server start
Citizen.CreateThread(function()
    Citizen.Wait(2000) -- Wait for resource to fully start
    
    local resource = GetCurrentResourceName()
    local version = GetResourceMetadata(resource, 'version', 0)
    
    if version then
        print('^2['..resource..'] ^5Version: ^7' .. version)
        print('^2['..resource..'] ^5Created by: ^7Mooons')
    end
end)