Config = {}

-- Debug mode (set to true for development, false for production)
Config.Debug = false

-- Job name in QBCore
Config.Job = "uwu"

-- Target system to use ('qb-target' or 'ox_target')
Config.Target = "ox_target"

-- Inventory system ('qb-inventory', 'ox_inventory', or 'ps-inventory')
Config.Inventory = "qb-inventory"

-- UI/Menu system ('qb-menu')
Config.UI = "qb-menu"

-- Required job grades for specific actions
Config.RequiredGrades = {
    CreateItems = 0,  -- Minimum job grade to craft items
    BossMenu = 4,     -- Minimum job grade to access boss menu
    ViewSafe = 3,     -- Minimum job grade to access safe
    Billing = 0       -- Minimum job grade to bill customers
}

-- Cat model for pet interactions
Config.CatModel = "a_c_cat_01"

-- NPC Configurations
Config.UsePed = true  -- Whether to spawn NPCs
Config.Ped = {
    model = "u_f_y_dancerave_01",  -- Supplier model
    coords = vector4(-587.89, -1064.77, 22.34, 269.94),  -- Location with heading
    scenario = "WORLD_HUMAN_CLIPBOARD"  -- Animation to play
}

-- Main location (for blip and other features)
Config.Location = vector3(-582.18, -1062.88, 22.34)

-- Blip Configuration
Config.UseBlip = true
Config.Blip = {
    sprite = 621,    -- Blip icon
    color = 41,      -- Blip color
    scale = 0.7,     -- Blip size
    display = 4,     -- Blip display mode
    shortRange = true,  -- Only show blip in short range
    name = "UwU Café"   -- Blip label
}

-- Menu Prices for display and billing (adjust as needed)
Config.MenuPrices = {
    -- Food
    Cupcake = 25,
    IceCream = 30,
    Pancake = 35,
    Muffin = 30,
    Waffle = 35,
    ChickenPastry = 40,
    
    -- Drinks
    Coffee = 20,
    Latte = 30,
    BubbleTea = 40,
    Milkshake = 35
}

-- Self-service item prices (available to everyone)
Config.SelfService = {
    Enabled = true,
    SelfServiceMarkup = 1.5,
    Items = {
        -- Update these to match your QB Core shared items exactly
        ["strawberry_cupcake"] = { price = 38, label = "Strawberry Cupcake" },  -- Note underscore
        ["chocolate_cupcake"] = { price = 38, label = "Chocolate Cupcake" },    -- Note underscore
        ["lemon_cupcake"] = { price = 38, label = "Lemon Cupcake" },           -- Note underscore
        ["uwu_coffee"] = { price = 30, label = "UwU Coffee" },                 -- Note underscore
        ["uwu_latte"] = { price = 45, label = "UwU Latte" }                    -- Note underscore
    }
}

-- Ingredient purchasing prices
Config.Prices = {
    Basic = 20,     -- Basic ingredients like flour, sugar
    Special = 50,   -- Special ingredients like strawberries, chocolate
    Premium = 100   -- Premium ingredients
}

-- Recipes for all craftable items
Config.Recipes = {
    -- Cupcakes
    StrawberryCupcake = {
        receivedItem = "strawberry_cupcake",
        requiredItems = {"uwu_flour", "uwu_sugar", "uwu_strawberries"}
    },
    
    ChocolateCupcake = {
        receivedItem = "chocolate_cupcake",
        requiredItems = {"uwu_flour", "uwu_sugar", "uwu_chocolate"}
    },
    
    LemonCupcake = {
        receivedItem = "lemon_cupcake",
        requiredItems = {"uwu_flour", "uwu_sugar", "uwu_lemon"}
    },
    
    -- Ice Cream
    StrawberryIceCream = {
        receivedItem = "strawberry_icecream",
        requiredItems = {"uwu_milk", "uwu_sugar", "uwu_strawberries"}
    },
    
    ChocolateIceCream = {
        receivedItem = "chocolate_icecream",
        requiredItems = {"uwu_milk", "uwu_sugar", "uwu_chocolate"}
    },
    
    VanillaIceCream = {
        receivedItem = "vanilla_icecream",
        requiredItems = {"uwu_milk", "uwu_sugar", "uwu_vanilla"}
    },
    
    -- Pancakes
    NutellaPancake = {
        receivedItem = "nutella_pancake",
        requiredItems = {"uwu_flour", "uwu_milk", "uwu_chocolate"}
    },
    
    OreoPancake = {
        receivedItem = "oreo_pancake",
        requiredItems = {"uwu_flour", "uwu_milk", "uwu_cookies"}
    },
    
    -- Waffles
    NutellaWaffle = {
        receivedItem = "nutella_waffle",
        requiredItems = {"uwu_flour", "uwu_milk", "uwu_chocolate"}
    },
    
    -- Chicken Pastry
    ChickenPastry = {
        receivedItem = "chicken_pastry",
        requiredItems = {"uwu_flour", "uwu_sugar", "uwu_chicken"}
    },
    
    -- Muffins
    ChocolateMuffin = {
        receivedItem = "chocolate_muffin",
        requiredItems = {"uwu_flour", "uwu_sugar", "uwu_chocolate"}
    },
    
    -- Coffee and Tea
    Coffee = {
        receivedItem = "uwu_coffee",
        requiredItems = {"uwu_coffeebeans", "uwu_water"}
    },
    
    Latte = {
        receivedItem = "uwu_latte",
        requiredItems = {"uwu_coffeebeans", "uwu_milk"}
    },
    
    -- Bubble Tea
    BlackberryBubbleTea = {
        receivedItem = "blackberry_bubble_tea",
        requiredItems = {"uwu_tea", "uwu_sugar", "uwu_blackberries", "uwu_tapioca"}
    },
    
    StrawberryBubbleTea = {
        receivedItem = "strawberry_bubble_tea",
        requiredItems = {"uwu_tea", "uwu_sugar", "uwu_strawberries", "uwu_tapioca"}
    },
    
    MintBubbleTea = {
        receivedItem = "mint_bubble_tea",
        requiredItems = {"uwu_tea", "uwu_sugar", "uwu_mint", "uwu_tapioca"}
    },
    
    -- Milkshakes
    StrawberryMilkshake = {
        receivedItem = "strawberry_milkshake",
        requiredItems = {"uwu_milk", "uwu_sugar", "uwu_strawberries"}
    },
    
    ChocolateMilkshake = {
        receivedItem = "chocolate_milkshake",
        requiredItems = {"uwu_milk", "uwu_sugar", "uwu_chocolate"}
    }
}

-- Consumption effects for food and drinks
Config.ConsumptionEffects = {
    -- Food
    Cupcake = {
        hunger = 15,
        thirst = 0,
        stress = -3,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    IceCream = {
        hunger = 10,
        thirst = 5,
        stress = -5,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    Pancake = {
        hunger = 20,
        thirst = 0,
        stress = -3,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    ChickenPastel = {
        hunger = 30,
        thirst = 0,
        stress = -5,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    Muffin = {
        hunger = 15,
        thirst = 0,
        stress = -4,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    Waffle = {
        hunger = 25,
        thirst = 0,
        stress = -5,
        animations = {
            dict = "mp_player_inteat@burger",
            anim = "mp_player_int_eat_burger",
            flags = 49,
            duration = 5000
        }
    },
    
    -- Drinks
    Coffee = {
        hunger = 0,
        thirst = 15,
        stress = -5,
        animations = {
            dict = "amb@world_human_drinking@coffee@male@idle_a",
            anim = "idle_c",
            flags = 49,
            duration = 6000
        }
    },
    
    Latte = {
        hunger = 5,
        thirst = 20,
        stress = -6,
        animations = {
            dict = "amb@world_human_drinking@coffee@male@idle_a",
            anim = "idle_c",
            flags = 49,
            duration = 6000
        }
    },
    
    BubbleTea = {
        hunger = 5,
        thirst = 25,
        stress = -8,
        animations = {
            dict = "amb@world_human_drinking@coffee@male@idle_a",
            anim = "idle_c",
            flags = 49,
            duration = 6000
        }
    },
    
    Milkshake = {
        hunger = 10,
        thirst = 20,
        stress = -7,
        animations = {
            dict = "amb@world_human_drinking@coffee@male@idle_a",
            anim = "idle_c",
            flags = 49,
            duration = 6000
        }
    }
}

-- Stash configurations
Config.Stashes = {
    Storage = {
        slots = 40,
        weight = 250000,
        label = "UwU Café Storage"
    },
    FoodFridge = {
        slots = 40,
        weight = 250000,
        label = "UwU Café Food Fridge"
    },
    IngredientFridge = {
        slots = 40,
        weight = 250000,
        label = "UwU Café Ingredient Fridge"
    },
    Counter = {
        slots = 20,
        weight = 100000,
        label = "UwU Café Counter"
    },
    Tray1 = {
        slots = 6,
        weight = 10000,
        label = "UwU Café Tray 1"
    },
    Tray2 = {
        slots = 6,
        weight = 10000,
        label = "UwU Café Tray 2"
    }
}

-- Cat spawns - locations where cats can be found in UwU Café
Config.CatSpawns = {
    vector4(-578.34, -1051.04, 21.59, 89.38),
    vector4(-579.92, -1063.41, 21.34, 179.37),
    vector4(-590.0, -1067.81, 21.54, 269.65),
    vector4(-584.27, -1052.45, 21.85, 153.08),
    vector4(-592.73, -1058.5, 21.74, 354.16)
}

-- Cat petting - stress relief per pet
Config.PetCatStressRelief = 5

-- Animation configurations for crafting
Config.Animations = {
    -- Cooking/crafting animations
    Cooking = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_b",
        flags = 16
    },
    
    -- Coffee machine animations
    CoffeeMachine = {
        dict = "anim@heists@prison_heiststation@cop_reactions",
        anim = "cop_b_idle",
        flags = 16
    },
    
    -- Eating animations
    Eating = {
        dict = "mp_player_inteat@burger",
        anim = "mp_player_int_eat_burger",
        flags = 49
    },
    
    -- Drinking animations
    Drinking = {
        dict = "amb@world_human_drinking@coffee@male@idle_a",
        anim = "idle_c",
        flags = 49
    },
    
    -- Pet cat animation
    PetCat = {
        dict = "amb@medic@standing@kneel@base",
        anim = "base",
        flags = 1
    }
}

-- Badge styles for displaying job status (currently not used but could be integrated)
Config.BadgeStyle = {
    ["uwu"] = {
        ["male"] = {
            outfitData = {
                ["accessory"] = { item = 131, texture = 0 },
            }
        },
        ["female"] = {
            outfitData = {
                ["accessory"] = { item = 97, texture = 0 },
            }
        }
    }
}

-- Outfit configurations for job uniforms
Config.Outfits = {
    ["male"] = {
        ["uwu_uniform"] = {
            outfitLabel = "UwU Male Uniform",
            outfitData = {
                ["pants"] = { item = 4, texture = 0 },
                ["arms"] = { item = 4, texture = 0 },
                ["t-shirt"] = { item = 29, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["torso2"] = { item = 107, texture = 2 },
                ["shoes"] = { item = 10, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["hat"] = { item = 28, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["mask"] = { item = 0, texture = 0 }
            }
        }
    },
    ["female"] = {
        ["uwu_uniform"] = {
            outfitLabel = "UwU Female Uniform",
            outfitData = {
                ["pants"] = { item = 57, texture = 0 },
                ["arms"] = { item = 4, texture = 0 },
                ["t-shirt"] = { item = 34, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["torso2"] = { item = 112, texture = 0 },
                ["shoes"] = { item = 52, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["hat"] = { item = 28, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["mask"] = { item = 0, texture = 0 }
            }
        }
    }
}