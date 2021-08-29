local ITEM = {}

ITEM.UniqueID = "util_meat"
ITEM.Name = "Raw Meat"
ITEM.Desc =  "A chunk of raw meat."
ITEM.Model = Model("models/mosi/skyrim/fooddrink/horse.mdl")
ITEM.FOV = 8.5988538681948
ITEM.CamPos = Vector(28.424068450928, 16.50429725647, 83.209167480469)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

impulse.RegisterItem(ITEM)
