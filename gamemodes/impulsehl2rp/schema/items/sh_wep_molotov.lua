local ITEM = {}

ITEM.UniqueID = "wep_molotov"
ITEM.Name = "Molotov Cocktail"
ITEM.Desc =  "An improvised incendiary weapon contaning flammable liquids."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/props_junk/glassbottle01a.mdl")
ITEM.FOV = 20.924068767908
ITEM.CamPos = Vector(36.676216125488, -5.7306590080261, 14.326647758484)
ITEM.Weight = 2.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "grenade"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_molotov"
ITEM.WeaponOverrideClip = 1

impulse.RegisterItem(ITEM)
