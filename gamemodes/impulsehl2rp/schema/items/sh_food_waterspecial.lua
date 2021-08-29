local ITEM = {}

ITEM.UniqueID = "food_waterspecial"
ITEM.Name = "Special Water"
ITEM.Desc =  "A can of water from Dr. Breen's private reserve... Has severe memory side-effects."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_lunk/popcan01a.mdl")
ITEM.FOV = 18
ITEM.Weight = 0.4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Drinking..."
ITEM.UseWorkBarSound = "impulse/drink.wav"

ITEM.Food = 5

function ITEM:OnUse(ply)
	ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
