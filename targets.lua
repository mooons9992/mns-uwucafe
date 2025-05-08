local QBCore = exports['qb-core']:GetCoreObject()

-- Initialize the global toggle duty flag (prevents multiple clicks)
_G.toggleDutyInProgress = false

-- Debug which target system is being used
CreateThread(function()
    if Config.Debug then
        print("^2UwU Cafe^7: Setting up targets")
    end
    
    -- Check which target system is being used
    local targetSystem = Config.Target or 'qb-target'
    local useOxTarget = targetSystem == 'ox_target'
    
    if Config.Debug then
        print("^2UwU Cafe^7: Using target system: " .. targetSystem)
        if useOxTarget then 
            print("^2UwU Cafe^7: OX Target detected - using specific format")
        end
    end
    
    -- Function to add box zones with the appropriate target system
    local function AddBoxZone(name, coords, length, width, options)
        if useOxTarget then
            -- ox_target format - Fixed format for ox_target boxZone
            exports.ox_target:addBoxZone({
                coords = vector3(coords.x, coords.y, coords.z),
                size = vector3(length, width, options.data.maxZ - options.data.minZ),
                rotation = options.data.heading,
                debug = options.data.debugPoly,
                options = options.options
            })
        else
            -- qb-target format
            exports['qb-target']:AddBoxZone(
                name, 
                coords, 
                length, 
                width, 
                options.data, 
                options.options
            )
        end
    end
    
    -- Function to add target models with the appropriate target system
    local function AddTargetModel(model, options)
        if useOxTarget then
            -- ox_target format - Fixed format for ox_target model
            exports.ox_target:addModel(model, options)
        else
            -- qb-target format
            exports['qb-target']:AddTargetModel(model, {
                options = options,
                distance = 2.0
            })
        end
    end
    
    -- UwU Café Service Point
    AddBoxZone("uwu-service", vector3(-593.99, -1052.34, 22.34), 1, 1.2, {
        data = {
            name = "uwu-service",
            heading = 91,
            debugPoly = Config.Debug,
            minZ = 21.0,
            maxZ = 24.6,
        },
        options = {
            {  
                name = 'uwu_duty',  
                event = "mns-UwUCafe:client:ToggleDuty",
                icon = "fas fa-clipboard-check",
                label = "Toggle Duty", -- Static label first
                job = Config.Job,
                type = "client",
                canInteract = function()
                    -- First check if toggle is already in progress
                    if _G.toggleDutyInProgress then 
                        return false 
                    end
                    return true
                end,
                onSelect = function()
                    -- This is called for ox_target specifically
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    if PlayerData.job.onduty then
                        TriggerEvent("mns-UwUCafe:client:ToggleDuty")
                    else
                        TriggerEvent("mns-UwUCafe:client:ToggleDuty")
                    end
                end
            }
        }
    })

    -- Fix for qb-target duty label
    if not useOxTarget then
        exports['qb-target']:AddBoxZone(
            "uwu-service-label", 
            vector3(-593.99, -1052.34, 22.34), 
            1, 
            1.2, 
            {
                name = "uwu-service-label",
                heading = 91,
                debugPoly = false,
                minZ = 21.0,
                maxZ = 24.6,
            }, 
            {
                options = {
                    {  
                        type = "client",
                        event = "mns-UwUCafe:client:ToggleDuty",
                        icon = "fas fa-clipboard-check",
                        label = function()
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            return PlayerData.job.onduty and "Clock Out" or "Clock In"
                        end,
                        job = Config.Job,
                        canInteract = function()
                            if _G.toggleDutyInProgress then 
                                return false 
                            end
                            return true
                        end,
                    }
                },
                distance = 2.0
            }
        )
    end

    -- UwU Café Menu Board - Simplified single point for all menu interactions
    AddBoxZone("uwu-menu", vector3(-584.25, -1061.5, 22.37), 0.6, 0.5, {
        data = {
            name = "uwu-menu",
            heading = 270,
            debugPoly = Config.Debug,
            minZ = 22.2,
            maxZ = 22.6,
        },
        options = {
            {
                name = 'uwu_menu', 
                event = "mns-UwUCafe:client:ViewMenu",
                icon = "fas fa-clipboard-list",
                label = "See Menu",
                type = "client",
            }
        }
    })

    -- Pet Cat Model Target - Fixed for both systems
    AddTargetModel(Config.CatModel, {
        {
            name = 'pet_cat',
            event = 'mns-UwUCafe:client:PetCat',
            icon = 'fas fa-cat',
            label = 'Pet Cat',
            type = 'client',
            distance = 2.0
        }
    })

    -- UwU Café Stove
    AddBoxZone("uwu-stove", vector3(-590.95, -1056.56, 22.28), 0.7, 1.5, {
        data = {
            name = "uwu-stove",
            heading = 91.25,
            debugPoly = Config.Debug,
            minZ = 21.3,
            maxZ = 22.9,
        },
        options = {
            {
                name = 'uwu_stove',
                event = "mns-UwUCafe:client:FoodMenu",
                icon = "fas fa-fire",
                label = "Use Stove",
                job = Config.Job,
                type = "client",
                canInteract = function()
                    local Player = QBCore.Functions.GetPlayerData()
                    if Config.Debug then
                        print("^3UwU Cafe Debug^7: Checking stove access - Job: " .. Player.job.name .. ", OnDuty: " .. tostring(Player.job.onduty))
                    end
                    return Player.job.name == Config.Job and Player.job.onduty
                end,
            }
        }
    })

    -- UwU Café Drinks Machine
    AddBoxZone("uwu-drinks", vector3(-586.95, -1061.92, 22.34), 1, 1, {
        data = {
            name = "uwu-drinks",
            heading = 0,
            debugPoly = Config.Debug,
            minZ = 22.0,
            maxZ = 23.0,
        },
        options = {
            {
                name = 'uwu_drinks',
                event = "mns-UwUCafe:client:DrinkMenu",
                icon = "fas fa-mug-hot",
                label = "Use Coffee Machine",
                job = Config.Job,
                type = "client",
                canInteract = function()
                    local Player = QBCore.Functions.GetPlayerData()
                    if Config.Debug then
                        print("^3UwU Cafe Debug^7: Checking coffee machine access - Job: " .. Player.job.name .. ", OnDuty: " .. tostring(Player.job.onduty))
                    end
                    return Player.job.name == Config.Job and Player.job.onduty
                end,
            }
        }
    })
    
    -- UwU Café Clothes
    AddBoxZone("uwu-clothes", vector3(-585.91, -1050.11, 22.36), 1.5, 1, {
        data = {
            name = "uwu-clothes",
            heading = 0,
            debugPoly = Config.Debug,
            minZ = 21.4,
            maxZ = 23.4,
        },
        options = {
            {
                name = 'uwu_clothes',
                event = "qb-clothing:client:openOutfitMenu",
                icon = "fas fa-tshirt",
                label = "Change Clothes",
                type = "client",
            }
        }
    })

    -- Boss Menu
    AddBoxZone("uwu-boss", vector3(-578.91, -1062.01, 26.61), 1.4, 1.1, {
        data = {
            name = "uwu-boss",
            heading = 0,
            debugPoly = Config.Debug,
            minZ = 26.0,
            maxZ = 27.2,
        },
        options = {
            {
                name = 'uwu_boss', 
                event = "qb-bossmenu:client:OpenMenu",
                icon = "fas fa-chart-line",
                label = "Boss Menu",
                job = Config.Job,
                type = "client",
                canInteract = function()
                    local Player = QBCore.Functions.GetPlayerData()
                    if Config.Debug then
                        print("^3UwU Cafe Debug^7: Checking boss menu access - Job: " .. Player.job.name .. ", Grade: " .. Player.job.grade.level)
                    end
                    return Player.job.name == Config.Job and Player.job.grade.level >= Config.RequiredGrades.BossMenu
                end,
            }
        }
    })

    -- Ingredient Shop Zone
    if Config.UsePed then
        if Config.Ped and Config.Ped.coords then
            AddBoxZone("uwu-ingredients-shop", vector3(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z), 1.0, 1.0, {
                data = {
                    name = "uwu-ingredients-shop",
                    heading = 0,
                    debugPoly = Config.Debug,
                    minZ = Config.Ped.coords.z - 1.0,
                    maxZ = Config.Ped.coords.z + 1.0,
                },
                options = {
                    {
                        name = 'uwu_shop',
                        event = "mns-UwUCafe:client:OpenIngredientShop",
                        icon = "fas fa-shopping-basket",
                        label = "Order Ingredients",
                        job = Config.Job,
                        type = "client",
                        canInteract = function()
                            local Player = QBCore.Functions.GetPlayerData()
                            if Config.Debug then
                                print("^3UwU Cafe Debug^7: Checking ingredient shop access - Job: " .. Player.job.name .. ", OnDuty: " .. tostring(Player.job.onduty))
                            end
                            return Player.job.name == Config.Job and Player.job.onduty
                        end,
                    }
                }
            })
        else
            if Config.Debug then
                print("^3UwU Cafe^7: Ped target zone skipped - Config.Ped coords not found")
            end
        end
    end

    if Config.Debug then
        print("^2UwU Cafe^7: All targets set up successfully")
    end
end)