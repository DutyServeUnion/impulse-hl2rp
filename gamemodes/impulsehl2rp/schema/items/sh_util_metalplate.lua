local ITEM = {}

ITEM.UniqueID = "util_metalplate"
ITEM.Name = "Metal Plate"
ITEM.Desc = "A metal plate."
ITEM.Model = Model("models/gibs/metal_gib4.mdl")
ITEM.FOV = 17.113180515759
ITEM.CamPos = Vector(-6.3037247657776, 24.641834259033, 9.7421207427979)
ITEM.Weight = 0.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
