local ITEM = {}

ITEM.UniqueID = "util_fuel"
ITEM.Name = "Fuel Can"
ITEM.Desc = "A can full of fuel."
ITEM.Model = Model("models/props_junk/metalgascan.mdl")
ITEM.FOV = 20.651862464183
ITEM.CamPos = Vector(54.441261291504, 76.790832519531, 23.49570274353)
ITEM.Weight = 9

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "fuel"
ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)
