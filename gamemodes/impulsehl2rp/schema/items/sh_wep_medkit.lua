local ITEM = {}

ITEM.UniqueID = "wep_medkit"
ITEM.Name = "First Aid Kit"
ITEM.Desc = "A large first aid kit with several pouches. Capable of healing the worst wounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/warz/items/medkit.mdl")
ITEM.FOV = 17.6
ITEM.CamPos = Vector(52.148998260498, 25, 9)
ITEM.Weight = 4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "medical"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_medkit"

impulse.RegisterItem(ITEM)
