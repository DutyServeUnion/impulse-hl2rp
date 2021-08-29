include('shared.lua')
local scannerPos = 0
local glowMat = Material("sprites/glow04_noz")

function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > (250 ^ 2) then return end

	local entPos = self:GetPos()
	local entAng = self:GetAngles()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = pos + ang:Up() * 15.3
	pos = pos + ang:Forward() * 8.5
	pos = pos + ang:Right() * 5.7

	self.buttonLocation = self.buttonLocation or {}

	self.buttonLocation[1] = pos + ang:Forward() * 1.2 + ang:Right() * -7 + ang:Up() * -7.7
	self.buttonLocation[2] = pos + ang:Forward() * 1.2 + ang:Right() * -14.5 + ang:Up() * -7.7

	ang:RotateAroundAxis(entAng:Up(), -90)
	ang:RotateAroundAxis(entAng:Right(), -90)
	ang:RotateAroundAxis(entAng:Forward(), 180)


	cam.Start3D2D(pos, ang, 0.07)
		surface.SetDrawColor(255, 197, 143, 75)
		surface.DrawRect(0, 0, 245, 50)
		surface.DrawRect(-80, 0, 50, 40)

		draw.SimpleText(math.Round(self:GetFrequency(), 1), "BudgetLabel", -75, 7.5, color_white, 0, 0)


		surface.SetDrawColor(0, 0, 0, 255)

		local i = 0
		while(i < 25) do
			if i % 2 == 0 then
				surface.DrawRect(i * 10, 30, 5, 20)
			else
				surface.DrawRect(i * 10, 15, 5, 40)
			end
			i = i + 1
		end

		surface.SetDrawColor(255, 0, 0, 255)
		surface.DrawRect((self:GetFrequency() * 6.171284634760705) - 497, 15, 1, 40)

	cam.End3D2D()

	render.SetMaterial(glowMat)
	render.DrawSprite(self.buttonLocation[1], 4, 4, Color(50, 180, 50))
	render.DrawSprite(self.buttonLocation[2], 4, 4, Color(50, 180, 50))

end

