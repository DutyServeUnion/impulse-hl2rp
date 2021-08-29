local ITEM = {}

ITEM.UniqueID = "food_pepsi"
ITEM.Name = "Crystal Pepsi"
ITEM.Desc =  "All the public health wonders of the 1980's in one clear bottle. Good for YouTube challenges."
ITEM.Category = "Food"
ITEM.Model = Model("models/props/cs_aquace/water_bottle.mdl")
--ITEM.Material = "sprops/textures/sprops_chrome"
ITEM.FOV = 23
ITEM.Weight = 2
ITEM.NoCenter = true

ITEM.Colour = Color(0, 133, 202)

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink (if you dare)"
ITEM.UseWorkBarTime = 15
ITEM.UseWorkBarName = "Drinking..."
ITEM.UseWorkBarSound = "impulse/drink.wav"

ITEM.Food = 5

function ITEM:OnUse(ply)
	ply:Kill()
    return true
end

impulse.RegisterItem(ITEM)
