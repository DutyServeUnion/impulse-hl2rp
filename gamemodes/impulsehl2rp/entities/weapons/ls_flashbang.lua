AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoGas", function()
	game.AddAmmoType({
		name = "flashbang"
	})
end)

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Flashbang"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "grenade"

SWEP.WorldModel = Model("models/weapons/w_eq_flashbang.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_eq_flashbang.mdl")
SWEP.ViewModelFOV = 50

SWEP.Slot = 4
SWEP.SlotPos = 1

SWEP.Primary.Sound = ""
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Delay = 0.8
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "flashbang"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/weapons/w_eq_flashbang_thrown.mdl")
SWEP.Projectile.FireSound = Sound("Weapon_Flashbang.Explode")
SWEP.Projectile.HitSound = Sound("weapons/flashbang/grenade_hit1.wav")
SWEP.Projectile.Touch = false
SWEP.Projectile.ForceMod = 1.2
SWEP.Projectile.Timer = 3
SWEP.Projectile.RemoveWait = 30

function SWEP:ProjectileFire()
end

sound.Add({
	name = "Weapon_Flashbang.Explode",
	sound = {"impulse/flashbang1.ogg", "impulse/flashbang2.ogg"},
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {85, 115}
})
