include('shared.lua')

local lightMat = Material("sprites/glow04_noz")
local colBlue, colGreen = Color(50, 50, 255), Color(50, 255, 50)

function ENT:Draw()
	self:DrawModel()

	local position = self:GetPos()
	local angles = self:GetAngles()
	local position = self:GetPos()
	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

	local buttonLocation = position + f*25 + r*15 + u*6

	angles:RotateAroundAxis(angles:Up(), 90)
	angles:RotateAroundAxis(angles:Forward(), 90)

	render.SetMaterial(lightMat)
	if self:GetWashing() then
		render.DrawSprite(buttonLocation, 16, 16, colBlue)
	else
		render.DrawSprite(buttonLocation, 16, 16, colGreen)
	end
end

function ENT:Think()
	local previousState = previousState or nil

	if IsValid(self.claundry) then
		local angle = self.claundry:GetAngles().z
		local parentAngle = self:GetAngles()
		angle = angle + FrameTime() * 300
		self.claundry:SetAngles(Angle(parentAngle.x, parentAngle.y, angle))
	end

	if self:GetWashing() == false and previousState != false then
		previousState = self:GetWashing()
		if IsValid(self.claundry) then
			self.claundry:Remove()
		end
	elseif self:GetWashing() then
		if IsValid(self.claundry) then return end
		self.claundry = ents.CreateClientProp()
		self.claundry:SetModel("models/props_junk/garbage_bag001a.mdl")
		self.claundry:SetPos(self:GetPos() + Vector(0, 0, 5))
		self.claundry:SetMaterial("models/props_c17/FurnitureFabric003a")
		self.claundry:SetMoveType(MOVETYPE_NONE)
		self.claundry:SetParent(self)
		self.claundry:SetModelScale(2)
		self.claundry:Spawn()
	end
end

