local ITEM = {}

ITEM.UniqueID = "item_cleaver"
ITEM.Name = "Cleaver"
ITEM.Desc =  "Can be used to cut up all sorts of meat..."
ITEM.Category = "Tools"
ITEM.Model = Model("models/hitman6/cleaver.mdl")
ITEM.FOV = 3.8252148997135
ITEM.CamPos = Vector(-160, 135.7020111084, 26.475645065308)
ITEM.NoCenter = true
ITEM.Weight = 1.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Cut meat from corpse"
ITEM.UseWorkBarTime = 8
ITEM.UseWorkBarName = "Cutting meat..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "impulse/meatcut.wav"

function ITEM:OnUse(ply, target)
	local headBone = target:LookupBone("ValveBiped.Bip01_Head1")
	local pelvisBone = target:LookupBone("ValveBiped.Bip01_Pelvis")
	local pelvisPos = pelvisBone and target:GetBonePosition(pelvisBone)
	local pelvisMatrix = pelvisBone and target:GetBoneMatrix(pelvisBone)
	local headPos = headBone and target:GetBonePosition(headBone)

	target:Remove()

	local function makeGib(ent)
		timer.Simple(300, function()
			if IsValid(ent) then
				ent:Remove()
			end
		end)

		ent.CanConstrain = false
		ent.NoCarry = true

		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	if headPos then
		local m = impulse.Anim.GetModelClass(target:GetModel()) == "metrocop" and "models/dpfilms/metropolice/props/zombie_gasmask.mdl" or "models/gibs/hgibs.mdl"

		local gib = ents.Create("prop_physics")
		gib:SetModel(m)
		gib:SetPos(headPos)
		makeGib(gib)
	end

	if pelvisPos then
		local gib = ents.Create("prop_ragdoll")
		gib:SetModel("models/gibs/fast_zombie_legs.mdl")
		gib:SetPos(pelvisPos)
		gib:SetAngles(pelvisMatrix:GetAngles())
		makeGib(gib)
	end

	if ply:CanHoldItem("food_suspiciousmeat") then
		ply:GiveInventoryItem("food_suspiciousmeat")
		ply:Notify("You collected human meat from the corpse.")
	end
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:GetClass() == "prop_ragdoll" and (ent:GetModel() or "") != "models/gibs/fast_zombie_legs.mdl"
end

impulse.RegisterItem(ITEM)
