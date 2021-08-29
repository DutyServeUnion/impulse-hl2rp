ENT.Base			= "base_gmodentity" 
ENT.Type			= "anim"
ENT.PrintName		= "Combine Terminal"
ENT.Author			= "vin"
ENT.Purpose			= ""
ENT.Instructions	= "Press E"
ENT.Category 		= "impulse"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.HUDName = "Combine Terminal"
ENT.HUDDesc = "This can be used by UU personnel."

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "NetworkedUser")
	self:NetworkVar("Bool", 0, "ConvictIndex")
	self:NetworkVar("Bool", 1, "OverwatchIndex")
end
