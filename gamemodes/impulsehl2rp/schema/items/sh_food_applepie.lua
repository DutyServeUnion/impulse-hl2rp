local ITEM = {}

ITEM.UniqueID = "food_applepie"
ITEM.Name = "Apple Pie"
ITEM.Desc =  "A warm, sweet, apple pie."
ITEM.Category = "Food"
ITEM.Model = Model("models/mosi/skyrim/fooddrink/pie.mdl")
ITEM.FOV = 39.206303724928
ITEM.CamPos = Vector(11.919771194458, 1.8338109254837, 15.128939628601)
ITEM.NoCenter = true
ITEM.Weight = 0.7

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 5
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 90

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
