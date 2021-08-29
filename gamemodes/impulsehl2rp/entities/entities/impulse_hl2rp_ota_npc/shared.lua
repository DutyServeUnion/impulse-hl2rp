ENT.Type = "anim"
ENT.PrintName = "OTA NPC"
ENT.Author = "vin"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.HUDName = "Overwatch Transhuman Arm Officer"
ENT.HUDDesc = "Select your division and rank."

function ENT:DoAnimation()
	for k,v in ipairs(self:GetSequenceList()) do
		if v:lower():find("idle_unarmed") then
			return self:ResetSequence(k)
		end
	end

	self:ResetSequence(4)
end
