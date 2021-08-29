local ITEM = {}

ITEM.UniqueID = "util_combinescrap"
ITEM.Name = "Ruined Biolink Device"
ITEM.Desc = "A small, ruined, combine device that can easily be scrapped."
ITEM.Model = Model("models/gibs/manhack_gib03.mdl")
ITEM.FOV = 13.84670487106
ITEM.CamPos = Vector(-5.7306590080261, 37.249282836914, 14.326647758484)
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "metal"
ITEM.CraftTime = 5

impulse.RegisterItem(ITEM)
