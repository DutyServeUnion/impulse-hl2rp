ENT.Base			= "base_anim"
ENT.Type			= "anim"
ENT.PrintName		= "Block Terminal"
ENT.Author			= "aLoneWitness"
ENT.Category 		= "impulse"
ENT.AutomaticFrameAdvance = true

ENT.Spawnable = true
ENT.AdminOnly = true


ENT.HUDName = "City-Block Terminal"
ENT.HUDDesc = "Apartment registration system."

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Block")
end

