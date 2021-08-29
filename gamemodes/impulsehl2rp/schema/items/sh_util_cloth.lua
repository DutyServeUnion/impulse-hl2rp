local ITEM = {}

ITEM.UniqueID = "util_cloth"
ITEM.Name = "Piece of Cloth"
ITEM.Desc = "A piece of cloth."
ITEM.Model = Model("models/props_junk/garbage_newspaper001a.mdl")
ITEM.Material = "models/props_c17/FurnitureFabric003a"
ITEM.FOV = 23.918338108883
ITEM.CamPos = Vector(-1.1461317539215, 25.21489906311, 63.037250518799)
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "fabric"
ITEM.CraftTime = 2

impulse.RegisterItem(ITEM)
