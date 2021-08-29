local ITEM = {}

ITEM.UniqueID = "wep_axe"
ITEM.Name = "Axe"
ITEM.Desc = "A wooden axe, can be used to chop things."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/hl2meleepack/w_axe.mdl")
ITEM.FOV = 24.462750716332
ITEM.CamPos = Vector(-12.607449531555, 15.472779273987, 61.318050384521)
ITEM.Weight = 1.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_axe"

impulse.RegisterItem(ITEM)
