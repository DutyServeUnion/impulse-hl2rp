ENT.Base			= "base_anim"
ENT.Type			= "anim"
ENT.PrintName		= "Ammo Crate"
ENT.Author			= "vin, aLoneWitness"
ENT.Category 		= "impulse"
ENT.AutomaticFrameAdvance = true

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.HUDName = "Ammo Crate"
ENT.HUDDesc = "Retrieve your ammunition."

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "DrillEndTime")
end
