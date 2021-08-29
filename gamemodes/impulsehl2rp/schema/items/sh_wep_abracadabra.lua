local ITEM = {}

ITEM.UniqueID = "wep_abracadabra"
ITEM.Name = "Abra Cadabra"
ITEM.Desc =  "Forged in electrical fire, harness the awesome power of the 'i4' with this weapon."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_stunbaton.mdl")
ITEM.Material = "models/props_combine/stasisshield_sheet"
ITEM.FOV = 25
ITEM.Weight = 1.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_abracadabra"

impulse.RegisterItem(ITEM)
