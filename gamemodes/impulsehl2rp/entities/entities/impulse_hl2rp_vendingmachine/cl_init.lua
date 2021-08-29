include("shared.lua")

local redCol = Color(255, 50, 50)
local greenCol = Color(50, 255, 50)
function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 1300 ^ 2 then return end

	local position = self:GetPos()
	local angles = self:GetAngles()
	local position = self:GetPos()
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

	self.buttonLocation = self.buttonLocation or {}

	self.buttonLocation[1] = position + f*18 + r*-24.4 + u*5.3
	self.buttonLocation[2] = position + f*18 + r*-24.4 + u*3.35
	self.buttonLocation[3] = position + f*18 + r*-24.4 + u*1.35

	angles:RotateAroundAxis(angles:Up(), 90)
	angles:RotateAroundAxis(angles:Forward(), 90)

	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
	cam.Start3D2D(position + f*17.33 + r*-19.5 + u*5.75, angles, 0.06)
		draw.SimpleText("Regular", "Impulse-Elements13", 0, 0, color_white, 0, 0)
		draw.SimpleText("Sparkling", "Impulse-Elements13", 0, 36, color_white, 0, 0)
		draw.SimpleText("Special", "Impulse-Elements13", 0, 72, color_white, 0, 0)
	cam.End3D2D()

	render.SetMaterial(Material("sprites/glow04_noz"))

	if self:GetStock1() == false then
		render.DrawSprite(self.buttonLocation[1], 4, 4, redCol)
	else
		render.DrawSprite(self.buttonLocation[1], 4, 4, greenCol)
	end

	if self:GetStock2() == false then
		render.DrawSprite(self.buttonLocation[2], 4, 4, redCol)
	else
		render.DrawSprite(self.buttonLocation[2], 4, 4, greenCol)
	end

	if self:GetStock3() == false then
		render.DrawSprite(self.buttonLocation[3], 4, 4, redCol)
	else
		render.DrawSprite(self.buttonLocation[3], 4, 4, greenCol)
	end
end
