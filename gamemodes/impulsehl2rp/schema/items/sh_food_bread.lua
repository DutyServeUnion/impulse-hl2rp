local ITEM = {}

ITEM.UniqueID = "food_bread"
ITEM.Name = "Bread"
ITEM.Desc =  "A dried loaf of bread containing preservatives."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/dread_loaf.mdl")
ITEM.FOV = 35
ITEM.Weight = 1
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 6
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 45

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
