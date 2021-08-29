local ITEM = {}

ITEM.UniqueID = "util_plastic"
ITEM.Name = "Chunk of Plastic"
ITEM.Desc = "A small chunk of scrap plastic."
ITEM.Model = Model("models/props_c17/canisterchunk01a.mdl")
ITEM.FOV = 44.061604584527
ITEM.CamPos = Vector(-6.8767910003662, 4.0114612579346, 28.080228805542)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "plastic"
ITEM.CraftTime = 2

impulse.RegisterItem(ITEM)
