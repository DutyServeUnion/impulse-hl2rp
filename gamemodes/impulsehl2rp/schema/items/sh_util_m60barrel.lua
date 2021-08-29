local ITEM = {}

ITEM.UniqueID = "util_m60barrel"
ITEM.Name = "M60 Barrel"
ITEM.Desc = "A long metal barrel to be used on the M60 machine gun."
ITEM.Model = Model("models/kali/weapons/m60 barrel.mdl")
ITEM.FOV = 6.769340974212
ITEM.CamPos = Vector(-71.633239746094, 100, -52.722061157227)
ITEM.NoCenter = true
ITEM.Weight = 4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 10

impulse.RegisterItem(ITEM)
