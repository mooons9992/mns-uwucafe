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
uwu_flour                     = { name = 'uwu-flour', label = 'Flour Package', weight = 1500, type = 'item', image = 'flour.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A package of flour', decay = 90.0 },
uwu_sugar                     = { name = 'uwu-sugar', label = 'Sugar Pack', weight = 1500, type = 'item', image = 'sugar.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet sugar', decay = 90.0 },
uwu_milk                      = { name = 'uwu-milk', label = 'Milk Pack', weight = 1500, type = 'item', image = 'milk.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fresh milk pack', decay = 14.0 },
uwu_butter                    = { name = 'uwu-butter', label = 'Butter Bar', weight = 1500, type = 'item', image = 'butter.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A bar of butter', decay = 14.0 },
uwu_chocolate                 = { name = 'uwu-chocolate', label = 'Chocolate Bar', weight = 1500, type = 'item', image = 'chocolate.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A delicious chocolate bar', decay = 30.0 },
uwu_strawberries              = { name = 'uwu-strawberries', label = 'Box of Strawberries', weight = 1500, type = 'item', image = 'strawberry.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fresh strawberries', decay = 7.0 },
uwu_blackberries              = { name = 'uwu-blackberries', label = 'Box of Blackberries', weight = 1500, type = 'item', image = 'blackberry.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fresh blackberries', decay = 7.0 },
uwu_cream                     = { name = 'uwu-cream', label = 'Package of Cream', weight = 1500, type = 'item', image = 'cream.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fresh cream', decay = 5.0 },
uwu_condensed_milk            = { name = 'uwu-condensed-milk', label = 'Condensed Milk', weight = 1500, type = 'item', image = 'condensed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet condensed milk', decay = 30.0 },
uwu_vanilla                   = { name = 'uwu-vanilla', label = 'Vanilla Extract', weight = 1500, type = 'item', image = 'vanilla.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Vanilla flavoring', decay = 90.0 },
uwu_lemon                     = { name = 'uwu-lemon', label = 'Lemon', weight = 1500, type = 'item', image = 'lemon.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fresh lemon', decay = 7.0 },
uwu_nutella                   = { name = 'uwu-nutella', label = 'Jar of Nutella', weight = 1500, type = 'item', image = 'nutella.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Chocolate hazelnut spread', decay = 45.0 },
uwu_cookies                   = { name = 'uwu-cookies', label = 'Oreo Pack', weight = 1500, type = 'item', image = 'oreo.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Chocolate sandwich cookies', decay = 30.0 },
uwu_mint                      = { name = 'uwu-mint', label = 'Mint Extract', weight = 1500, type = 'item', image = 'mint.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Mint flavoring', decay = 90.0 },
uwu_coffeebeans               = { name = 'uwu-coffeebeans', label = 'Coffee Beans', weight = 1500, type = 'item', image = 'coffeebeans.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Coffee beans', decay = 60.0 },
uwu_chicken                   = { name = 'uwu-chicken', label = 'Chicken', weight = 1500, type = 'item', image = 'chicken.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Raw chicken', decay = 3.0 },
uwu_tea                       = { name = 'uwu-tea', label = 'Tea Leaves', weight = 1500, type = 'item', image = 'tea.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Tea leaves', decay = 60.0 },
uwu_tapioca                   = { name = 'uwu-tapioca', label = 'Tapioca Pearls', weight = 1500, type = 'item', image = 'tapioca.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Tapioca pearls for bubble tea', decay = 90.0 },
uwu_water                     = { name = 'uwu-water', label = 'Filtered Water', weight = 1500, type = 'item', image = 'water.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Filtered water', decay = 90.0 },

-- UwU Cafe Foods
strawberry_cupcake            = { name = 'strawberry-cupcake', label = 'Strawberry Cupcake', weight = 1000, type = 'item', image = 'strawberry-cupcake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Delicious strawberry cupcake', decay = 2.0 },
chocolate_cupcake             = { name = 'chocolate-cupcake', label = 'Chocolate Cupcake', weight = 1000, type = 'item', image = 'chocolate-cupcake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Delicious chocolate cupcake', decay = 2.0 },
lemon_cupcake                 = { name = 'lemon-cupcake', label = 'Lemon Cupcake', weight = 1000, type = 'item', image = 'lemon-cupcake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Delicious lemon cupcake', decay = 2.0 },
strawberry_icecream           = { name = 'strawberry-icecream', label = 'Strawberry Ice Cream', weight = 1000, type = 'item', image = 'strawberry-icecream.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet strawberry ice cream', decay = 0.5 },
chocolate_icecream            = { name = 'chocolate-icecream', label = 'Chocolate Ice Cream', weight = 1000, type = 'item', image = 'chocolate-icecream.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet chocolate ice cream', decay = 0.5 },
vanilla_icecream              = { name = 'vanilla-icecream', label = 'Vanilla Ice Cream', weight = 1000, type = 'item', image = 'vanilla-icecream.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet vanilla ice cream', decay = 0.5 },
nutella_pancake               = { name = 'nutella-pancake', label = 'Nutella Pancake', weight = 1000, type = 'item', image = 'nutella-pancake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fluffy pancake with nutella', decay = 1.0 },
oreo_pancake                  = { name = 'oreo-pancake', label = 'Oreo Pancake', weight = 1000, type = 'item', image = 'oreo-pancake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Fluffy pancake with oreos', decay = 1.0 },
nutella_waffle                = { name = 'nutella-waffle', label = 'Nutella Waffle', weight = 1000, type = 'item', image = 'nutella-waffle.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Crispy waffle with nutella', decay = 1.0 },
chicken_pastry                = { name = 'chicken-pastry', label = 'Chicken Pastry', weight = 1000, type = 'item', image = 'chicken-pastry.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Savory chicken pastry', decay = 1.5 },
chocolate_muffin              = { name = 'chocolate-muffin', label = 'Chocolate Muffin', weight = 1000, type = 'item', image = 'chocolate-muffin.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Rich chocolate muffin', decay = 2.0 },

-- UwU Cafe Drinks
uwu_coffee                    = { name = 'uwu-coffee', label = 'UwU Coffee', weight = 1000, type = 'item', image = 'uwu-coffee.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Delicious coffee', decay = 0.5 },
uwu_latte                     = { name = 'uwu-latte', label = 'UwU Latte', weight = 1000, type = 'item', image = 'uwu-latte.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Delicious latte', decay = 0.5 },
blackberry_bubble_tea         = { name = 'blackberry-bubble-tea', label = 'Blackberry Bubble Tea', weight = 1000, type = 'item', image = 'blackberry-bubble-tea.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet bubble tea with blackberry flavor', decay = 0.5 },
strawberry_bubble_tea         = { name = 'strawberry-bubble-tea', label = 'Strawberry Bubble Tea', weight = 1000, type = 'item', image = 'strawberry-bubble-tea.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet bubble tea with strawberry flavor', decay = 0.5 },
mint_bubble_tea               = { name = 'mint-bubble-tea', label = 'Mint Bubble Tea', weight = 1000, type = 'item', image = 'mint-bubble-tea.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sweet bubble tea with mint flavor', decay = 0.5 },
strawberry_milkshake          = { name = 'strawberry-milkshake', label = 'Strawberry Milkshake', weight = 1000, type = 'item', image = 'strawberry-milkshake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Creamy strawberry milkshake', decay = 0.5 },
chocolate_milkshake           = { name = 'chocolate-milkshake', label = 'Chocolate Milkshake', weight = 1000, type = 'item', image = 'chocolate-milkshake.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Creamy chocolate milkshake', decay = 0.5 },
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

### 4. Add Emote Animations
Add to `dpemotes/client/AnimationList.lua`:

```lua
["bubbletea"] = {
    "amb@world_human_drinking@coffee@male@idle_a",
    "idle_c",
    "Bubble Tea",
    "bubbletea",
    AnimationOptions = {
        Prop = 'apa_prop_cs_plastic_cup_01',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true
    }
},
["misosoup"] = {
    "amb@world_human_drinking@coffee@male@idle_a",
    "idle_c",
    "Miso Soup",
    "misosoup",
    AnimationOptions = {
        Prop = 'v_ret_247_noodle1',
        PropBone = 28422,
        PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true
    }
},
["uwusandy"] = {
    "mp_player_inteat@burger",
    "mp_player_int_eat_burger",
    "UwU Sandwich",
    "uwusandy",
    AnimationOptions = {
        Prop = 'ng_proc_food_ornge1a',
        PropBone = 18905,
        PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
        EmoteMoving = true
    }
},
["budhabowl"] = {
    "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1",
    "base_idle",
    "Buddha Bowl",
    "budhabowl",
    AnimationOptions = {
        Prop = "prop_cs_bowl_01b",
        PropBone = 60309,
        PropPlacement = {0.0, 0.0300, 0.0100, 0.0, 0.0, 0.0},
        SecondProp = 'h4_prop_h4_caviar_spoon_01a',
        SecondPropBone = 28422,
        SecondPropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteLoop = true,
        EmoteMoving = true
    }
}
```
## Configuration

The script is highly configurable through the config.lua file:

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
- dpemotes - For eat/drink animations
- qb-management - For boss menu
- qb-inventory (or configurable alternative)

## Map Required

This resource is designed to work with Gabz UwU Cat Cafe MLO, which must be purchased separately:

[Gabz UwU Cat Cafe](https://fivem.gabzv.com/package/4724494)

## Notable Changes in This Version

- **Storage System Update**: Storage targets have been removed but functions remain for compatibility
- **Self-Service Menu**: Players can now purchase items directly without requiring employee assistance
- **Bank Transaction Support**: Self-service now properly uses bank transactions
- **Fixed Cat Petting**: Improved animation for petting cats
- **Improved Duty Toggle**: Added safeguards to prevent duplicate duty state changes
- **Enhanced Error Handling**: Better error messages and validation

## Credits

- Modified by: Mooons
- Based on: mt-uWuCafe by MT

## Support

For support or feature requests, please open an issue on the GitHub repository.
