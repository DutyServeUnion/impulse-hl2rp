local ITEM = {}

ITEM.UniqueID = "wep_shotgun"
ITEM.Name = "SPAS-12 Shotgun"
ITEM.Desc =  "A large shotgun that packs a punch. Fires 12G buckshot rounds."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_shotgun.mdl")
ITEM.FOV = 12.213467048711
ITEM.CamPos = Vector(74.5, -84.809997558594, -26)
ITEM.Weight = 6
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_spas12"

impulse.RegisterItem(ITEM)
