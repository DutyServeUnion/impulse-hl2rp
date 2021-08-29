AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "M60"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "ar2"

SWEP.WorldModel = Model("models/kali/weapons/m60.mdl")
SWEP.ViewModel = Model("models/weapons/v_dm60.mdl")
SWEP.ViewModelFOV = 56

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_M249.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_M60.Single")
SWEP.Primary.Recoil = 0.28 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 12
SWEP.Primary.PenetrationScale = 1.65
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.088
SWEP.Primary.Delay = RPM(650)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 130
SWEP.Primary.DefaultClip = 130

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.65 -- multiply
SWEP.Spread.CrouchMod = 0.35 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.8 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.25 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-6.111, 0, 1.34)
SWEP.IronsightsAng = Angle(-2.401, -0.102, -1)
SWEP.IronsightsFOV = 0.72
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 3.5

SWEP.Attachments = {
	hula = {
		Cosmetic = {
			Model = "models/props_lab/huladoll.mdl",
			Bone = "v_weapon.m249",
			Pos = Vector(-0.721, -3.537, 3.635),
			Ang = Angle(-29.611, -5.844, -94.676),
			Scale = 0.379,
			Skin = 0
		},
		ModSetup = function(e)
			e.CustomShootEffects = function()
				if CLIENT and IsValid(e.AttachedCosmetic) then
					e:ResetSequence("shake")
				end
			end
		end,
		ModCleanup = function(e)
			e.CustomShootEffects = nil
		end,
		Behaviour = "dumb"
	}
}

SWEP.LoweredPos = Vector(0, -16, -13)
SWEP.LoweredAng = Angle(45, 0, 0)

sound.Add({
	name = "Weapon_M60.Single",
	sound = "dm1973/weapons/m60-1.wav",
	channel = CHAN_WEAPON,
	level = SNDLVL_GUNFIRE,
	pitch = {95, 105}
})
