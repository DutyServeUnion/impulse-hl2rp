include("shared.lua")
local bzSplineVectors = {Vector(-20, 0, 0), Vector(-30, 0, 0), Vector(120, 0, 0), Vector(90, 0, 0)}

function ENT:Draw()
    if self:GetPilot() ~= LocalPlayer() then
        self:DrawModel()
    end
end

function ENT:Think()
    local pilot = self:GetPilot()
    if not pilot then return end
    if not IsValid(pilot) then return end
    if pilot != LocalPlayer() then return end

    if(pilot:KeyDown(IN_RELOAD)) then
        if (self.NextQuitAttempt or 0) > CurTime() then return end
        self.NextQuitAttempt = CurTime() + 5
        local panel = vgui.Create("impulseQuitScanner")
        panel:Show()
        panel:MakePopup()
    end
end

function ENT:PostThink()
    local velocity = self:GetVelocity()
    local lengthSqr = velocity:LengthSqr()
    self.Wheel = self.Wheel or 360
    self.Wheel = self.Wheel - math.min((lengthSqr / 80) + 250, 900) * FrameTime()

    if (self.Wheel < 0) then
        self.Wheel = 360
    end

    self:SetPoseParameter("dynamo_wheel", self.Wheel)
    local velocity = self:GetVelocity()
    self.Tail = Lerp(FrameTime() * 5, self.Tail or 0, math.BSplinePoint(velocity.z / self.MaxSpeed, bzSplineVectors, 1).x)
    self:SetPoseParameter("tail_control", self.Tail)
    local pilot = self:GetPilot()
    local angles = self:GetAngles()
    local eyeAngles = IsValid(pilot) and pilot:EyeAngles() or angles
    local hDiff = math.AngleDifference(eyeAngles.y, angles.y) / 45
    local vDiff = math.AngleDifference(eyeAngles.p, angles.p) / 45
    self:SetPoseParameter("flex_horz", hDiff * 20)
    self:SetPoseParameter("flex_vert", vDiff * 20)
end

net.Receive("impulseHL2RPScannerFlash", function()
    local entity = net.ReadEntity()
    if entity:GetClass() != "impulse_hl2rp_scanner" then return end
    if(IsValid(entity)) then
        local light = DynamicLight(entity:EntIndex())
        if not light then return end
        
        light.pos = entity:GetPos() + entity:GetForward() * 24
        light.r = 255
        light.g = 255
        light.b = 255
        light.brightness = 5
        light.Decay = 5000
        light.Size = 360
        light.DieTime = CurTime() + 1
    end
end)

net.Receive("impulseHL2RPScannerAddPlayerToScannedList", function()
    if not LocalPlayer():IsScanner() then return end
    local scanner = LocalPlayer():GetScannerFromPlayer()
    scanner:AddScannedPlayer(Entity(net.ReadInt(8)))
end)

