local VENDOR = {}

VENDOR.UniqueID = "fisherman"
VENDOR.Name = "Mysterious Fisherman"
VENDOR.Desc = "Can trade a variety rare and common items."

VENDOR.Model = "models/sirgibs/ragdolls/hl2/fisherman.mdl"
VENDOR.Skin = 0
VENDOR.Sequence = "lineidle02"
VENDOR.Gender = "fisherman" -- male, female, cp
VENDOR.Talk = true

VENDOR.DownloadTrades = true -- use for vendors that change what they buy/sell at runtime

VENDOR.MaxBuys = 8

VENDOR.RandomTrades = {
	Sell = {
		["ammo_357"] = {Rarity = 850, Cost = {150, 230}, BuyMax = 1},
		["ammo_smg"] = {Rarity = 800, Cost = {80, 330}, BuyMax = 2},
		["cos_fishcap"] = {Rarity = 980, Cost = {250, 500}, BuyMax = 1},
		["cos_combatgasmask"] = {Rarity = 890, Cost = {100, 150}, BuyMax = 1},
		["wep_pistol"] = {Rarity = 780, Cost = {70, 250}, BuyMax = 1},
		["wep_pickaxe"] = {Rarity = 500, Cost = {50, 101}, BuyMax = 2},
		["util_ruinedotavest"] = {Rarity = 890, Cost = {260, 699}, BuyMax = 1},
		["wep_goldengun"] = {Rarity = 999, Cost = {12000, 35000}, BuyMax = 1},
		["wep_m60"] = {Rarity = 795, Cost = {500, 1400}, BuyMax = 1},
		["wep_smg"] = {Rarity = 690, Cost = {200, 460}, BuyMax = 1},
		["util_yeast"] = {Rarity = 600, Cost = {6, 13}, BuyMax = 6},
		["item_padlock"] = {Rarity = 580, Cost = {10, 20}, BuyMax = 2},
		["util_gear"] = {Rarity = 350, Cost = {19, 65}, BuyMax = 3},
		["util_plastic"] = {Rarity = 360, Cost = {42, 62}, BuyMax = 3},
		["util_gunpowder"] = {Rarity = 690, Cost = {42, 71}, BuyMax = 6},
		["util_cloth"] = {Rarity = 400, Cost = {5, 20}, BuyMax = 6}
	},
	Buy = {
		["util_fuel"] = {Cost = {140, 720}},
		["util_combinescrap"] = {Cost = {10, 45}}
	}
}

VENDOR.Sell = {}
VENDOR.Buy = {}

function VENDOR:CanUse(ply)
	return not ply:IsCP()
end

function VENDOR:OnItemPurchased(class, ply)
	if class == "cos_fishcap" then
		self:SetBodygroup(1, 1)
		ply:AchievementGive("ach_hardtimes")
	end
end

local function fishermanDisappear(ent)
	ent:EmitSound("lostcoast/vo/fisherman/fish_grieve02.wav")

	timer.Simple(3, function()
		if not IsValid(ent) then
			return
		end

		ent.BeenTriggered = false
		ent:SetPos(Vector(-4061.1323242188, 14661.44140625, 10783.806640625)) -- ik its messy
		ent:RemoveAllDecals()
		ent:SetNoDraw(true)
	end)
end

local function fishermanRandomInv(ent)
	ent.Vendor.Sell = {}
	ent.Vendor.Buy = {}

	for v,k in pairs(VENDOR.RandomTrades.Buy) do
		ent.Vendor.Buy[v] = {Cost = math.random(k.Cost[1], k.Cost[2])}
	end

	ent.Vendor.Sell["food_fish"] = {Cost = 68}

	local amount = 0
	for v,k in RandomPairs(VENDOR.RandomTrades.Sell) do
		local r = math.random(0, 1000)

		if r >= k.Rarity then
			ent.Vendor.Sell[v] = {Cost = math.random(k.Cost[1], k.Cost[2]), BuyMax = k.BuyMax, TempCooldown = 600, OnPurchased = k.OnPurchased}
			amount = amount + 1
		end

		if amount > 3 then
			break
		end
	end
end

local function fishermanAppear(ent)
	ent.BeenTriggered = true
	ent.Buys = 0
	fishermanRandomInv(ent)

	timer.Simple(360, function()
		if not IsValid(ent) then
			return
		end

		fishermanDisappear(ent)
	end)

	ent:SetNoDraw(false)
	ent:SetPos(ent.MainPos)
end

function VENDOR:Initialize()
	self.MainPos = impulse.Config.FishermanPos
	self:SetAngles(impulse.Config.FishermanAng)
	fishermanDisappear(self)
end

local timerMade = timerMade or false
function VENDOR:Think()
    self:NextThink(CurTime() + 2)

    if self.BeenTriggered then
    	return true
    end

    if GetDNCTime then
    	local time = GetDNCTime()

    	if time > 5.3 and time < 5.7 then -- its dawn
    		fishermanAppear(self)
    	end
    elseif not timerMade then
    	timer.Simple(3450, function()
    		if not IsValid(self) then
    			return
    		end

    		fishermanAppear(self)
    		timerMade = false
    	end)
    	
    	timerMade = true
    end

    return true
end

impulse.RegisterVendor(VENDOR)
