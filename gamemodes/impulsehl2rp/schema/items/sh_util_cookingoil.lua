local ITEM = {}

ITEM.UniqueID = "util_cookingoil"
ITEM.Name = "Cooking Oil"
ITEM.Desc = "A bottle full of cooking oil."
ITEM.Model = Model("models/props_junk/garbage_plasticbottle003a.mdl")
ITEM.FOV = 43.244985673352
ITEM.CamPos = Vector(8.0229225158691, 29.226360321045, 6.8767910003662)
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "water"
ITEM.CraftTime = 2

impulse.RegisterItem(ITEM)
