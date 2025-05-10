# UwU Cat Cafe

A complete resource for Gabz UwU Cat Cafe map for QBCore Framework with fully configurable options.

## Preview
Preview coming soon...

## Features

- Complete job system for UwU Cat Cafe
- Configurable recipes, prices, and effects
- Multiple food and drink preparation workflows
- Billing system integration
- Employee management with boss menu
- Ingredient purchasing from vendor
- Interactive cat petting system
- Self-service menu for customers
- Multiple food and drink items with effects
- Job grades and duty management

## Installation Guide

### 1. Add Items to `qb-core/shared/items.lua`

```lua
-- UwU Cafe Ingredients
uwu_flour                    = { name = 'uwu_flour', label = 'Flour Package', weight = 1500, type = 'item', image = 'uwu_flour.png', unique = false, useable = true, shouldClose = true, description = 'A package of flour' },
uwu_sugar                    = { name = 'uwu_sugar', label = 'Sugar Pack', weight = 1500, type = 'item', image = 'uwu_sugar.png', unique = false, useable = true, shouldClose = true, description = 'Sweet sugar' },
uwu_milk                     = { name = 'uwu_milk', label = 'Milk Pack', weight = 1500, type = 'item', image = 'uwu_milk.png', unique = false, useable = true, shouldClose = true, description = 'Fresh milk pack' },
uwu_butter                   = { name = 'uwu_butter', label = 'Butter Bar', weight = 1500, type = 'item', image = 'uwu_butter.png', unique = false, useable = true, shouldClose = true, description = 'A bar of butter' },
uwu_chocolate                = { name = 'uwu_chocolate', label = 'Chocolate Bar', weight = 1500, type = 'item', image = 'uwu_chocolate.png', unique = false, useable = true, shouldClose = true, description = 'A delicious chocolate bar' },
uwu_strawberries             = { name = 'uwu_strawberries', label = 'Box of Strawberries', weight = 1500, type = 'item', image = 'uwu_strawberries.png', unique = false, useable = true, shouldClose = true, description = 'Fresh strawberries' },
uwu_blackberries             = { name = 'uwu_blackberries', label = 'Box of Blackberries', weight = 1500, type = 'item', image = 'uwu_blackberries.png', unique = false, useable = true, shouldClose = true, description = 'Fresh blackberries' },
uwu_cream                    = { name = 'uwu_cream', label = 'Package of Cream', weight = 1500, type = 'item', image = 'uwu_cream.png', unique = false, useable = true, shouldClose = true, description = 'Fresh cream' },
uwu_condensed_milk           = { name = 'uwu_condensed_milk', label = 'Condensed Milk', weight = 1500, type = 'item', image = 'uwu_condensed_milk.png', unique = false, useable = true, shouldClose = true, description = 'Sweet condensed milk' },
uwu_vanilla                  = { name = 'uwu_vanilla', label = 'Vanilla Extract', weight = 1500, type = 'item', image = 'uwu_vanilla.png', unique = false, useable = true, shouldClose = true, description = 'Vanilla flavoring' },
uwu_lemon                    = { name = 'uwu_lemon', label = 'Lemon', weight = 1500, type = 'item', image = 'uwu_lemon.png', unique = false, useable = true, shouldClose = true, description = 'Fresh lemon' },
uwu_nutella                  = { name = 'uwu_nutella', label = 'Jar of Nutella', weight = 1500, type = 'item', image = 'uwu_nutella.png', unique = false, useable = true, shouldClose = true, description = 'Chocolate hazelnut spread' },
uwu_cookies                  = { name = 'uwu_cookies', label = 'Oreo Pack', weight = 1500, type = 'item', image = 'uwu_cookies.png', unique = false, useable = true, shouldClose = true, description = 'Chocolate sandwich cookies' },
uwu_mint                     = { name = 'uwu_mint', label = 'Mint Extract', weight = 1500, type = 'item', image = 'uwu_mint.png', unique = false, useable = true, shouldClose = true, description = 'Mint flavoring' },
uwu_coffeebeans              = { name = 'uwu_coffeebeans', label = 'Coffee Beans', weight = 1500, type = 'item', image = 'uwu_coffeebeans.png', unique = false, useable = true, shouldClose = true, description = 'Coffee beans' },
uwu_chicken                  = { name = 'uwu_chicken', label = 'Chicken', weight = 1500, type = 'item', image = 'uwu_chicken.png', unique = false, useable = true, shouldClose = true, description = 'Raw chicken' },
uwu_tea                      = { name = 'uwu_tea', label = 'Tea Leaves', weight = 1500, type = 'item', image = 'uwu_tea.png', unique = false, useable = true, shouldClose = true, description = 'Tea leaves' },
uwu_tapioca                  = { name = 'uwu_tapioca', label = 'Tapioca Pearls', weight = 1500, type = 'item', image = 'uwu_tapioca.png', unique = false, useable = true, shouldClose = true, description = 'Tapioca pearls for bubble tea' },
uwu_water                    = { name = 'uwu_water', label = 'Filtered Water', weight = 1500, type = 'item', image = 'water_bottle.png', unique = false, useable = true, shouldClose = true, description = 'Filtered water' },

-- UwU Cafe Foods
strawberry_cupcake           = { name = 'strawberry_cupcake', label = 'Strawberry Cupcake', weight = 1000, type = 'item', image = 'strawberry_cupcake.png', unique = false, useable = true, shouldClose = true, description = 'Delicious strawberry cupcake' },
chocolate_cupcake            = { name = 'chocolate_cupcake', label = 'Chocolate Cupcake', weight = 1000, type = 'item', image = 'chocolate_cupcake.png', unique = false, useable = true, shouldClose = true, description = 'Delicious chocolate cupcake' },
lemon_cupcake                = { name = 'lemon_cupcake', label = 'Lemon Cupcake', weight = 1000, type = 'item', image = 'lemon_cupcake.png', unique = false, useable = true, shouldClose = true, description = 'Delicious lemon cupcake' },
strawberry_icecream          = { name = 'strawberry_icecream', label = 'Strawberry Ice Cream', weight = 1000, type = 'item', image = 'strawberry_icecream.png', unique = false, useable = true, shouldClose = true, description = 'Sweet strawberry ice cream' },
chocolate_icecream           = { name = 'chocolate_icecream', label = 'Chocolate Ice Cream', weight = 1000, type = 'item', image = 'chocolate_icecream.png', unique = false, useable = true, shouldClose = true, description = 'Sweet chocolate ice cream' },
vanilla_icecream             = { name = 'vanilla_icecream', label = 'Vanilla Ice Cream', weight = 1000, type = 'item', image = 'vanilla_icecream.png', unique = false, useable = true, shouldClose = true, description = 'Sweet vanilla ice cream' },
nutella_pancake              = { name = 'nutella_pancake', label = 'Nutella Pancake', weight = 1000, type = 'item', image = 'nutella_pancake.png', unique = false, useable = true, shouldClose = true, description = 'Fluffy pancake with nutella' },
oreo_pancake                 = { name = 'oreo_pancake', label = 'Oreo Pancake', weight = 1000, type = 'item', image = 'oreo_pancake.png', unique = false, useable = true, shouldClose = true, description = 'Fluffy pancake with oreos' },
nutella_waffle               = { name = 'nutella_waffle', label = 'Nutella Waffle', weight = 1000, type = 'item', image = 'nutella_waffle.png', unique = false, useable = true, shouldClose = true, description = 'Crispy waffle with nutella' },
chicken_pastry               = { name = 'chicken_pastry', label = 'Chicken Pastry', weight = 1000, type = 'item', image = 'chicken_pastry.png', unique = false, useable = true, shouldClose = true, description = 'Savory chicken pastry' },
chocolate_muffin             = { name = 'chocolate_muffin', label = 'Chocolate Muffin', weight = 1000, type = 'item', image = 'chocolate_muffin.png', unique = false, useable = true, shouldClose = true, description = 'Rich chocolate muffin' },

-- UwU Cafe Drinks
uwu_coffee                   = { name = 'uwu_coffee', label = 'UwU Coffee', weight = 1000, type = 'item', image = 'uwu_coffee.png', unique = false, useable = true, shouldClose = true, description = 'Delicious coffee' },
uwu_latte                    = { name = 'uwu_latte', label = 'UwU Latte', weight = 1000, type = 'item', image = 'uwu_latte.png', unique = false, useable = true, shouldClose = true, description = 'Delicious latte' },
blackberry_bubble_tea        = { name = 'blackberry_bubble_tea', label = 'Blackberry Bubble Tea', weight = 1000, type = 'item', image = 'blackberry_bubble_tea.png', unique = false, useable = true, shouldClose = true, description = 'Sweet bubble tea with blackberry flavor' },
strawberry_bubble_tea        = { name = 'strawberry_bubble_tea', label = 'Strawberry Bubble Tea', weight = 1000, type = 'item', image = 'strawberry_bubble_tea.png', unique = false, useable = true, shouldClose = true, description = 'Sweet bubble tea with strawberry flavor' },
mint_bubble_tea              = { name = 'mint_bubble_tea', label = 'Mint Bubble Tea', weight = 1000, type = 'item', image = 'mint_bubble_tea.png', unique = false, useable = true, shouldClose = true, description = 'Sweet bubble tea with mint flavor' },
strawberry_milkshake         = { name = 'strawberry_milkshake', label = 'Strawberry Milkshake', weight = 1000, type = 'item', image = 'strawberry_milkshake.png', unique = false, useable = true, shouldClose = true, description = 'Creamy strawberry milkshake' },
chocolate_milkshake          = { name = 'chocolate_milkshake', label = 'Chocolate Milkshake', weight = 1000, type = 'item', image = 'chocolate_milkshake.png', unique = false, useable = true, shouldClose = true, description = 'Creamy chocolate milkshake' },
```

### 2. Image Files
Copy all image files from images folder to your inventory resource images folder (e.g., `qb-inventory/html/images/`).

### 3. Job Configuration
Add the following to `qb-core/shared/jobs.lua`:

```lua
['uwu'] = {
    label = 'UwU Cat Cafe',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Novice',
            payment = 50
        },
        ['1'] = {
            name = 'Employee',
            payment = 75
        },
        ['2'] = {
            name = 'Experienced',
            payment = 100
        },
        ['3'] = {
            name = 'Advanced',
            payment = 125
        },
        ['4'] = {
            name = 'Boss',
            isboss = true,
            payment = 150
        },
    },
    type = "cafe",  -- Required for new QBCore versions
},
```

### 4. Add Consumables Configuration
Add these items to `qb-smallresources/config.lua` under the Config.Consumables section:

```lua
Config.Consumables = {
    eat = { 
        -- Default food items above
        -- ...
        
        -- UwU Cafe Foods
        ['strawberry_cupcake'] = math.random(40, 55),
        ['chocolate_cupcake'] = math.random(40, 55),
        ['lemon_cupcake'] = math.random(40, 55),
        ['strawberry_icecream'] = math.random(35, 50),
        ['chocolate_icecream'] = math.random(35, 50),
        ['vanilla_icecream'] = math.random(35, 50),
        ['nutella_pancake'] = math.random(45, 60),
        ['oreo_pancake'] = math.random(45, 60),
        ['nutella_waffle'] = math.random(45, 60),
        ['chicken_pastry'] = math.random(50, 65),
        ['chocolate_muffin'] = math.random(40, 55),
    },
    
    drink = { 
        -- Default drink items above
        -- ...
        
        -- UwU Cafe Drinks
        ['uwu_coffee'] = math.random(35, 50),
        ['uwu_latte'] = math.random(35, 50),
        ['blackberry_bubble_tea'] = math.random(40, 55),
        ['strawberry_bubble_tea'] = math.random(40, 55),
        ['mint_bubble_tea'] = math.random(40, 55),
        ['strawberry_milkshake'] = math.random(40, 55),
        ['chocolate_milkshake'] = math.random(40, 55),
    },
    
    custom = { 
        -- Custom items with special effects
        
        -- Example for a special bubble tea with stress relief
        ['mint_bubble_tea'] = {
            progress = {
                label = 'Drinking Mint Bubble Tea...',
                time = 5000
            },
            animation = {
                animDict = 'amb@world_human_drinking@coffee@male@idle_a',
                anim = 'idle_c',
                flags = 49,
            },
            prop = {
                model = 'apa_prop_cs_plastic_cup_01',
                bone = 28422,
                coords = vector3(0.0, 0.0, 0.0),
                rotation = vector3(0.0, 0.0, 0.0),
            },
            replenish = {
                type = 'Thirst',
                replenish = math.random(40, 55),
                isAlcohol = false,
                event = 'mns-UwUCafe:client:RemoveStress',
                server = false
            }
        },
        
        -- Example for a special pastry with extra hunger restoration
        ['chicken_pastry'] = {
            progress = {
                label = 'Eating Chicken Pastry...',
                time = 5000
            },
            animation = {
                animDict = 'mp_player_inteat@burger',
                anim = 'mp_player_int_eat_burger',
                flags = 49,
            },
            prop = {
                model = 'prop_sandwich_01',
                bone = 18905,
                coords = vector3(0.13, 0.05, 0.02),
                rotation = vector3(-50.0, 16.0, 60.0),
            },
            replenish = {
                type = 'Hunger',
                replenish = math.random(50, 65),
                isAlcohol = false,
                event = false,
                server = false
            }
        }
    }
}
```

## Configuration

The script is highly configurable through the `config.lua` file:

- Set job name and permissions
- Configure menu prices
- Adjust food and drink effects on hunger, thirst, and stress
- Customize preparation recipes
- Set up shop locations and cat spawns
- Modify blips and target zones

## Dependencies

- QBCore Framework
- qb-target or ox_target (configurable)
- qb-menu
- qb-input
- qb-management - For boss menu
- qb-inventory (or configurable alternative)

## Map Required

This resource is designed to work with Gabz UwU Cat Cafe MLO, which must be purchased separately:

[Gabz UwU Cat Cafe](https://fivem.gabzv.com/package/4724494)


## Credits

- Modified by: Mooons
- Based on: mt-uWuCafe by MT

## Support

For support or feature requests, please open an issue on the GitHub repository.
