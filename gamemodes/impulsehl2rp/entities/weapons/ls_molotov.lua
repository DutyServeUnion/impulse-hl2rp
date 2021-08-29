AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoMolotov", function()
	game.AddAmmoType({
		name = "molotov"
	})
end)

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Molotov Cocktail"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("models/props_junk/glassbottle01a.mdl")
SWEP.ViewModel = Model("models/props_junk/glassbottle01a.mdl")
SWEP.ViewModelOffset = Vector(9.635, 35.557, -7.519)
SWEP.ViewModelFOV = 40

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "molotov"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/props_junk/glassbottle01a.mdl")
SWEP.Projectile.FireSound = Sound("physics/glass/glass_bottle_break2.wav")
SWEP.Projectile.Touch = true
SWEP.Projectile.ForceMod = 0.8

sound.Add({
	name = "Weapon_TearGas.Hiss",
	sound = "npc/env_headcrabcanister/hiss.wav",
	level = 56,
	pitch = 110
})

function SWEP:ProjectileFire()
	local pos = self:GetPos()
	local owner = self:GetOwner()

	timer.Simple(0.2, function()
		if not IsValid(owner) then
			return
		end

		for i = 1, 23 do
			local molotovfire = ents.Create("env_fire")
			molotovfire:SetPos(pos + Vector(math.Rand(-74, 74), math.Rand(-74, 74), 0))
			molotovfire:SetKeyValue("firesize", "64")
			molotovfire:SetKeyValue("damagescale", "5")
			--molotovfire:SetKeyValue("duration", "10")
			molotovfire:SetOwner(owner)
			molotovfire:Spawn()

			if i <= 3 then
				molotovfire.emitter = true
				molotovfire:EmitSound("fire_medium")
				molotovfire:EmitSound("ambient/fire/ignite.wav")
			end

			molotovfire:Fire("StartFire", "", 0)
			timer.Simple(18, function()
				if IsValid(molotovfire) then
					if molotovfire.emitter then
						molotovfire:StopSound("fire_medium")
					end

					molotovfire:Remove()
				end
			end)
		end

		local searchPlayers = player.GetAll()
		local range = 160 ^ 2

    	for v=1, #searchPlayers do
        	local k = searchPlayers[v]

        	if k:GetPos():DistToSqr(pos) < range then
        		k:Ignite(math.random(2, 5))
        	end
    	end
	end)
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(3.6, -1.5, 2.4)
			local offsetAng = Angle(180, 90, 0)

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
