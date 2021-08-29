AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Field First Aid Kit"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "normal"
SWEP.IsAlwaysRaised = true
SWEP.UseHands = false

SWEP.WorldModel = Model("models/warz/items/medkit.mdl")
SWEP.ViewModel = Model("models/warz/items/medkit.mdl")
SWEP.ViewModelOffset = Vector(-10, 8, -5)
SWEP.ViewModelOffsetAng = Angle(0, -90, 0)
SWEP.ViewModelFOV = 80

SWEP.Slot = 4
SWEP.SlotPos = 7

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true

SWEP.NoIronsights = true

local sounds = {
	"impulse/craft/fabric/1.wav",
	"impulse/craft/fabric/2.wav",
	"impulse/craft/fabric/3.wav",
	"impulse/craft/fabric/4.wav",
	"impulse/craft/fabric/5.wav",
	"impulse/craft/fabric/6.wav"
}

function SWEP:PrimaryAttack()
	if ( CLIENT ) then return end

	local wait = self.nextFire

	if wait and wait > CurTime() then
		return
	end

	self.nextFire = CurTime() + 1

	if ( self.Owner:IsPlayer() ) then
		self.Owner:LagCompensation( true )
	end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	if ( self.Owner:IsPlayer() ) then
		self.Owner:LagCompensation( false )
	end

	local ent = tr.Entity

	if not IsValid(ent) or not ent:IsPlayer() or not ent:Alive() then
		return
	end

	local hp = ent:Health()

	if hp == ent:GetMaxHealth() then
		self.Owner:Notify("This player is fully healed already.", 80)
		return
	end
	
	local give = math.Clamp(hp + 10, 0, ent:GetMaxHealth())
	ent:SetHealth(give)
	ent:ScreenFade(1, Color(201, 217, 242, 180), 1, 0)

	self.Owner:EmitSound(sounds[math.random(1, #sounds)])
	self.nextFire = CurTime() + 1.2
end

function SWEP:SecondaryAttack()
	if ( CLIENT ) then return end

	local wait = self.nextFire
	
	if wait and wait > CurTime() then
		return
	end

	self.nextFire = CurTime() + 1


	local ent = self.Owner

	if not IsValid(ent) or not ent:IsPlayer() or not ent:Alive() then
		return
	end

	local hp = ent:Health()

	if hp == ent:GetMaxHealth() then
		self.Owner:Notify("You are fully healed already.")
		return
	end
	
	local give = math.Clamp(hp + 5, 0, ent:GetMaxHealth())
	ent:SetHealth(give)
	ent:ScreenFade(1, Color(201, 217, 242, 180), 1, 0)

	self.Owner:EmitSound(sounds[math.random(1, #sounds)])
	self.nextFire = CurTime() + 1.5
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(6, -0.5, -2.4)
			local offsetAng = Angle(180, 90, -90)

			local boneid = _Owner:LookupBone( "ValveBiped.Bip01_R_Hand" ) -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end
end


