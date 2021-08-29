local ITEM = {}

ITEM.UniqueID = "util_electronics"
ITEM.Name = "Circuit Board"
ITEM.Desc = "A old restored circuit board."
ITEM.Model = Model("models/props/cs_office/projector_p6.mdl")
ITEM.FOV = 6.4971346704871
ITEM.CamPos = Vector(81.948425292969, 100, 60.744987487793)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.CraftSound = "electronics"
ITEM.CraftTime = 3.5

impulse.RegisterItem(ITEM)
