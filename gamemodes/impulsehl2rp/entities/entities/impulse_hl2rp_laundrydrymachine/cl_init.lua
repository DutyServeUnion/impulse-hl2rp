include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    -- 250^2
    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 62500 then return end
    local position = self:GetPos()
    local angles = self:GetAngles()
    local position = self:GetPos()
    local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
    cam.Start3D2D(position + f * 25 + r * -9.5 + u * 23, angles + Angle(0, 180, 35), 0.06)
    draw.SimpleText(self.status[1], "DebugFixed", 0, 0, color_white, 0, 0)
    draw.SimpleText(self.status[2], "DebugFixed", 0, 36, color_white, 0, 0)
    draw.SimpleText(self.status[3], "DebugFixed", 0, 72, color_white, 0, 0)
    draw.SimpleText(self.status[4], "DebugFixed", 0, 108, color_white, 0, 0)
    cam.End3D2D()
    -- local percentage = math.Clamp(math.floor((CurTime() - self:GetStartTime()) / ((self:GetStartTime() + 40) - self:GetStartTime()) * 100), 0, 100)
    -- cam.Start3D2D(position + f * 16 + r * -9.5 + u * 23, angles + Angle(0, 180, 35), 0.06)
    -- if self:GetStartTime() != 0 then
    -- draw.SimpleText(percentage.. "%", "Impulse-Elements48", 0, 42, color_white, 0, 0)
    -- else
    -- draw.SimpleText("100%", "Impulse-Elements48", 0, 42, color_white, 0, 0)
    -- end
    -- cam.End3D2D()
    local laundryTable = {self:GetLaundry1(), self:GetLaundry2(), self:GetLaundry3(), self:GetLaundry4()}

    for v, k in pairs(laundryTable) do
        if k == LAUNDRYSTATE_EMPTY then
            self.status[v] = "Empty"
        elseif k == LAUNDRYSTATE_PROCESSING then
            self.status[v] = "Processing..."
        elseif k == LAUNDRYSTATE_DONE then
            self.status[v] = "Done"
        elseif k == LAUNDRYSTATE_DISPENSING then
            self.status[v] = "Dispensing..."
        end
    end
end
