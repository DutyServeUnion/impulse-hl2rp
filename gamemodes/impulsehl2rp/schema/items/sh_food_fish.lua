local ITEM = {}

ITEM.UniqueID = "food_fish"
ITEM.Name = "Raw Fish"
ITEM.Desc =  "A raw fish, straight out of the water."
ITEM.Category = "Food"
ITEM.Model = Model("models/props/cs_militia/fishriver01.mdl")
ITEM.FOV = 12.810888252149
ITEM.CamPos = Vector(-33.9255027771, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 35

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
