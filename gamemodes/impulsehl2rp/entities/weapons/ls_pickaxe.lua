AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Pickaxe"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/hl2meleepack/w_pickaxe.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_pickaxe.mdl")
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.Recoil = 3.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 25 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1
SWEP.Primary.HitDelay = 0.4
SWEP.Primary.Range = 81
SWEP.Primary.StunTime = 0.8
SWEP.Primary.HullSize = 7
