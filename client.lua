local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local isLoggedIn = false
local onDuty = false
local PlayerJob = {}
local spawnedCats = {}
local ingredientSellerPed = nil

-- Initialize the global toggle duty flag (prevents multiple clicks)
_G.toggleDutyInProgress = false

-- Debug function to check player job and duty status
function CheckJobStatus()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Job Name: " .. (PlayerData.job.name or "none"))
        print("^3UwU Cafe Debug^7: Job Grade: " .. (PlayerData.job.grade.level or 0))
        print("^3UwU Cafe Debug^7: On Duty: " .. tostring(PlayerData.job.onduty))
    end
    return PlayerData.job
end

-- Initial setup when resource starts
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
    isLoggedIn = true
    onDuty = PlayerJob.onduty
    
    -- Create blips if needed
    CreateBlips()
    
    -- Create NPCs if enabled
    if Config.UsePed then
        CreatePeds()
    end
    
    -- Spawn cats
    SpawnCafeCats()
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Player Loaded - Job: " .. PlayerJob.name .. ", Duty: " .. tostring(onDuty))
    end
end)

-- Update PlayerData when job changes
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    PlayerData.job = JobInfo
    onDuty = JobInfo.onduty
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Job updated - " .. JobInfo.name .. " | On Duty: " .. tostring(onDuty))
    end
end)

-- Update PlayerData when player data changes
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

-- Update duty status
RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: Duty set to: " .. tostring(duty))
    end
end)

-- Create blips function
function CreateBlips()
    if not Config.UseBlip then return end
    
    local blip = AddBlipForCoord(Config.Location)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, Config.Blip.display)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, Config.Blip.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.name)
    EndTextCommandSetBlipName(blip)
    
    if Config.Debug then
        print("^2UwU Cafe^7: Blip created at " .. Config.Location.x .. ", " .. Config.Location.y .. ", " .. Config.Location.z)
    end
end

-- Create peds function
function CreatePeds()
    if not Config.UsePed or not Config.Ped or not Config.Ped.model or not Config.Ped.coords then
        if Config.Debug then
            print("^3UwU Cafe^7: Ped configuration is incomplete. Skipping ped creation.")
        end
        return
    end

    local model = Config.Ped.model
    if type(model) == "string" then 
        model = GetHashKey(model)
    end
    
    local coords = Config.Ped.coords
    
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(5)
    end

    ingredientSellerPed = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    FreezeEntityPosition(ingredientSellerPed, true)
    SetEntityInvincible(ingredientSellerPed, true)
    SetBlockingOfNonTemporaryEvents(ingredientSellerPed, true)
    
    -- Play scenario if specified
    if Config.Ped.scenario then
        TaskStartScenarioInPlace(ingredientSellerPed, Config.Ped.scenario, 0, true)
    end
    
    if Config.Debug then
        print("^2UwU Cafe^7: Supplier Ped created at coordinates: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
    end
end

-- Spawn cats function
function SpawnCafeCats()
    if not Config.CatSpawns or #Config.CatSpawns == 0 then
        if Config.Debug then
            print("^3UwU Cafe^7: No cat spawns configured. Skipping cat creation.")
        end
        return
    end
    
    local catModel = Config.CatModel
    if type(catModel) == "string" then 
        catModel = GetHashKey(catModel)
    end
    
    RequestModel(catModel)
    while not HasModelLoaded(catModel) do
        Wait(5)
    end
    
    -- Clear existing cats first
    for _, cat in pairs(spawnedCats) do
        if DoesEntityExist(cat) then
            DeleteEntity(cat)
        end
    end
    spawnedCats = {}
    
    -- Spawn cats at configured locations
    for i, coords in ipairs(Config.CatSpawns) do
        local cat = CreatePed(28, catModel, coords.x, coords.y, coords.z, coords.w, false, false)
        
        -- Set cat properties
        FreezeEntityPosition(cat, false)
        SetEntityInvincible(cat, true)
        SetBlockingOfNonTemporaryEvents(cat, true)
        
        -- Make cat wander occasionally
        TaskWanderStandard(cat, 10.0, 10)
        
        -- Set cat as sittable
        TaskStartScenarioInPlace(cat, "WORLD_CAT_SLEEPING_GROUND", 0, true)
        
        table.insert(spawnedCats, cat)
        
        if Config.Debug then
            print("^2UwU Cafe^7: Cat #" .. i .. " spawned at: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
        end
    end
end

-- Menu registration events - Centralized menu handling
RegisterNetEvent('mns-UwUCafe:client:DrinkMenu', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: DrinkMenu triggered")
    end
    
    -- Check job and duty
    if PlayerData.job.name ~= Config.Job or not PlayerData.job.onduty then
        QBCore.Functions.Notify("You must be an on-duty UwU employee to use the coffee machine.", "error")
        return
    end
    
    -- First show machine preparation animation and progress bar
    RequestAnimDict("anim@heists@prison_heiststation@cop_reactions")
    while not HasAnimDictLoaded("anim@heists@prison_heiststation@cop_reactions") do
        Wait(10)
    end
    
    QBCore.Functions.Progressbar("uwu_prep_coffee_machine", "Starting coffee machine...", 3500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flags = 49,
    }, {}, {}, function() -- Done
        QBCore.Functions.Notify("Coffee machine ready to use!", "success", 2000)
        
        -- Menu options
        local DrinkItems = {
            {
                header = "UwU Café Drinks",
                isMenuHeader = true
            },
            -- Coffee section
            {
                header = "☕ Coffee",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Regular Coffee",
                txt = "Required: Coffee Beans, Water",
                params = {
                    event = "mns-UwUCafe:client:MakeCoffee"
                }
            },
            {
                header = "Latte",
                txt = "Required: Coffee Beans, Milk",
                params = {
                    event = "mns-UwUCafe:client:MakeLatte"
                }
            },
            -- Bubble Tea section
            {
                header = "🧋 Bubble Tea",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Blackberry Bubble Tea",
                txt = "Required: Tea, Sugar, Blackberries, Tapioca",
                params = {
                    event = "mns-UwUCafe:client:MakeBlackberryBubbleTea"
                }
            },
            {
                header = "Strawberry Bubble Tea",
                txt = "Required: Tea, Sugar, Strawberries, Tapioca",
                params = {
                    event = "mns-UwUCafe:client:MakeStrawberryBubbleTea"
                }
            },
            {
                header = "Mint Bubble Tea",
                txt = "Required: Tea, Sugar, Mint, Tapioca",
                params = {
                    event = "mns-UwUCafe:client:MakeMintBubbleTea"
                }
            },
            -- Milkshake section
            {
                header = "🥤 Milkshakes",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Strawberry Milkshake",
                txt = "Required: Milk, Sugar, Strawberries",
                params = {
                    event = "mns-UwUCafe:client:MakeStrawberryMilkshake"
                }
            },
            {
                header = "Chocolate Milkshake",
                txt = "Required: Milk, Sugar, Chocolate",
                params = {
                    event = "mns-UwUCafe:client:MakeChocolateMilkshake"
                }
            },
            {
                header = "Close Menu",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            },
        }
        exports['qb-menu']:openMenu(DrinkItems)
    end, function() -- Cancelled
        QBCore.Functions.Notify("You stopped using the coffee machine.", "error")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent('mns-UwUCafe:client:FoodMenu', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: FoodMenu triggered")
    end
    
    -- Check job and duty
    if PlayerData.job.name ~= Config.Job or not PlayerData.job.onduty then
        QBCore.Functions.Notify("You must be an on-duty UwU employee to use the stove.", "error")
        return
    end
    
    -- First show "pre-heating" animation and progress bar
    RequestAnimDict("amb@prop_human_bbq@male@idle_a")
    while not HasAnimDictLoaded("amb@prop_human_bbq@male@idle_a") do
        Wait(10)
    end
    
    QBCore.Functions.Progressbar("uwu_preheat_stove", "Pre-heating stove...", 3000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_b",
        flags = 49,
    }, {}, {}, function() -- Done
        QBCore.Functions.Notify("Stove ready for cooking!", "success", 2000)
        
        -- Menu options
        local FoodItems = {
            {
                header = "UwU Café Kitchen",
                isMenuHeader = true
            },
            -- Cupcakes section
            {
                header = "🧁 Cupcakes",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Strawberry Cupcake",
                txt = "Required: Flour, Sugar, Strawberries",
                params = {
                    event = "mns-UwUCafe:client:MakeStrawberryCupcake"
                }
            },
            {
                header = "Chocolate Cupcake",
                txt = "Required: Flour, Sugar, Chocolate",
                params = {
                    event = "mns-UwUCafe:client:MakeChocolateCupcake"
                }
            },
            {
                header = "Lemon Cupcake",
                txt = "Required: Flour, Sugar, Lemon",
                params = {
                    event = "mns-UwUCafe:client:MakeLemonCupcake"
                }
            },
            -- Ice Cream section
            {
                header = "🍨 Ice Cream",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Vanilla Ice Cream",
                txt = "Required: Milk, Sugar, Vanilla",
                params = {
                    event = "mns-UwUCafe:client:MakeVanillaIceCream"
                }
            },
            {
                header = "Chocolate Ice Cream",
                txt = "Required: Milk, Sugar, Chocolate",
                params = {
                    event = "mns-UwUCafe:client:MakeChocolateIceCream"
                }
            },
            {
                header = "Strawberry Ice Cream",
                txt = "Required: Milk, Sugar, Strawberries",
                params = {
                    event = "mns-UwUCafe:client:MakeStrawberryIceCream"
                }
            },
            -- Pancakes section
            {
                header = "🥞 Pancakes",
                txt = "Select to prepare",
                isMenuHeader = true
            },
            {
                header = "Nutella Pancake",
                txt = "Required: Flour, Milk, Chocolate",
                params = {
                    event = "mns-UwUCafe:client:MakeNutellaPancake"
                }
            },
            {
                header = "Oreo Pancake",
                txt = "Required: Flour, Milk, Cookies",
                params = {
                    event = "mns-UwUCafe:client:MakeOreoPancake"
                }
            },
            {
                header = "Close Menu",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            },
        }
        exports['qb-menu']:openMenu(FoodItems)
    end, function() -- Cancelled
        QBCore.Functions.Notify("You stopped using the stove.", "error")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent('mns-UwUCafe:client:OpenIngredientShop', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: OpenIngredientShop triggered")
    end
    
    -- Check job and duty
    if PlayerData.job.name ~= Config.Job or not PlayerData.job.onduty then
        QBCore.Functions.Notify("You must be an on-duty UwU employee to purchase ingredients.", "error")
        return
    end
    
    -- Animation for interacting with ingredient supplier
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common") do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 3.0, 3.0, 2000, 50, 0, false, false, false)
    Wait(1000)
    
    -- Shop menu
    local ShopItems = {
        {
            header = "UwU Café Ingredients",
            isMenuHeader = true
        },
        {
            header = "📦 Basic Ingredients",
            txt = "Essential ingredients for recipes",
            isMenuHeader = true
        },
        {
            header = "Flour",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient",
                args = {
                    item = "uwu-flour",
                    price = Config.Prices.Basic or 20,
                    label = "Flour"
                }
            }
        },
        {
            header = "Sugar",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-sugar",
                    price = Config.Prices.Basic or 20,
                    label = "Sugar"
                }
            }
        },
        {
            header = "Milk",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-milk",
                    price = Config.Prices.Basic or 20,
                    label = "Milk"
                }
            }
        },
        {
            header = "Coffee Beans",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-coffeebeans",
                    price = Config.Prices.Basic or 20,
                    label = "Coffee Beans"
                }
            }
        },
        {
            header = "Tea Leaves",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-tea",
                    price = Config.Prices.Basic or 20,
                    label = "Tea Leaves"
                }
            }
        },
        {
            header = "Water",
            txt = "Price: $" .. (Config.Prices.Basic or 20) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-water",
                    price = Config.Prices.Basic or 20,
                    label = "Water"
                }
            }
        },
        {
            header = "🌟 Special Ingredients",
            txt = "Premium ingredients for special recipes",
            isMenuHeader = true
        },
        {
            header = "Strawberries",
            txt = "Price: $" .. (Config.Prices.Special or 40) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-strawberries",
                    price = Config.Prices.Special or 40,
                    label = "Strawberries"
                }
            }
        },
        {
            header = "Chocolate",
            txt = "Price: $" .. (Config.Prices.Special or 40) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-chocolate",
                    price = Config.Prices.Special or 40,
                    label = "Chocolate"
                }
            }
        },
        {
            header = "Vanilla",
            txt = "Price: $" .. (Config.Prices.Special or 40) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-vanilla",
                    price = Config.Prices.Special or 40,
                    label = "Vanilla"
                }
            }
        },
        {
            header = "Tapioca Pearls",
            txt = "Price: $" .. (Config.Prices.Special or 40) .. " each",
            params = {
                event = "mns-UwUCafe:client:PurchaseIngredient", 
                args = {
                    item = "uwu-tapioca",
                    price = Config.Prices.Special or 40,
                    label = "Tapioca Pearls"
                }
            }
        },
        {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        },
    }
    
    exports['qb-menu']:openMenu(ShopItems)
end)

RegisterNetEvent('mns-UwUCafe:client:ViewMenu', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local isEmployee = PlayerData.job.name == Config.Job
    local isOnDuty = isEmployee and PlayerData.job.onduty or false
    
    if Config.Debug then
        print("^3UwU Cafe Debug^7: ViewMenu triggered")
        print("^3UwU Cafe Debug^7: isEmployee = " .. tostring(isEmployee))
        print("^3UwU Cafe Debug^7: isOnDuty = " .. tostring(isOnDuty))
    end
    
    local menu = {
        {
            header = "🐱 UwU Café Menu 🐱",
            txt = "Explore our uwusome treats!",
            isMenuHeader = true
        },
        
        -- Food section
        {
            header = "🍰 Sweet Treats",
            txt = "Our signature desserts",
            isMenuHeader = true
        },
        
        {
            header = "• Cupcakes",
            txt = "Strawberry: $" .. (Config.MenuPrices.Cupcake or 25) .. ", Chocolate: $" .. (Config.MenuPrices.Cupcake or 25) .. ", Lemon: $" .. (Config.MenuPrices.Cupcake or 25),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Cupcakes"
                }
            }
        },
        
        {
            header = "• Ice Cream",
            txt = "Vanilla: $" .. (Config.MenuPrices.IceCream or 30) .. ", Chocolate: $" .. (Config.MenuPrices.IceCream or 30) .. ", Strawberry: $" .. (Config.MenuPrices.IceCream or 30),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Ice Cream"
                }
            }
        },
        
        {
            header = "• Pancakes",
            txt = "Nutella: $" .. (Config.MenuPrices.Pancake or 35) .. ", Oreo: $" .. (Config.MenuPrices.Pancake or 35),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Pancakes"
                }
            }
        },
        
        -- Drinks section
        {
            header = "🥤 Refreshments",
            txt = "Our delicious beverages",
            isMenuHeader = true
        },
        
        {
            header = "• Coffee & Latte",
            txt = "Coffee: $" .. (Config.MenuPrices.Coffee or 20) .. ", Latte: $" .. (Config.MenuPrices.Latte or 30),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Coffee"
                }
            }
        },
        
        {
            header = "• Bubble Tea",
            txt = "Blackberry: $" .. (Config.MenuPrices.BubbleTea or 40) .. ", Strawberry: $" .. (Config.MenuPrices.BubbleTea or 40) .. ", Mint: $" .. (Config.MenuPrices.BubbleTea or 40),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Bubble Tea"
                }
            }
        },
        
        {
            header = "• Milkshakes",
            txt = "Strawberry: $" .. (Config.MenuPrices.Milkshake or 35) .. ", Chocolate: $" .. (Config.MenuPrices.Milkshake or 35),
            params = {
                event = "mns-UwUCafe:client:NotifyNeedEmployee",
                args = {
                    item = "Milkshake"
                }
            }
        },
        
        -- Self-service option for everyone
        {
            header = "🛒 Self-Service",
            txt = "Order items directly",
            params = {
                event = "mns-UwUCafe:client:SelfServiceMenu"
            }
        }
    }
    
    -- Billing option only for employees who are on duty
    if isEmployee and isOnDuty then
        table.insert(menu, {
            header = "💰 Bill Customer",
            txt = "Create a bill for customers",
            params = {
                event = "mns-UwUCafe:client:OpenBillingMenu"
            }
        })
    end
    
    -- Close menu option
    table.insert(menu, {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    })
    
    -- Open the menu
    exports['qb-menu']:openMenu(menu)
end)

-- Self-service menu
RegisterNetEvent('mns-UwUCafe:client:SelfServiceMenu', function()
    local menu = {
        {
            header = "UwU Café Self-Service",
            txt = "Order items directly",
            isMenuHeader = true
        }
    }
    
    -- Add self-service items from config
    if Config.SelfService and Config.SelfService.Enabled and Config.SelfService.Items then
        for item, data in pairs(Config.SelfService.Items) do
            table.insert(menu, {
                header = data.label,
                txt = "Price: $" .. data.price,
                params = {
                    event = "mns-UwUCafe:client:PurchaseMenuItem",
                    args = {
                        item = item,
                        price = data.price,
                        useBank = true -- Set to use bank instead of cash
                    }
                }
            })
        end
    else
        -- Fallback if config is missing
        table.insert(menu, {
            header = "🍓 Strawberry Cupcake",
            txt = "Price: $" .. (Config.MenuPrices.Cupcake or 25) * 1.5,
            params = {
                event = "mns-UwUCafe:client:PurchaseMenuItem",
                args = {
                    item = "strawberry-cupcake",
                    price = (Config.MenuPrices.Cupcake or 25) * 1.5,
                    useBank = true
                }
            }
        })
        
        table.insert(menu, {
            header = "☕ Coffee",
            txt = "Price: $" .. (Config.MenuPrices.Coffee or 20) * 1.5,
            params = {
                event = "mns-UwUCafe:client:PurchaseMenuItem",
                args = {
                    item = "uwu-coffee",
                    price = (Config.MenuPrices.Coffee or 20) * 1.5,
                    useBank = true
                }
            }
        })
    end
    
    -- Back option
    table.insert(menu, {
        header = "⬅️ Back",
        txt = "Return to main menu",
        params = {
            event = "mns-UwUCafe:client:ViewMenu"
        }
    })
    
    exports['qb-menu']:openMenu(menu)
end)

-- Billing menu with back button
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

-- Notify for customer
RegisterNetEvent('mns-UwUCafe:client:NotifyNeedEmployee', function(data)
    QBCore.Functions.Notify("You need an employee to make " .. data.item .. " for you.", "primary", 5000)
    
    -- Play a small animation of looking at the menu
    RequestAnimDict("anim@amb@board_room@whiteboard@")
    while not HasAnimDictLoaded("anim@amb@board_room@whiteboard@") do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "anim@amb@board_room@whiteboard@", "think_01_amy_skater_01", 3.0, 3.0, -1, 50, 0, false, false, false)
    Wait(3000)
    ClearPedTasks(PlayerPedId())
end)

-- Initialize when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    -- Create blips
    CreateBlips()
    
    -- Create NPCs if enabled
    if Config.UsePed then
        CreatePeds()
    end
    
    -- Spawn cats
    SpawnCafeCats()
    
    if Config.Debug then
        print("^2UwU Cafe^7: Client script loaded")
    end
end)

-- Clean up resources on resource stop
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, catPed in pairs(spawnedCats) do
            if DoesEntityExist(catPed) then
                DeleteEntity(catPed)
            end
        end
        
        if DoesEntityExist(ingredientSellerPed) then
            DeleteEntity(ingredientSellerPed)
        end
    end
end)

-- On player unload
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    onDuty = false
    
    -- Clean up peds
    for _, catPed in pairs(spawnedCats) do
        if DoesEntityExist(catPed) then
            DeleteEntity(catPed)
        end
    end
    spawnedCats = {}
    
    if DoesEntityExist(ingredientSellerPed) then
        DeleteEntity(ingredientSellerPed)
        ingredientSellerPed = nil
    end
end)

-- Manual initialization for elements that might not spawn correctly
CreateThread(function()
    -- Wait for resource to fully initialize
    Wait(3000)
    
    -- Check if blips and cats should be created if player has already loaded
    if isLoggedIn then
        -- Create blips if needed
        if #spawnedCats == 0 then
            SpawnCafeCats()
        end
        
        -- Create ped if needed
        if Config.UsePed and not DoesEntityExist(ingredientSellerPed) then
            CreatePeds()
        end
    end
end)