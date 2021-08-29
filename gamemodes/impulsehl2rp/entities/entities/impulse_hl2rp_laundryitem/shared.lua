ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Laundry"
ENT.Category 		= "impulse - factory"

ENT.Spawnable = false
ENT.AdminOnly = true

ENT.MaxCapacity = 6

ENT.HUDName = "Laundry"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Stage")
end
