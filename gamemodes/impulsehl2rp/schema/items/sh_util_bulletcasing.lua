local ITEM = {}

ITEM.UniqueID = "util_bulletcasing"
ITEM.Name = "Bullet Casing"
ITEM.Desc = "A metal casing for bullets."
ITEM.Model = Model("models/Items/AR2_Grenade.mdl")
ITEM.FOV = 18.485673352436
ITEM.CamPos = Vector(-20.057306289673, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
