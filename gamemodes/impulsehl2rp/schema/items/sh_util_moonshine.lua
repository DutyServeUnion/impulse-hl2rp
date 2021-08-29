local ITEM = {}

ITEM.UniqueID = "util_moonshine"
ITEM.Name = "Moonshine"
ITEM.Desc =  "An unlicensed alcoholic drink."
ITEM.Model = Model("models/props_junk/glassjug01.mdl")
ITEM.FOV = 30
ITEM.NoCenter = true

ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

impulse.RegisterItem(ITEM)
