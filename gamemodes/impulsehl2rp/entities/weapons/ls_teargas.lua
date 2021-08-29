AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoGas", function()
	game.AddAmmoType({
		name = "gas"
	})
end)

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Tear Gas"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("models/weapons/w_eq_smokegrenade.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_smokegrenade.mdl")
SWEP.ViewModelFOV = 50

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "gas"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/weapons/w_eq_smokegrenade_thrown.mdl")
SWEP.Projectile.FireSound = Sound("weapons/smokegrenade/sg_explode.wav")
SWEP.Projectile.HitSound = Sound("weapons/smokegrenade/grenade_hit1.wav")
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 1.2
SWEP.Projectile.Timer = 5
SWEP.Projectile.RemoveWait = 50

sound.Add({
	name = "Weapon_TearGas.Hiss",
	sound = "npc/env_headcrabcanister/hiss.wav",
	level = 56,
	pitch = 110
})

function SWEP:ProjectileFire()
	local sfx = EffectData()
	sfx:SetEntity(self)
	sfx:SetOrigin(self:GetPos())
	
	util.Effect("impulse_teargas", sfx, nil, true)

	self:EmitSound("Weapon_TearGas.Hiss")
end

function SWEP:ProjectileRemove()
	self:StopSound("Weapon_TearGas.Hiss")
end

local range = 250 ^ 2
function SWEP:ProjectileThink()
	if self.NextDamageCheck and self.NextDamageCheck < CurTime() then
		return
	end

	self.NextDamageCheck = CurTime() + 1

	local searchPlayers = player.GetAll()
	local origin = self:GetPos()

    for v=1, #searchPlayers do
        local k = searchPlayers[v]

        if not k.beenInvSetup then
        	return
        end

        if k.HasGasMask(k) then
        	continue
        end

        if k:GetPos():DistToSqr(origin) < range then
        	k:TearGasEffect()
        end
    end
end
