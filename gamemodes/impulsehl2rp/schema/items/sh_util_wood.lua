local ITEM = {}

ITEM.UniqueID = "util_wood"
ITEM.Name = "Piece of Wood"
ITEM.Desc = "A piece of wood."
ITEM.Model = Model("models/items/item_item_crate_chunk02.mdl")
ITEM.FOV = 20.924068767908
ITEM.CamPos = Vector(-25.787965774536, -0.57306587696075, 94.555877685547)
ITEM.Weight = 0.4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "wood"
ITEM.CraftTime = 3.5

impulse.RegisterItem(ITEM)
