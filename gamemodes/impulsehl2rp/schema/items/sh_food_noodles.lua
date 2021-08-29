local ITEM = {}

ITEM.UniqueID = "food_noodles"
ITEM.Name = "Noodles"
ITEM.Desc =  "Cheap microwaved noodles. Tasty..."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.FOV = 33
ITEM.Weight = 0.7

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 60

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
