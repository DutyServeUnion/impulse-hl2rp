local ITEM = {}

ITEM.UniqueID = "food_sardines"
ITEM.Name = "Sardines"
ITEM.Desc =  "Sythentic fish that resemble sardines..."
ITEM.Category = "Food"
ITEM.Model = Model("models/bioshockinfinite/cardine_can_open.mdl")
ITEM.FOV = 16.207736389685
ITEM.CamPos = Vector(-12.034383773804, 18.338108062744, 23.49570274353)
ITEM.NoCenter = true
ITEM.Weight = 0.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Eat"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Eating..."
ITEM.UseWorkBarSound = "impulse/eat.wav"

ITEM.Food = 75

function ITEM:OnUse(ply)
    ply:FeedHunger(self.Food)
    return true
end

impulse.RegisterItem(ITEM)
