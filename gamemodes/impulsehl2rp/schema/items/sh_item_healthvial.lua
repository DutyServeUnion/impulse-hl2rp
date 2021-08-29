local ITEM = {}

ITEM.UniqueID = "item_healthvial"
ITEM.Name = "Health Vial"
ITEM.Desc =  "Can be used to treat minor injuries or wounds."
ITEM.Category = "Medical"
ITEM.Model = Model("models/healthvial.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(100, 100, 0)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Apply"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Applying..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "items/smallmedkit1.wav"

function ITEM:OnUse(ply, target)
	ply:SetHealth(math.Clamp(ply:Health() + 10, 0, ply:GetMaxHealth()))
	
	if ply:HasBrokenLegs() then
		ply:FixLegs()
		ply:Notify("Your broken legs have healed.")
	end

	return true
end

impulse.RegisterItem(ITEM)
