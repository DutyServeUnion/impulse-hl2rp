local ITEM = {}

ITEM.UniqueID = "wep_mini14"
ITEM.Name = "Mini-14"
ITEM.Desc =  "A old, but reliable rifle. Highly capable against armoured targets."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_tfa_mni14c.mdl")
ITEM.FOV = 11.396848137536
ITEM.CamPos = Vector(52.722061157227, -100, 1.1461317539215)
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_mini14"

impulse.RegisterItem(ITEM)
