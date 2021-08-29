local ITEM = {}

ITEM.UniqueID = "util_ceramicplate"
ITEM.Name = "Ceramic Plate"
ITEM.Desc = "A roughly cut plate of tough material. Could fit in a vest."
ITEM.Model = Model("models/hunter/plates/plate05x05.mdl")
ITEM.Material = "sprops/trans/misc/beam_side"
ITEM.FOV = 40.250716332378
ITEM.CamPos = Vector(12.607449531555, 0, 40.687679290771)
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 12

impulse.RegisterItem(ITEM)
