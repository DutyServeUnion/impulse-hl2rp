local ITEM = {}

ITEM.UniqueID = "wep_ak47"
ITEM.Name = "AK-47 Assault Rifle"
ITEM.Desc =  "A cheap yet reliable high powered rifle for medium range combat. Kicks as hard as it hits."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/weapons/w_akm_inss.mdl")
ITEM.FOV = 6.6332378223496
ITEM.CamPos = Vector(160, -160, -15.128939628601)
ITEM.NoCenter = true
ITEM.Weight = 4

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_ak47"

impulse.RegisterItem(ITEM)
