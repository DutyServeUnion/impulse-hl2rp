local ITEM = {}

ITEM.UniqueID = "food_coffee"
ITEM.Name = "Coffee"
ITEM.Desc =  "A warm drink high in caffine."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/xoffee_mug_closed.mdl")
ITEM.FOV = 33
ITEM.Weight = 0.5
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink"
ITEM.UseWorkBarTime = 5
ITEM.UseWorkBarName = "Drinking..."
ITEM.UseWorkBarSound = "impulse/drink.wav"

ITEM.Food = 5

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
