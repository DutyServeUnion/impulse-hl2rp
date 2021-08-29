ENT.Type = "anim"
ENT.PrintName		= "Ration Dispenser"
ENT.Author			= "vin, aLoneWitness"
ENT.Category 		= "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true 
ENT.NextDispenseTime = 0

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Light")
end
