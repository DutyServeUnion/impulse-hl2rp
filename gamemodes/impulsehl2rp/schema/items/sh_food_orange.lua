local ITEM = {}

ITEM.UniqueID = "food_orange"
ITEM.Name = "Orange"
ITEM.Desc =  "A not-so freshly grown orange."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/hext_orange.mdl")
ITEM.FOV = 18
ITEM.Weight = 0.2
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 15

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
