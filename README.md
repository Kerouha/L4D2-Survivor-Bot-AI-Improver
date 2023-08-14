# This is an experimental branch of Bot Improver, use at your own risk
---
## Notable differences
- Bots will fire upon staggered Witch before she targets anyone
- To resolve massive slowdowns in certain places (like when bots' path to wanted item is nav_blocked), function that calculates distance from a bot to an object was changed.
- Bots are less likely commit absurd backtracking (or deviate far from main path) to grab items. Takes `ib_grab_distance`/`ib_grab_visible_distance` into account. Range is reduced depending on bot's health and amount of threats around.
- Bots are less likely to grab items from unrealistic distance, or through doors/walls. See `ib_grab_pickup_distance`.
- Reduced string operations to a minimum, at least when it comes to inventory management. This *should* give better performance, right?
- Previously, you could experience following behavior: when someone gets downed, bot could snatch their secondary weapon, resulting in incapacitated player having no secondary upon being revived. This is fixed.
- `ib_t3_refill` – allow bots to pick up ammo when carrying a Tier 3 weapon ([if your server has this feature](https://github.com/LuxLuma/-L4D2-M60_GrenadeLauncher_patches))
- `ib_ammotype_override` – if your server has weapons with modified ammo types/capacity, put them in a format: `weapon_id:ammo_max weapon_id:ammo_max ...` Shouldn't be needed if weapon uses it's default ammo type. See weapon IDs [here](https://github.com/SilvDev/Left4DHooks/blob/e10791726db1d18818ed23faa6878fcfeeb4845f/sourcemod/scripting/include/left4dhooks_stocks.inc#L1543).
- Some commands and functions to test stuff
- CVar names changed and shortened for convenience
---
## Requirements
- **MetaMod:Source 1.11 or higher:** https://www.sourcemm.net/downloads.php?branch=stable
- **SourceMod 1.12:** https://www.sourcemod.net/downloads.php?branch=dev
- **Left 4 DHooks Direct:** https://forums.alliedmods.net/showthread.php?t=321696
- [**VScript by FortyTwoFortyTwo**](https://github.com/FortyTwoFortyTwo/VScript), has it's own requirements
- **Actions (Optional - Fixes bots always rushing to save their incapped friend or stopping to retreat in tank battle ):** https://forums.alliedmods.net/showpost.php?p=2771520&postcount=1
---
