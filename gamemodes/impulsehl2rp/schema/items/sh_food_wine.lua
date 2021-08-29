local ITEM = {}

ITEM.UniqueID = "food_wine"
ITEM.Name = "Wine"
ITEM.Desc =  "Not quite Chateau Lafite 1787, but it'll do."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/hext_bottle_lager.mdl")
ITEM.FOV = 45
ITEM.Weight = 2
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Drink"
ITEM.UseWorkBarTime = 10
ITEM.UseWorkBarName = "Drinking..."
ITEM.UseWorkBarSound = "impulse/drink.wav"

ITEM.Food = 5

function ITEM:OnUse(ply)
    return true
end

impulse.RegisterItem(ITEM)
