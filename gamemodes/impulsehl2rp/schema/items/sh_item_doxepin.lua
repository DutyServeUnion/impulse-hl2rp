local ITEM = {}

ITEM.UniqueID = "item_doxepin"
ITEM.Name = "Doxepin Pills"
ITEM.Desc =  "A small plastic capsule containg doxepin pills. Can relax the mind."
ITEM.Category = "Medical"
ITEM.Model = Model("models/warz/consumables/painkillers.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(42.406875610352, -5.7306590080261, 12.607449531555)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Give pills"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Giving pills..."
ITEM.UseWorkBarFreeze = true

function ITEM:OnUse(ply, ent)
	local lvl = ent:GetSyncVar(SYNC_INSANE, 0)

	if not lvl then
		return
	end

	if lvl > 0 and lvl < 5 then
		ent:StopInsane()
		ent:Notify("Your insanity has been cured.")
	end

	ply:Notify("You have administered the treatment.")
	return true
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:IsPlayer() and not ply:IsCP()
end


impulse.RegisterItem(ITEM)
