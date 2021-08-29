local ITEM = {}

ITEM.UniqueID = "food_cig"
ITEM.Name = "Pack of Cigarettes"
ITEM.Desc =  "Helps reduce stress, by giving you health problems."
ITEM.Category = "Food"
ITEM.Model = Model("models/closedboxshit.mdl")
ITEM.FOV = 12
ITEM.Weight = 0.2
ITEM.NoCenter = true

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Smoke"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Lighting..."

function ITEM:OnUse(ply)
	local effectData = EffectData()
	effectData:SetOrigin(ply:GetPos())
	
	util.Effect("ElectricSpark", effectData)
    return true
end

impulse.RegisterItem(ITEM)
