local ITEM = {}

ITEM.UniqueID = "food_pineapple"
ITEM.Name = "Pineapple"
ITEM.Desc =  "A not-so freshly grown pineapple."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/hext_pineapple.mdl")
ITEM.FOV = 42
ITEM.Weight = 2
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 45

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
