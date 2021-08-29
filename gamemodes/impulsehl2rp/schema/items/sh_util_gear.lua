local ITEM = {}

ITEM.UniqueID = "util_gear"
ITEM.Name = "Metal Gear"
ITEM.Desc = "A small metal gear."
ITEM.Model = Model("models/props_wasteland/gear02.mdl")
ITEM.FOV = 8.4025787965616
ITEM.CamPos = Vector(100, -26.934097290039, 2.8653295040131)
ITEM.Weight = 2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 4.5

impulse.RegisterItem(ITEM)
