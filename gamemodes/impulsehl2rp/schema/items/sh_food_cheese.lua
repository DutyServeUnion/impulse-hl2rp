local ITEM = {}

ITEM.UniqueID = "food_cheese"
ITEM.Name = "Cheese"
ITEM.Desc =  "Sometimes, I dream about cheese."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/pound_cheese.mdl")
ITEM.FOV = 33
ITEM.Weight = 10
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 10
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 90

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
