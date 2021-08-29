ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Washer"
ENT.Author			= "aLoneWitness"
ENT.Contact			= "@aLoneWitness#8734"
ENT.Purpose			= "Laundry machine to wash laundry in."
ENT.Instructions	= "Laundry machine to wash laundry in."
ENT.Category 		= "impulse - factory"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.HUDName = "Washing Machine"
ENT.HUDDesc = "Cleans dirty laundry."

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Washing")
end

