local ITEM = {}

ITEM.UniqueID = "wep_357"
ITEM.Name = "357. Revolver"
ITEM.Desc =  "A large revolver that fires 357. rounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_357.mdl")
ITEM.FOV = 17.113180515759
ITEM.CamPos = Vector(-25.21489906311, 34.957019805908, 0.57306587696075)
ITEM.NoCenter = true

ITEM.Weight = 1.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "secondary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_357"

impulse.RegisterItem(ITEM)
