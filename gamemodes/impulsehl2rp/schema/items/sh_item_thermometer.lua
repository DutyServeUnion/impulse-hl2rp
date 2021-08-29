local ITEM = {}

ITEM.UniqueID = "item_thermometer"
ITEM.Name = "Thermometer"
ITEM.Desc =  "Can be used to take someones temperature."
ITEM.Category = "Medical"
ITEM.Model = Model("models/props_c17/trappropeller_lever.mdl")
ITEM.FOV = 12.249283667622
ITEM.CamPos = Vector(9.1690540313721, 17.421203613281, 64.297996520996)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

impulse.RegisterItem(ITEM)
