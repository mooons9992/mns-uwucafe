local QBCore = exports['qb-core']:GetCoreObject()

-- Notification handlers
RegisterNetEvent('mns-UwUCafe:client:Notify', function(message, type, title)
    Utils.Notify(message, type, title)
end)

RegisterNetEvent('mns-UwUCafe:client:NotifySuccess', function(message, title)
    Utils.Notify(message, 'success', title)
end)

RegisterNetEvent('mns-UwUCafe:client:NotifyError', function(message, title)
    Utils.Notify(message, 'error', title)
end)

RegisterNetEvent('mns-UwUCafe:client:NotifyInfo', function(message, title)
    Utils.Notify(message, 'info', title)
end)

-- Draw 3D text for debug
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35
    
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Pet cat event with fixed animation
RegisterNetEvent('mns-UwUCafe:client:PetCat', function()
    -- Use a better animation that doesn't twist the body
    local animDict = "amb@medic@standing@kneel@base" 
    local anim = "base"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
    
    QBCore.Functions.Progressbar("petting_cat", "Petting Cat...", Config.ProgressDurations and Config.ProgressDurations.PettingCat or 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = animDict,
        anim = anim,
        flags = 1, -- Changed flag to 1 for better positioning
    }, {}, {}, function() -- Done
        -- Direct stress reduction
        TriggerServerEvent('hud:server:RelieveStress', Config.PetCatStressRelief or 5)
        QBCore.Functions.Notify("You pet the cat and feel more relaxed.", "success")
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        QBCore.Functions.Notify("You stopped petting the cat.", "error")
        ClearPedTasks(PlayerPedId())
    end)
end)

-- Fridge functions
RegisterNetEvent('mns-UwUCafe:client:FoodFridge', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUFoodFridge'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUFoodFridge')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUFoodFridge', {
            maxweight = 250000,
            slots = 40,
        })
    end
end)

RegisterNetEvent('mns-UwUCafe:client:IngredientFridge', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUIngredientFridge'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUIngredientFridge')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUIngredientFridge', {
            maxweight = 250000,
            slots = 40,
        })
    end
end)

-- Counter function
RegisterNetEvent('mns-UwUCafe:client:Counter', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUCounter'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUCounter')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUCounter', {
            maxweight = 10000,
            slots = 20,
        })
    end
end)

-- Tray functions
RegisterNetEvent('mns-UwUCafe:client:Tray1', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUTray1'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUTray1')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUTray1', {
            maxweight = 10000,
            slots = 6,
        })
    end
end)

RegisterNetEvent('mns-UwUCafe:client:Tray2', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUTray2'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUTray2')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUTray2', {
            maxweight = 10000,
            slots = 6,
        })
    end
end)

-- Storage function
RegisterNetEvent('mns-UwUCafe:client:Storage', function()
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:openInventory('stash', {id = 'UwUStorage'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'UwUStorage')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'UwUStorage', {
            maxweight = 250000,
            slots = 40,
        })
    end
end)

-- Fixed bill customer event
RegisterNetEvent('mns-UwUCafe:client:BillCustomer', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Bill Customer for " .. (data.item or "Items"),
        submitText = "Send Bill",
        inputs = {
            {
                text = "Player ID",
                name = "playerid",
                type = "number",
                isRequired = true
            },
            {
                text = "Amount",
                name = "amount",
                type = "number",
                default = data.price or 0,
                isRequired = true
            }
        }
    })
    
    if dialog then
        local playerId = tonumber(dialog.playerid)
        local amount = tonumber(dialog.amount)
        
        if not amount or amount <= 0 then
            amount = data.price or 0
        end
        
        if playerId and playerId > 0 then
            TriggerServerEvent("mns-UwUCafe:server:BillPlayer", playerId, amount)
            QBCore.Functions.Notify("You've billed Player ID: " .. playerId .. " for $" .. amount, "success")
        else
            QBCore.Functions.Notify("Invalid Player ID", "error")
        end
    end
end)

-- Ingredient Purchase function
RegisterNetEvent('mns-UwUCafe:client:PurchaseIngredient', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Purchase " .. data.label,
        submitText = "Buy",
        inputs = {
            {
                text = "Amount",
                name = "amount",
                type = "number",
                isRequired = true,
                default = 1
            }
        }
    })
    
    if dialog then
        local amount = tonumber(dialog.amount)
        
        if amount and amount > 0 then
            local totalPrice = data.price * amount
            
            QBCore.Functions.TriggerCallback('mns-UwUCafe:server:CanAffordIngredients', function(canAfford)
                if canAfford then
                    
                    QBCore.Functions.Progressbar("uwu_purchase_ingredients", "Ordering " .. data.label .. "...", 3000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "mp_common",
                        anim = "givetake1_a",
                        flags = 49,
                    }, {}, {}, function() -- Done
                        TriggerServerEvent('mns-UwUCafe:server:PurchaseIngredients', data.item, amount, totalPrice)
                        QBCore.Functions.Notify("Purchased " .. amount .. "x " .. data.label, "success", 3000)
                    end, function() -- Cancel
                        QBCore.Functions.Notify("Cancelled order.", "error")
                    end)
                else
                    QBCore.Functions.Notify("You don't have enough money in your bank account", "error")
                end
            end, totalPrice)
        else
            QBCore.Functions.Notify("Please enter a valid amount", "error")
        end
    end
end)

-- Purchase item from self-service menu
RegisterNetEvent('mns-UwUCafe:client:PurchaseMenuItem', function(data)
    local Player = QBCore.Functions.GetPlayerData()
    
    -- Check if the player has enough money in bank (changed from cash)
    if Player.money.bank < data.price then
        QBCore.Functions.Notify("You don't have enough money in your bank account.", "error")
        return
    end
    
    -- Progress bar for preparing the item
    QBCore.Functions.Progressbar("purchase_uwu", "Getting your order...", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function() -- Done
        -- Send request to server to complete the purchase
        TriggerServerEvent('mns-UwUCafe:server:PurchaseMenuItem', data.item, data.price, true) -- Use bank instead of cash
        
        -- Show appropriate notification
        QBCore.Functions.Notify("Enjoy your order! Thank you for visiting UwU Cat Cafe.", "success")
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled purchase.", "error")
    end)
end)

-- FIXED: Toggle duty event with global debounce to prevent multiple state changes
local dutyToggleInProgress = false
RegisterNetEvent('mns-UwUCafe:client:ToggleDuty', function()
    -- Check if toggle is already in progress
    if dutyToggleInProgress or _G.toggleDutyInProgress then
        if Config.Debug then
            print("^3UwU Cafe Debug^7: Duty toggle already in progress, ignoring request")
        end
        return
    end
    
    -- Set debounce flag - both local and global
    dutyToggleInProgress = true
    _G.toggleDutyInProgress = true
    
    -- Check player state
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name ~= Config.Job then
        QBCore.Functions.Notify("You don't work here!", "error")
        dutyToggleInProgress = false
        _G.toggleDutyInProgress = false
        return
    end
    
    -- Add animation for clocking in/out
    RequestAnimDict("anim@heists@keycard@")
    while not HasAnimDictLoaded("anim@heists@keycard@") do
        Wait(10)
    end
    
    -- Play animation
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    
    -- Progress bar to prevent spamming
    QBCore.Functions.Progressbar("uwu_toggle_duty", "Clocking " .. (PlayerData.job.onduty and "out" or "in") .. "...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        -- Send toggle duty request to server only once
        TriggerServerEvent('QBCore:ToggleDuty')
        
        -- Add delay to ensure proper update
        Wait(1500)
        
        -- Get updated player data
        local updatedData = QBCore.Functions.GetPlayerData()
        
        -- Show appropriate notification
        if updatedData.job.onduty then
            QBCore.Functions.Notify("You are now on duty at UwU Café!", "success")
        else
            QBCore.Functions.Notify("You are now off duty. Have a nice break!", "error")
        end
        
        -- Clear animation
        ClearPedTasks(PlayerPedId())
        
        -- Clear the debounce after a delay
        Wait(3000)
        dutyToggleInProgress = false
        _G.toggleDutyInProgress = false
        
        if Config.Debug then
            print("^3UwU Cafe Debug^7: Duty toggle complete. New duty status: " .. tostring(updatedData.job.onduty))
        end
    end, function() -- Cancel
        -- Clear animation
        ClearPedTasks(PlayerPedId())
        
        -- Clear the debounce
        dutyToggleInProgress = false
        _G.toggleDutyInProgress = false
    end)
end)

-- Create money drop for cash registers
RegisterNetEvent('mns-UwUCafe:client:CreateCashDrop', function(amount)
    if amount <= 0 then return end
    
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    
    -- Create cash prop
    local cashProp = nil
    
    if amount >= 5000 then
        cashProp = CreateObject(GetHashKey("prop_money_bag_01"), pos.x, pos.y, pos.z - 1.0, true, true, true)
    elseif amount >= 1000 then
        cashProp = CreateObject(GetHashKey("prop_cash_pile_02"), pos.x, pos.y, pos.z - 1.0, true, true, true)
    else
        cashProp = CreateObject(GetHashKey("prop_cash_pile_01"), pos.x, pos.y, pos.z - 1.0, true, true, true)
    end
    
    if cashProp then
        -- Add target to prop
        if Config.Target == "ox_target" then
            exports.ox_target:addLocalEntity(cashProp, {
                {
                    name = 'uwu_cash_pickup',
                    icon = "fas fa-money-bill",
                    label = "Pickup Cash ($" .. amount .. ")",
                    onSelect = function()
                        TriggerEvent('mns-UwUCafe:client:PickupCash', cashProp, amount)
                    end,
                }
            })
        else
            exports['qb-target']:AddTargetEntity(cashProp, {
                options = {
                    {
                        type = "client",
                        event = "mns-UwUCafe:client:PickupCash",
                        icon = "fas fa-money-bill",
                        label = "Pickup Cash ($" .. amount .. ")",
                        canInteract = function()
                            return true
                        end,
                        cash = amount
                    }
                },
                distance = 3.0
            })
        end
    end
end)

-- Pickup money event
RegisterNetEvent('mns-UwUCafe:client:PickupCash', function(entity, amount)
    -- If called from qb-target, data is passed differently
    if type(entity) == "table" then
        amount = entity.cash
        entity = entity.entity
    end
    
    if DoesEntityExist(entity) then
        QBCore.Functions.Progressbar("pickup_cash", "Picking Up Cash...", 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "pickup_object",
            anim = "pickup_low",
            flags = 16,
        }, {}, {}, function()
            TriggerServerEvent('mns-UwUCafe:server:AddCash', amount)
            DeleteEntity(entity)
            QBCore.Functions.Notify("You picked up $" .. amount, "success")
        end, function()
            QBCore.Functions.Notify("Cancelled...", "error")
        end)
    end
end)

-- Helper function to check canInteract conditions
function CanInteractWithStove()
    local Player = QBCore.Functions.GetPlayerData()
    return (Player.job.name == Config.Job and Player.job.onduty)
end

-- Food creation menu functions
RegisterNetEvent('mns-UwUCafe:client:MakeFood', function(foodItem, ingredients, animDict, anim, duration)
    local Player = QBCore.Functions.GetPlayerData()
    
    if Player.job.name ~= Config.Job or not Player.job.onduty then
        QBCore.Functions.Notify('You must be on duty', 'error')
        return
    end
    
    -- Check for ingredients
    QBCore.Functions.TriggerCallback('mns-UwUCafe:server:HasIngredients', function(hasIngredients)
        if hasIngredients then
            -- Start food preparation animation
            if animDict and anim then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Wait(10)
                end
            end
            
            QBCore.Functions.Progressbar("make_food", "Preparing " .. foodItem.label, duration or 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = animDict or "mp_arresting",
                anim = anim or "a_uncuff",
                flags = 8,
            }, {}, {}, function() -- Done
                TriggerServerEvent('mns-UwUCafe:server:GiveFood', foodItem.name, ingredients)
                QBCore.Functions.Notify("You have made a " .. foodItem.label, "success")
            end, function() -- Cancel
                QBCore.Functions.Notify("Cancelled making " .. foodItem.label, "error")
            end)
        else
            QBCore.Functions.Notify("You don't have all the required ingredients!", "error")
        end
    end, ingredients)
end)

-- Coffee making
RegisterNetEvent('mns-UwUCafe:client:MakeCoffee', function()
    local ingredients = {
        ['uwu-coffeebeans'] = 1,
        ['uwu-water'] = 1
    }
    
    local foodItem = {
        name = "uwu-coffee",
        label = "Coffee"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 4000)
end)

-- Latte making
RegisterNetEvent('mns-UwUCafe:client:MakeLatte', function()
    local ingredients = {
        ['uwu-coffeebeans'] = 1,
        ['uwu-milk'] = 1
    }
    
    local foodItem = {
        name = "latte",
        label = "Latte"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 5000)
end)

-- Blackberry Bubble Tea making
RegisterNetEvent('mns-UwUCafe:client:MakeBlackberryBubbleTea', function()
    local ingredients = {
        ['uwu-tea'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-blackberries'] = 1,
        ['uwu-tapioca'] = 1
    }
    
    local foodItem = {
        name = "blackberry-bubble-tea",
        label = "Blackberry Bubble Tea"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 6000)
end)

-- Strawberry Bubble Tea making
RegisterNetEvent('mns-UwUCafe:client:MakeStrawberryBubbleTea', function()
    local ingredients = {
        ['uwu-tea'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-strawberries'] = 1,
        ['uwu-tapioca'] = 1
    }
    
    local foodItem = {
        name = "strawberry-bubble-tea",
        label = "Strawberry Bubble Tea"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 6000)
end)

-- Mint Bubble Tea making
RegisterNetEvent('mns-UwUCafe:client:MakeMintBubbleTea', function()
    local ingredients = {
        ['uwu-tea'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-mint'] = 1,
        ['uwu-tapioca'] = 1
    }
    
    local foodItem = {
        name = "mint-bubble-tea",
        label = "Mint Bubble Tea"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 6000)
end)

-- Strawberry Cupcake making
RegisterNetEvent('mns-UwUCafe:client:MakeStrawberryCupcake', function()
    local ingredients = {
        ['uwu-flour'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-strawberries'] = 1
    }
    
    local foodItem = {
        name = "strawberry-cupcake",
        label = "Strawberry Cupcake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Chocolate Cupcake making
RegisterNetEvent('mns-UwUCafe:client:MakeChocolateCupcake', function()
    local ingredients = {
        ['uwu-flour'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-chocolate'] = 1
    }
    
    local foodItem = {
        name = "chocolate-cupcake",
        label = "Chocolate Cupcake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Lemon Cupcake making
RegisterNetEvent('mns-UwUCafe:client:MakeLemonCupcake', function()
    local ingredients = {
        ['uwu-flour'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-lemon'] = 1
    }
    
    local foodItem = {
        name = "lemon-cupcake",
        label = "Lemon Cupcake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Vanilla Ice Cream making
RegisterNetEvent('mns-UwUCafe:client:MakeVanillaIceCream', function()
    local ingredients = {
        ['uwu-milk'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-vanilla'] = 1
    }
    
    local foodItem = {
        name = "vanilla-icecream",
        label = "Vanilla Ice Cream"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Strawberry Ice Cream making
RegisterNetEvent('mns-UwUCafe:client:MakeStrawberryIceCream', function()
    local ingredients = {
        ['uwu-milk'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-strawberries'] = 1
    }
    
    local foodItem = {
        name = "strawberry-icecream",
        label = "Strawberry Ice Cream"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Chocolate Ice Cream making
RegisterNetEvent('mns-UwUCafe:client:MakeChocolateIceCream', function()
    local ingredients = {
        ['uwu-milk'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-chocolate'] = 1
    }
    
    local foodItem = {
        name = "chocolate-icecream",
        label = "Chocolate Ice Cream"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Nutella Pancake making
RegisterNetEvent('mns-UwUCafe:client:MakeNutellaPancake', function()
    local ingredients = {
        ['uwu-flour'] = 1,
        ['uwu-milk'] = 1,
        ['uwu-chocolate'] = 1
    }
    
    local foodItem = {
        name = "nutella-pancake",
        label = "Nutella Pancake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

RegisterNetEvent('mns-UwUCafe:client:MakeOreoPancake', function()
    local ingredients = {
        ['uwu-flour'] = 1,
        ['uwu-milk'] = 1,
        ['uwu-cookies'] = 1
    }
    
    local foodItem = {
        name = "oreo-pancake",
        label = "Oreo Pancake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "mp_arresting", "a_uncuff", 5000)
end)

-- Strawberry Milkshake making
RegisterNetEvent('mns-UwUCafe:client:MakeStrawberryMilkshake', function()
    local ingredients = {
        ['uwu-milk'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-strawberries'] = 1
    }
    
    local foodItem = {
        name = "strawberry-milkshake",
        label = "Strawberry Milkshake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 5000)
end)

-- Chocolate Milkshake making
RegisterNetEvent('mns-UwUCafe:client:MakeChocolateMilkshake', function()
    local ingredients = {
        ['uwu-milk'] = 1,
        ['uwu-sugar'] = 1,
        ['uwu-chocolate'] = 1
    }
    
    local foodItem = {
        name = "chocolate-milkshake",
        label = "Chocolate Milkshake"
    }
    
    TriggerEvent('mns-UwUCafe:client:MakeFood', foodItem, ingredients, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 5000)
end)

-- Server events for recipe triggers
RegisterNetEvent('mns-UwUCafe:server:MakeCoffee', function()
    TriggerEvent('mns-UwUCafe:client:MakeCoffee')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeLatte', function()
    TriggerEvent('mns-UwUCafe:client:MakeLatte')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeBlackberryBubbleTea', function()
    TriggerEvent('mns-UwUCafe:client:MakeBlackberryBubbleTea')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryBubbleTea', function()
    TriggerEvent('mns-UwUCafe:client:MakeStrawberryBubbleTea')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeMintBubbleTea', function()
    TriggerEvent('mns-UwUCafe:client:MakeMintBubbleTea')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryCupcake', function()
    TriggerEvent('mns-UwUCafe:client:MakeStrawberryCupcake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateCupcake', function()
    TriggerEvent('mns-UwUCafe:client:MakeChocolateCupcake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeLemonCupcake', function()
    TriggerEvent('mns-UwUCafe:client:MakeLemonCupcake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeVanillaIceCream', function()
    TriggerEvent('mns-UwUCafe:client:MakeVanillaIceCream')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateIceCream', function()
    TriggerEvent('mns-UwUCafe:client:MakeChocolateIceCream')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryIceCream', function()
    TriggerEvent('mns-UwUCafe:client:MakeStrawberryIceCream')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeNutellaPancake', function()
    TriggerEvent('mns-UwUCafe:client:MakeNutellaPancake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeOreoPancake', function()
    TriggerEvent('mns-UwUCafe:client:MakeOreoPancake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeStrawberryMilkshake', function()
    TriggerEvent('mns-UwUCafe:client:MakeStrawberryMilkshake')
end)

RegisterNetEvent('mns-UwUCafe:server:MakeChocolateMilkshake', function()
    TriggerEvent('mns-UwUCafe:client:MakeChocolateMilkshake')
end)

-- Debug command to check duty status
RegisterCommand('checkuwuduty', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local onDuty = PlayerData.job.onduty
    local jobName = PlayerData.job.name
    
    QBCore.Functions.Notify("Job: " .. jobName .. " | On Duty: " .. (onDuty and "Yes" or "No"), "primary", 5000)
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Job: " .. jobName .. " | On Duty: " .. tostring(onDuty))
    end
end, false)

-- Force duty toggle for emergencies (admin-only)
RegisterCommand('uwuduty', function()
    if not IsPlayerAceAllowed(PlayerId(), "admin") then 
        QBCore.Functions.Notify("You don't have permission to use this command", "error")
        return 
    end
    
    TriggerServerEvent('QBCore:ToggleDuty')
    QBCore.Functions.Notify("Admin force toggled duty state", "primary")
    
    -- Debug
    if Config.Debug then
        local PlayerData = QBCore.Functions.GetPlayerData()
        Wait(1000) -- Wait for duty to update
        print("^3UwU Cafe Debug^7: Admin forced duty toggle. New status: " .. tostring(PlayerData.job.onduty))
    end
end, false)

-- Fixed OpenBillingMenu function with back option
RegisterNetEvent('mns-UwUCafe:client:OpenBillingMenu', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: OpenBillingMenu triggered")
    end
    
    -- Check job and duty
    if PlayerData.job.name ~= Config.Job or not PlayerData.job.onduty then
        QBCore.Functions.Notify("You must be an on-duty UwU employee to bill customers.", "error")
        return
    end
    
    -- Create billing dialog using qb-input
    local dialog = exports['qb-input']:ShowInput({
        header = "UwU Café - Bill Customer",
        submitText = "Send Bill",
        inputs = {
            {
                text = "Player ID (enter 0 to go back)",
                name = "playerid",
                type = "number",
                isRequired = true
            },
            {
                text = "Amount",
                name = "amount",
                type = "number",
                isRequired = true
            }
        }
    })
    
    if dialog then
        if not dialog.playerid or not dialog.amount then 
            return 
        end
        
        -- Check if user wants to go back
        if tonumber(dialog.playerid) == 0 then
            TriggerEvent('mns-UwUCafe:client:ViewMenu')
            return
        end
        
        TriggerServerEvent("mns-UwUCafe:server:BillPlayer", dialog.playerid, dialog.amount)
    else
        -- User cancelled - return to menu
        Wait(100)
        TriggerEvent('mns-UwUCafe:client:ViewMenu')
    end
end)