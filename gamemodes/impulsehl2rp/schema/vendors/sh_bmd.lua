local VENDOR = {}

VENDOR.UniqueID = "bmd"
VENDOR.Name = "Black Market Dealer"
VENDOR.Desc = "Can trade contraband items."

VENDOR.Model = "models/odessa.mdl"
VENDOR.Skin = 0
VENDOR.Gender = "male" -- male, female, cp
VENDOR.Talk = true

VENDOR.Sell = {
	["util_bulletcasing"] = {
		Cost = 90
	},
	["util_cloth"] = {
		Cost = 25
	},
	["util_gunpowder"] = {
		Cost = 58,
		BuyMax = 7,
		TempCooldown = 1200
	},
	["util_wood"] = {
		Cost = 25
	},
	["item_lockpick"] = {
		Cost = 200
	},
	["ammo_pistol"] = {
		Cost = 150
	},
	["util_spices"] = {
		Cost = 35
	},
	["util_yeast"] = {
		Cost = 50
	},
	["util_glue"] = {
		Cost = 40,
		BuyMax = 6,
		TempCooldown = 600
	},
	["util_plastic"] = {
		Cost = 45,
		BuyMax = 8,
		TempCooldown = 1200
	}
}

VENDOR.Buy = {
	["util_moonshine"] = {
		Cost = 190
	},
	["util_fuel"] = {
		Cost = 300
	}
}

function VENDOR:CanUse(ply)
	return not ply:IsCP()
end

function VENDOR:Initialize()
    self.Positions = impulse.Config.DealerLocations
    self.NextMove = CurTime() + 10
end

local function moveToNextPosition(ent)
	ent.NextMove = CurTime() + math.random(impulse.Config.DealerTeleportTimeMin, impulse.Config.DealerTeleportTimeMax)
    local newPosition = ent.Positions[math.random(#ent.Positions)]

    if newPosition.pos == ent:GetPos() then
        return moveToNextPosition(ent)
    end

    if impulse.IsEmpty(newPosition.pos) then
        ent:SetPos(newPosition.pos)
        ent:SetAngles(newPosition.ang)
    else
        -- decreases chance of position being built on, however it is intentionally not perfect to stop players from making dupes to force the npc pos
        newPosition = ent.Positions[math.random(#ent.Positions)]
        ent:SetPos(newPosition.pos)
        ent:SetAngles(newPosition.ang)
    end

    ent:RemoveAllDecals()
end

function VENDOR:Think()
    if CurTime() > self.NextMove then
        moveToNextPosition(self)
    end

    self:NextThink(CurTime() + 8)
    return true
end

impulse.RegisterVendor(VENDOR)
