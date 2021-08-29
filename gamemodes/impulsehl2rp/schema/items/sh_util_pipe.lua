local ITEM = {}

ITEM.UniqueID = "util_pipe"
ITEM.Name = "Metal Pipe"
ITEM.Desc = "A metal pipe."
ITEM.Model = Model("models/props_lab/pipesystem03a.mdl")
ITEM.FOV = 43
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "gunmetal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
