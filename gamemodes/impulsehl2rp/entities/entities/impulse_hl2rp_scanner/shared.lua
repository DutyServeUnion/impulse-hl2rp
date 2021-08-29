ENT.Type = "anim"
ENT.PrintName		= "Scanner"
ENT.Author			= "aLoneWitness"
ENT.Category 		= "impulse"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.DefaultMaxSpeed = 90
ENT.DefaultMaxSpeedUpDown = 75
ENT.MaxSpeed = ENT.DefaultMaxSpeed
ENT.MaxSpeedUpDown = ENT.DefaultMaxSpeedUpDown
ENT.MaxSpeedSquared = ENT.MaxSpeed ^ 2
ENT.AccelXY = 0
ENT.AccelZ = 0
ENT.BoostMultiplier = 1.8
ENT.ScannerTarget = nil
ENT.KnownPlayers = {}

------

ENT.TargetDirection = vector_origin
ENT.FaceAngles = Angle(0, 0, 0)
ENT.AccelAngular = Vector(0, 0, 0)
ENT.LastScanTime = CurTime()

ENT.maxHealth = 100
ENT.health = ENT.maxHealth

ENT.painSounds = {
    "npc/scanner/scanner_pain1.wav",
    "npc/scanner/scanner_pain2.wav",
    "npc/scanner/scanner_alert1.wav",
}

-- Scanning Ruleset
ENT.ScanTime = 10
ENT.ScanIntervals = 10
ENT.ScanAllowMiss = 4


function ENT:GetCurrentTarget()
    return self.ScannerTarget
end

function ENT:Think()
    local pilot = self:GetPilot()
    local trace = {}
	trace.start = self:EyePos()
	trace.endpos = trace.start + pilot:GetAimVector() * 200
	trace.filter = {pilot, self}
	local traceData = util.TraceLine(trace)
	local traceEnt = traceData.Entity
    if traceEnt:IsPlayer() then
        self.ScannerTarget = traceEnt
    else
        self.ScannerTarget = nil        
    end

    self:PostThink()
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Pilot")
    self:NetworkVar("Bool", 0, "IsScanning")
    self:NetworkVar("Int", 0, "StartTime")
    self:NetworkVar("Int", 1, "EndTime")
    self:NetworkVar("Entity", 1, "ScanTarget")
    if SERVER then
        self:SetStartTime(0)
        self:SetEndTime(0)
        self:SetIsScanning(false)
    end
end

function ENT:IsPlayerKnown(ply)
    if ply:IsCP() then
        return true
    else
        return table.HasValue(self.KnownPlayers, ply)
    end
end

function ENT:AddScannedPlayer(ply)
    table.insert(self.KnownPlayers, ply) 
end


