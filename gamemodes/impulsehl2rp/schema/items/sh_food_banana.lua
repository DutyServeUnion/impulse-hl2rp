local ITEM = {}

ITEM.UniqueID = "food_banana"
ITEM.Name = "Banana"
ITEM.Desc =  "A not-so freshly grown banana."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/hext_banana.mdl")
ITEM.FOV = 25
ITEM.Weight = 0.2
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 15

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
