local ITEM = {}

ITEM.UniqueID = "item_ziptie"
ITEM.Name = "Ziptie"
ITEM.Desc =  "Can be used to restrain the less cooperative members of society."
ITEM.Category = "Tools"
ITEM.Model = Model("models/Items/CrossbowRounds.mdl")
ITEM.FOV = 7.3137535816619
ITEM.CamPos = Vector(41.260746002197, -86.53295135498, 41.833812713623)
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Use"
ITEM.UseWorkBarTime = 0.6
ITEM.UseWorkBarName = "Restraining..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "npc/vort/claw_swing2.wav"

function ITEM:OnUse(ply, target)
	if not target:GetSyncVar(SYNC_ARRESTED, false) then
		target:Arrest()
			
		ply:Notify("You have detained "..target:Name()..".")
		target:Notify("You have been detained by "..ply:Name()..".")

		hook.Run("PlayerArrested", target, ply)

		return true
	else
		ply:Notify("Target already detained.")
	end
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:IsPlayer() and ply:CanArrest(ent) and ent:GetSyncVar(SYNC_ARRESTED, false) == false
end

impulse.RegisterItem(ITEM)
