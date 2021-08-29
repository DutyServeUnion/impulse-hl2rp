ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.PrintName = "Brewing Barrel"
ENT.Author = "aLoneWitness"
ENT.Category = "impulse - alcohol"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.HUDName = "Brewing Barrel"
ENT.HUDDesc = "Used to brew moonshine."

ENT.Ingredients = {
    {
        name = "Water",
        isPresent = false
    },
    {
        name = "Yeast",
        isPresent = false
    },
    {
        name = "Spices",
        isPresent = false
    }
}

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "StartTime")
    self:NetworkVar("Int", 1, "EndTime")
    if SERVER then
        self:SetStartTime(0)
        self:SetEndTime(0)
    end
end


