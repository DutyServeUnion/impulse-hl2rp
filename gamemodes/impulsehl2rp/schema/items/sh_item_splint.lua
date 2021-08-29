local ITEM = {}

ITEM.UniqueID = "item_splint"
ITEM.Name = "Splint"
ITEM.Desc =  "A long wooden rod. Can be used to heal broken bones."
ITEM.Category = "Medical"
ITEM.Model = Model("models/props_junk/wood_crate001a_chunk05.mdl")
ITEM.FOV = 17.303724928367
ITEM.CamPos = Vector(-9.1690540313721, 11.002865791321, -79.426933288574)
ITEM.Weight = 0.6

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Use"
ITEM.UseWorkBarTime = 5
ITEM.UseWorkBarName = "Applying splint..."
ITEM.UseWorkBarFreeze = true

function ITEM:OnUse(ply)
	if ply:HasBrokenLegs() then
		ply:FixLegs()
		ply:Notify("Your broken legs have healed.")

		return true
	else
		ply:Notify("Your legs are not broken.")
	end
end

impulse.RegisterItem(ITEM)
