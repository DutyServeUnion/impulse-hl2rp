local ITEM = {}

ITEM.UniqueID = "item_healthkit"
ITEM.Name = "Health Kit"
ITEM.Desc =  "Can be used to treat major injuries or wounds of other people."
ITEM.Category = "Medical"
ITEM.Model = Model("models/items/healthkit.mdl")
ITEM.FOV = 7.041547277937
ITEM.CamPos = Vector(100, -100, 73.925498962402)
ITEM.NoCenter = true
ITEM.Weight = 2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Heal player"
ITEM.UseWorkBarTime = 10
ITEM.UseWorkBarName = "Healing..."
ITEM.UseWorkBarFreeze = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false


function ITEM:OnUse(ply, target)
	target:SetHealth(math.Clamp(ply:Health() + 60, 0, 100))

	target:Notify("You have been healed by "..ply:Nick()..".")
	ply:Notify("You have healed "..target:Nick()..".")

	return true
end

function ITEM:ShouldTraceUse(ply, ent)
	if ent:IsPlayer() then
		return true
	end
end

impulse.RegisterItem(ITEM)
