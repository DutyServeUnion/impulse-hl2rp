AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoSnowball", function()
	game.AddAmmoType({
		name = "autonade"
	})
end)

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Thump Thump"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "rpg"

SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.ViewModelFOV = 43
SWEP.CustomMaterial = "phoenix_storms/stripes"

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.DoFireAnim = true

SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav")
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = RPM(9700)
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "autonade"
SWEP.Primary.ClipSize = 1000
SWEP.Primary.DefaultClip = 1000

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/items/ar2_grenade.mdl")
SWEP.Projectile.Touch = true
SWEP.Projectile.FireSound = Sound("BaseGrenade.Explode")
SWEP.Projectile.ForceMod = 4

function SWEP:ProjectileFire(owner, hit)
	local explodeEnt = ents.Create("env_explosion")
    explodeEnt:SetPos(self:GetPos())
    explodeEnt:Spawn()
    explodeEnt:SetKeyValue("iMagnitude", 60)
    explodeEnt:Fire("explode", "", 0)
end
