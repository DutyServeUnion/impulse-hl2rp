AddCSLuaFile()

hook.Add("Initialize", "impulseLSAmmoRifle", function()
	game.AddAmmoType({
		name = "Rifle",
		dmgtype = DMG_BULLET,
		tracer = TRACER_LINE_AND_WHIZ,
		force = 5000,
		minsplash = 10,
		maxsplash = 100
	})
end)

SWEP.Base = "ls_base"

SWEP.PrintName = "AK-47"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_akm_inss.mdl")
SWEP.ViewModel = Model("models/weapons/v_akm_inss.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_iAK47.Single")
SWEP.Primary.Recoil = 1.68 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.MaxRecoil = 7
SWEP.Primary.RecoilRecoveryRate = 4.5
SWEP.Primary.Damage = 11
SWEP.Primary.PenetrationScale = 1.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = RPM(600)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.55 -- multiply
SWEP.Spread.CrouchMod = 0.75 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.7 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0.015 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.RecoilAcceleration = 1
SWEP.Spread.VelocityMod = 0.2 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.783, 0, 0.469)
SWEP.IronsightsAng = Angle(0.28, 0, 0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 0.9
SWEP.IronsightsMuzzleFlash = "MuzzleFlash"

SWEP.LoweredPos = Vector(0, -7, -11)
SWEP.LoweredAng = Angle(45, 45, 0)

sound.Add({
	name = "Weapon_iAK47.Single",
	sound = "impulse/ak47_fire.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_150dB,
	pitch = {95, 105}
})
