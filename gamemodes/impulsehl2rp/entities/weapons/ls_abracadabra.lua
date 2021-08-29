AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Abra Cadabra"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"

SWEP.WorldModel = Model("models/weapons/w_stunbaton.mdl")
SWEP.ViewModel = Model("models/weapons/c_stunstick.mdl")
SWEP.CustomMaterial = "models/props_combine/stasisshield_sheet"
SWEP.ViewModelFOV = 52

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("NPC_RollerMine.Shock")
SWEP.Primary.ImpactEffect = "cball_explode"
SWEP.Primary.Recoil = 3.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 15 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.7
SWEP.Primary.HitDelay = 0
SWEP.Primary.Range = 81
SWEP.Primary.FlashTime = 2
SWEP.Primary.FlashColour = Color(51, 147, 255)
SWEP.Primary.HullSize = 7
