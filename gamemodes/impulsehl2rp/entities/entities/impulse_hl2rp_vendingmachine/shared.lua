ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Vending Machine"
ENT.Author = "aLoneWitness"
ENT.Category = "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Stock1")
    self:NetworkVar("Bool", 1, "Stock2")
    self:NetworkVar("Bool", 2, "Stock3")
end

function ENT:GetNearestButton(client)
    client = client or (CLIENT and LocalPlayer())

    if SERVER then
        local position = self:GetPos()
        local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
        self.buttonLocation = self.buttonLocation or {}
        self.buttonLocation[1] = position + f * 18 + r * -24.4 + u * 5.3
        self.buttonLocation[2] = position + f * 18 + r * -24.4 + u * 3.35
        self.buttonLocation[3] = position + f * 18 + r * -24.4 + u * 1.35
    end

    local data = {}
    data.start = client:GetShootPos()
    data.endpos = data.start + client:GetAimVector() * 96
    data.filter = client
    local trace = util.TraceLine(data)
    local hitPos = trace.HitPos

    if (hitPos) then
        for k, v in pairs(self.buttonLocation) do
            if v:DistToSqr(hitPos) < 4 then return k end
        end
    end
end
