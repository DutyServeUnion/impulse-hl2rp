local ITEM = {}

ITEM.UniqueID = "wep_m60"
ITEM.Name = "M60 Machine Gun"
ITEM.Desc =  "A heavy and bulky machine gun produced in the 1960s, known as 'The Pig'."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/kali/weapons/m60.mdl")
ITEM.Mass = 1
ITEM.FOV = 12.75787965616
ITEM.CamPos = Vector(100, 91.690544128418, 100)
ITEM.Weight = 10

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_m60"

impulse.RegisterItem(ITEM)
