local ITEM = {}

ITEM.UniqueID = "wep_pistol"
ITEM.Name = "USP Match Pistol"
ITEM.Desc =  "A lightweight semi-automatic pistol that fires 9mm rounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_pistol.mdl")
ITEM.FOV = 24.190544412607
ITEM.CamPos = Vector(-16.045845031738, 17.191976547241, 3.4383955001831)
ITEM.NoCenter = true
ITEM.Weight = 0.8

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "secondary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_usp"

impulse.RegisterItem(ITEM)
