include("shared.lua")

local lightMat = Material("sprites/glow04_noz")
local lightCols = {
	Color(255, 50, 50),
	Color(50, 255, 50),
	Color(50, 50, 255)
}

function ENT:Draw()
	self:DrawModel()

	local position = self:GetPos()
	local angles = self:GetAngles()
	local color = self:GetLight()

	cam.Start3D()
		render.SetMaterial(lightMat)
		render.DrawSprite(position + self:GetForward() * 7.6 + self:GetRight() * -5 + self:GetUp() * 3, 8, 8, lightCols[color])
	cam.End3D()
end
