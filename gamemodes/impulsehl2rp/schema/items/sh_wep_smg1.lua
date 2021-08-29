local ITEM = {}

ITEM.UniqueID = "wep_smg"
ITEM.Name = "MP7 Submachine Gun"
ITEM.Desc =  "A lightweight submachine gun often used by Civil Protection officers."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_smg1.mdl")
ITEM.FOV = 6.2249283667622
ITEM.CamPos = Vector(100, 100, 36.10315322876)
ITEM.Weight = 3

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_mp7"

impulse.RegisterItem(ITEM)
