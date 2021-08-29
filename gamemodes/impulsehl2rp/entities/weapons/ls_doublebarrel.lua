AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Double Barrel Shotgun"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "shotgun"

SWEP.WorldModel = Model("models/weapons/w_tfa_dbbl_classic_hd.mdl")
SWEP.ViewModel = Model("models/weapons/v_tfa_dbblsg.mdl")
SWEP.ViewModelFOV = 56

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_DoubleBarrel.Single")
SWEP.Primary.Recoil = 8 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 11
SWEP.Primary.NumShots = 6
SWEP.Primary.Cone = 0.08
SWEP.Primary.Delay = RPM(95)
SWEP.Primary.Range = 500

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 2

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.DoEmptyReloadAnim = true

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 1 -- multiply
SWEP.Spread.CrouchMod = 0.99 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.1 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.05 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-5.43, -12.462, 2.559)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.9
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 0.25

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(45, 0, 0)

sound.Add({
	name = "Weapon_DoubleBarrel.Single",
	sound = "weapons/700n-3.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE
})
