local ITEM = {}

ITEM.UniqueID = "item_drill"
ITEM.Name = "Drill"
ITEM.Desc =  "A heavy-duty mechanical drill. Good at cracking safes and heavy locks."
ITEM.Category = "Tools"
ITEM.Model = Model("models/pd2_drill/drill.mdl")
ITEM.FOV = 13.372492836676
ITEM.CamPos = Vector(-68.767906188965, -67.851005554199, 9)
ITEM.NoCenter = true
ITEM.Weight = 7

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Use"
ITEM.UseWorkBarTime = 7
ITEM.UseWorkBarName = "Setting up drill..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "npc/sniper/reload1.wav"

function ITEM:OnUse(ply, ent)
	if ply:IsCP() then
		return true
	end

	if ent.Drilling then
		ply:Notify("This ammo box is already being drilled...")
		return
	end

	if ent.LastRaided and ent.LastRaided > CurTime() then
		ply:Notify("This ammo box has already been raided recently...")
		return
	end

	if not impulse.CanNexusRaid() then
		ply:Notify("You can't raid the ammo box until their are more Civil Protection or Overwatch forces on duty.")
		return
	end

	ent:StartDrill()
	ply:Notify("You have started drilling the ammo box.")
	return true
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:GetClass() == "impulse_hl2rp_ammobox" and ent.GetDrillEndTime and ent:GetDrillEndTime() and ent:GetDrillEndTime() == 0
end

impulse.RegisterItem(ITEM)
