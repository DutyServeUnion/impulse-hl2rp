local ITEM = {}

ITEM.UniqueID = "util_glue"
ITEM.Name = "Glue"
ITEM.Desc = "A small tube of sticky liquid..."
ITEM.Model = Model("models/items/battery.mdl")
ITEM.FOV = 6.769340974212
ITEM.CamPos = Vector(-100, 21.776504516602, 29.226360321045)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "chemical"
ITEM.CraftTime = 1.5

impulse.RegisterItem(ITEM)
