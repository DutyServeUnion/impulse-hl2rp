include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

local stageNames = {
	[0] = "Dirty Laundry",
	[1] = "Wet Laundry",
	[2] = "Dried Laundry",
	[3] = "Folded Laundry"
}

function ENT:Think()
	local stage = self:GetStage()

	if stage and stageNames[stage] then
		self.HUDName = stageNames[stage]
	end
end
