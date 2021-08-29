AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Mini-14"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/weapons/w_tfa_mni14c.mdl")
SWEP.ViewModel = Model("models/weapons/v_tfa_mni14c.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_Mini14.Single")
SWEP.Primary.Recoil = 1.1 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 16
SWEP.Primary.PenetrationScale = 2
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.029
SWEP.Primary.Delay = RPM(180)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 21
SWEP.Primary.DefaultClip = 21

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 0.1
SWEP.Spread.IronsightsMod = 0.21 -- multiply
SWEP.Spread.CrouchMod = 0.94 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.07 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-7.211, -12.075, 1.009)
SWEP.IronsightsAng = Angle(-0.151, 0, 0)
SWEP.IronsightsFOV = 0.6
SWEP.IronsightsSensitivity = 0.5
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 1

local copyIronFOV = SWEP.IronsightsFOV + 0
local copyIronSens = SWEP.IronsightsSensitivity + 0
local copyCone = SWEP.Primary.Cone + 0
local copyIronMod = SWEP.Spread.IronsightsMod + 0
local copyVelMod = SWEP.Spread.VelocityMod + 0
local copyDamage = SWEP.Primary.Damage + 0
local copyRPM = SWEP.Primary.Delay + 0
local copyPen = SWEP.Primary.PenetrationScale + 0
SWEP.Attachments = {
	hunting_scope = {
		Cosmetic = {
			Model = "models/weapons/tfa_ins2/upgrades/a_optic_m40_test.mdl",
			Bone = "mini_14",
			Pos = Vector(5.099, -4, -0.9),
			Ang = Angle(0, 77.5, 0),
			Scale = 0.85,
			Skin = 0
			--World = {
			--	Pos = Vector(11, 1.5, -6),
			--	Ang = Angle(0, 180, 90),
			--	Scale = 0.85
			--}
		},
		ModSetup = function(e)
			e.IronsightsFOV = 0.65
			e.FOVScoped = 0.3
			e.IronsightsSensitivity = 0.18

			e.Primary.Cone = 0.035
			e.Spread.IronsightsMod = 0.09
			e.Spread.VelocityMod = 0.4

			e.Primary.Damage = 42
			e.Primary.PenetrationScale = 0.8
			e.Primary.Delay = RPM(45)

			e.NoCrosshair = true
			e.NoThirdpersonIronsights = true
		end,
		ModCleanup = function(e)
			e.IronsightsFOV = copyIronFOV
			e.FOVScoped = nil
			e.IronsightsSensitivity = copyIronSens

			e.Primary.Cone = copyCone
			e.Spread.IronsightsMod = copyIronMod
			e.Spread.VelocityMod = copyVelMod

			e.Primary.Damage = copyDamage
			e.Primary.PenetrationScale = copyPen
			e.Primary.Delay = copyRPM

			e.NoCrosshair = false
			e.NoThirdpersonIronsights = false
		end,
		Behaviour = "sniper_sight",
		NeedsHDR = true,
		ScopeTexture = Material("ph_scope/ph_scope_lens3")
	}
}

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(70, 0, 0)

sound.Add({
	name = "Weapon_Mini14.Single",
	sound = "weapons/scout/scout_fire-1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})
