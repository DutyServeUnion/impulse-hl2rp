local ITEM = {}

ITEM.UniqueID = "food_apple"
ITEM.Name = "Apple"
ITEM.Desc =  "A not-so freshly grown apple."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/hext_apple.mdl")
ITEM.FOV = 16
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

ITEM.Food = 30

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
