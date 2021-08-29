local ITEM = {}

ITEM.UniqueID = "util_refinedmetalplate"
ITEM.Name = "Refined Metal Plate"
ITEM.Desc = "A refined metal plate made of an alloy."
ITEM.Model = Model("models/gibs/scanner_gib02.mdl")
ITEM.FOV = 40
ITEM.Weight = 0.8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 5

impulse.RegisterItem(ITEM)
