AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Broom"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.WorldModel = Model("")
SWEP.ViewModel = Model("")
SWEP.ViewModelOffset = Vector(-3, 15, 13)
SWEP.ViewModelOffsetAng = Angle(0, -10, 170)
SWEP.ViewModelFOV = 65

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false
SWEP.IsAlwaysRaised = true

function SWEP:PrimaryAttack()
	if not self.Owner:Team() == TEAM_VORT then
		return true
	end

	if not self.Owner:OnGround() then
		return
	end

	if SERVER then
		self.Owner:ForceSequence("sweep")
		self.Owner:EmitSound("impulse/broom.wav")
	end

	self:SetNextPrimaryFire(CurTime() + 3)
end

if SERVER then
	-- why dont we store this data normally? because of a fucking stupid bug where the weapon ent is removed before the onremoved thing is called when u get swep stripped :(
	PROP_BROOMS = PROP_BROOMS or {}

	for v,k in pairs(PROP_BROOMS) do
		if IsValid(k) then
			k:Remove()
			PROP_BROOMS[v] = nil
		end
	end

	local ply = ply or nil
	function SWEP:Deploy()
		ply = self.Owner:SteamID()

		if PROP_BROOMS[ply] then
			local x = PROP_BROOMS[ply]
			PROP_BROOMS[ply] = nil

			if IsValid(x) then
				x:Remove()
			end
		end

		if IsValid(self.Owner) and self.Owner:Team() != TEAM_VORT then
			return true
		end

		PROP_BROOMS[ply] = ents.Create("prop_dynamic")
		PROP_BROOMS[ply]:SetModel("models/props_c17/pushbroom.mdl")
		PROP_BROOMS[ply]:DrawShadow(true)
		PROP_BROOMS[ply]:SetMoveType(MOVETYPE_NONE)
		PROP_BROOMS[ply]:SetParent(self.Owner)
		PROP_BROOMS[ply]:SetSolid(SOLID_NONE)
		PROP_BROOMS[ply]:Spawn()
		PROP_BROOMS[ply]:Fire("setparentattachment", "cleaver_attachment", 0.01)

		self:CallOnRemove("cleanup", function(p)
			if PROP_BROOMS[p] then
				local x = PROP_BROOMS[p]
				PROP_BROOMS[p] = nil

				if IsValid(x) then
					x:Remove()
				end
			end
		end, ply)

		return true
	end

	function SWEP:Holster()
		if PROP_BROOMS[ply] then
			local x = PROP_BROOMS[ply]
			PROP_BROOMS[ply] = nil

			if IsValid(x) then
				x:Remove()
			end
		end

		return true
	end

	function SWEP:OnRemove()
		if PROP_BROOMS[ply] then
			local x = PROP_BROOMS[ply]
			PROP_BROOMS[ply] = nil

			if IsValid(x) then
				x:Remove()
			end
		end

		return true
	end

	timer.Create("longswordBroomCleaner", 3, 0, function() -- this is very very very messy but i cba
		for v,k in pairs(PROP_BROOMS) do
			if not IsValid(k) then
				PROP_BROOMS[v] = nil
				continue
			end

			local x = player.GetBySteamID(v)

			if not IsValid(x) or x:Team() != TEAM_VORT or not IsValid(x:GetActiveWeapon()) or x:GetActiveWeapon():GetClass() != "ls_broom" then
				PROP_BROOMS[v]:Remove()
				PROP_BROOMS[v] = nil
				continue
			end
		end
	end)
end


