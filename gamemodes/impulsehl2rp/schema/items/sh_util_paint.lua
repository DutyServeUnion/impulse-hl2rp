local ITEM = {}

ITEM.UniqueID = "util_paint"
ITEM.Name = "Paint"
ITEM.Desc = "A bucket of paint."
ITEM.Model = Model("models/props_junk/metal_paintcan001a.mdl")
ITEM.FOV = 40
ITEM.Weight = 3

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "water"
ITEM.CraftTime = 2.5

impulse.RegisterItem(ITEM)
