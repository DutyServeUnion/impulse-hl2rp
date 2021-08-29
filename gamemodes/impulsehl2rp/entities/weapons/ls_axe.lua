AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "Axe"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/hl2meleepack/w_axe.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_axe.mdl")
SWEP.ViewModelFOV = 65

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.ImpactSoundWorldOnly = true
SWEP.Primary.Recoil = 1.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 19 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.HitDelay = 0.3
SWEP.Primary.Delay = 0.9
SWEP.Primary.Range = 75
SWEP.Primary.StunTime = 0.3

function SWEP:PrePrimaryAttack()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("misscenter1"))
end

function SWEP:MeleeHitFallback(tr)
	if tr and tr.MatType == MAT_WOOD then
		if self.Owner.TreeLastPos and self.Owner.TreeLastPos:DistToSqr(self.Owner:GetPos()) < 6200 then
			self.Owner.TreeLastHP = (self.Owner.TreeLastHP or math.random(5, 8)) - 1

			if self.Owner.TreeLastHP < 1 then
				if self.Owner:CanHoldItem("util_wood") then
					self.Owner:GiveInventoryItem("util_wood")
					self.Owner:Notify("You have gained 1 piece of wood.")

					self.Owner.TreeLastPos = self.Owner:GetPos()
					self.Owner.TreeLastHP = math.random(5, 8)
				else
					self.Owner:Notify("You don't have the space to hold wood.")
					self.Owner.TreeLastPos = self.Owner:GetPos()
					self.Owner.TreeLastHP = 5
				end
			end
		else
			self.Owner.TreeLastPos = self.Owner:GetPos()
			self.Owner.TreeLastHP = math.random(5, 8)
		end

		self:EmitSound("Wood.ImpactHard")

		return true
	end

	return false
end
