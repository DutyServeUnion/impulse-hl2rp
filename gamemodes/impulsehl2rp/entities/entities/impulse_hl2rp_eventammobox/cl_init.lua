include("shared.lua")

local black = Color(0, 0, 0)
local fore = Color(255, 140, 0)
function ENT:Draw()
	self:DrawModel()

	if not self.GetDrillEndTime then
		return
	end

	local drillEnd = self:GetDrillEndTime()

	if drillEnd == 0 then
		if IsValid(self.Drill) then
			timer.Simple(0, function() if IsValid(self.Drill) then self.Drill:Remove() end end) -- cant remove when rendering
		end

		return
	end

	local entPos = self:GetPos()
	local entAng = self:GetAngles()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = pos + (ang:Up() * 1)
	pos = pos + (ang:Forward() * 26.6)
	pos = pos + (ang:Right() * -19)

	ang:RotateAroundAxis(entAng:Up(), 180)

	if not IsValid(self.Drill) then
		self.Drill = ents.CreateClientProp()
		self.Drill:SetModel("models/pd2_drill/drill.mdl")
		self.Drill:SetPos(pos)
		self.Drill:SetAngles(ang)
		self.Drill:SetParent(self)
		self.Drill:Spawn()
		self:CallOnRemove("cleanupDrill", function()
			if IsValid(self.Drill) then
				self.Drill:Remove()
			end
		end)

		hook.Add("PostDrawTranslucentRenderables", "drawDrillStuff", function() -- hacky af
			if not IsValid(self.Drill) then
				return hook.Remove("PostDrawTranslucentRenderables", "drawDrillStuff")
			end

			local entPos = self:GetPos()
			local entAng = self:GetAngles()
			local pos = self:GetPos()
			local ang = self:GetAngles()

			pos = pos + (ang:Up() * 1)
			pos = pos + (ang:Forward() * 26.6)
			pos = pos + (ang:Right() * -19)

			ang:RotateAroundAxis(entAng:Up(), 180)

			self.Drill:DrawModel()

			pos = pos + (ang:Right() * -9.7)
			pos = pos + (ang:Forward() * 6.7)
			pos = pos + (ang:Up() * 7.4)

			ang:RotateAroundAxis(entAng:Up(), -90)
			ang:RotateAroundAxis(entAng:Right(), -60)

			cam.Start3D2D(pos, ang, 0.07)
				surface.SetDrawColor(black)
				surface.DrawRect(0, 0, 105, 85)

				draw.DrawText("TIME LEFT:", "DebugFixed", 7, 4, fore, TEXT_ALIGN_LEFT)


				local delta = math.Clamp(self:GetDrillEndTime() - CurTime(), 0, 999)
				draw.DrawText(string.FormattedTime(delta, "%02i:%02i:%02i"), "DebugFixed", 7, 21, fore, TEXT_ALIGN_LEFT)
			cam.End3D2D()
		end)
	end
end
