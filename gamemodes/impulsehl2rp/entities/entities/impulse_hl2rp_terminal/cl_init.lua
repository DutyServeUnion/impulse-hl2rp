include("shared.lua")

local boolToConnected = {
	[true] = "CONNECTED",
	[false] = "DISCONNECTED"
}
function ENT:Draw()
	self:DrawModel()

	local user = self:GetNetworkedUser()
	local displayText = "TERMINAL: "..self:EntIndex()
	local terminalCol = Color(0, 100, 200, 255)

	local cityCode = impulse.Dispatch.GetCityCode()

	if cityCode >= CODE_JW then
		terminalCol = Color(150, 0, 0, 255)
	end

	if not user or user == -1 then
		displayText = displayText.."\nNO ACTIVE USER"
	else
		user = Entity(user)

		if IsValid(user) and user:IsPlayer() and user:IsCP() then
			displayText = displayText.."\nUSER: "..user:Name()

			if cityCode >= CODE_JW then
				terminalCol = Color(210, 0, 0, 255)
			else
				terminalCol = Color(0, 151, 255, 255)
			end
		end
	end

	displayText = displayText.."\nTIME: "..os.date("%H:%M:%S - %d/%m", os.time()).."\n\nHUMAN INDEX: CONNECTED\nCONVICT INDEX: "..boolToConnected[self:GetConvictIndex()].."\nOVERWATCH INDEX: "..boolToConnected[self:GetOverwatchIndex()]

	local entPos = self:GetPos()
	local entAng = self:GetAngles()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = pos + (ang:Up() * 48.1)
	pos = pos + (ang:Forward() * -2.36)
	pos = pos + (ang:Right() * 9.8)

	ang:RotateAroundAxis(entAng:Up(), 90)
	ang:RotateAroundAxis(entAng:Right(), -42)

	cam.Start3D2D(pos, ang, 0.07)
		surface.SetDrawColor(terminalCol)
		surface.DrawRect(0, 0, 221, 115)
		draw.DrawText(displayText, "DebugFixed", 8, 4, color_white, TEXT_ALIGN_LEFT)
	cam.End3D2D()
end

sound.Add({
	name = "terminal_idle",
	channel = CHAN_STATIC,
	level = 60,
	volume = 1,
	sound = "ambient/machines/combine_terminal_loop1.wav"
})

function ENT:Think()
	if (self.nextTerminalCheck or 0) < CurTime() then
		local plyPos = LocalPlayer():GetPos()

		if (plyPos - self:GetPos()):LengthSqr() <= (600 ^ 2) then
			if not self.Emitting then
				self:EmitSound("terminal_idle")
				self.Emitting = true
			end
		elseif self.Emitting then
			self:StopSound("terminal_idle")
			self.Emitting = false
		end

		self.nextTerminalCheck = CurTime() + 2
	end
end
