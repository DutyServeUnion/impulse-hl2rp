local ITEM = {}

ITEM.UniqueID = "food_water"
ITEM.Name = "Water"
ITEM.Desc =  "A can of UU issued water. Can be purchased from a vending machine."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_junk/popcan01a.mdl")
ITEM.FOV = 18
ITEM.Weight = 0.4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Drinking..."
ITEM.UseWorkBarSound = "impulse/drink.wav"

ITEM.Food = 5

function ITEM:OnUse(ply)
	ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
