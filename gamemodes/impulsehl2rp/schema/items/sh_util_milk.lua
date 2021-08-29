local ITEM = {}

ITEM.UniqueID = "util_milk"
ITEM.Name = "Carton of Milk"
ITEM.Desc = "A carton of slightly sour milk."
ITEM.Model = Model("models/props_junk/garbage_milkcarton002a.mdl")
ITEM.FOV = 35
ITEM.Weight = 0.8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.CraftSound = "water"
ITEM.CraftTime = 1.5

impulse.RegisterItem(ITEM)
