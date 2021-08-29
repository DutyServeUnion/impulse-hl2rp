local VENDOR = {}

VENDOR.UniqueID = "cpreq"
VENDOR.Name = "Requisition Supply Officer"
VENDOR.Desc = "Can supply Civil Protection officers with equipment."

VENDOR.Model = "models/dpfilms/metropolice/elite_police.mdl"
VENDOR.Skin = 0
VENDOR.Bodygroups = "01" -- manhack
VENDOR.Gender = "cp" -- male, female, cp
VENDOR.Talk = true

VENDOR.Sell = {
	["item_ziptie"] = {
		Restricted = true,
		Max = 4
	},
	["item_healthvial"] = {
		Desc = "i2+ only",
		Restricted = true,
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_I2
		end
	},
	["wep_smg"] = {
		Desc = "JW & i2+ only",
		Restricted = true,
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			if impulse.Dispatch.GetCityCode() >= 3 and ply:GetTeamRank() and ply:GetTeamRank() >= RANK_I2 then
				return true
			end

			return false
		end
	},
	["cos_riothelmet"] = {
		Desc = "Civil Unrest only",
		Restricted = true,
		Max = 1,
		CanBuy = function(ply)
			if impulse.Dispatch.GetCityCode() >= 2 then
				return true
			end

			return false
		end
	},
	["item_manhack"] = {
		Desc = "Civil Unrest & GRID i1+ only",
		Restricted = true,
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			if impulse.Dispatch.GetCityCode() >= 2 and ply:GetTeamClass() == CLASS_GRID and ply:GetTeamRank() >= RANK_I1 then
				return true
			end

			return false
		end
	},
	["wep_teargas"] = {
		Desc = "Civil Unrest & GRID i1+ only",
		Restricted = true,
		Max = 1,
		Cooldown = 600,
		CanBuy = function(ply)
			if (impulse.Dispatch.GetCityCode() >= 2 and ply:GetTeamClass() == CLASS_GRID and ply:GetTeamRank() >= RANK_I1) or ply:GetTeamClass() == CLASS_VICE then
				if SERVER then
					ply:Notify("You may only use Tear Gas for non-lethal situations when Civil Unrest is enabled.")
				end

				return true
			end

			return false
		end
	},
	["item_camerarepairkit"] = {
		Desc = "GRID only",
		Restricted = true,
		Max = 2,
		CanBuy = function(ply)
			if ply:GetTeamClass() == CLASS_GRID then
				return true
			end

			return false
		end
	},
	["wep_medkit"] = {
		Desc = "HELIX only",
		Restricted = true,
		Max = 1,
		CanBuy = function(ply)
			if ply:GetTeamClass() == CLASS_HELIX then
				return true
			end

			return false
		end
	},
	["wep_357"] = {
		Desc = "DcO+ only",
		Restricted = true,
		Max = 1,
		CanBuy = function(ply)
			return ply:GetTeamRank() >= RANK_DCO
		end
	},
	["item_breachingcharge"] = {
		Desc = "VICE only",
		Restricted = true,
		Max = 1,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_VICE
		end
	}
}

VENDOR.Buy = {}

function VENDOR:CanUse(ply)
	return ply:Team() == TEAM_CP and ply:GetTeamClass() != nil
end

function VENDOR:OnItemPurchased(class, ply)
	if class == "wep_357" and ply:HasInventoryItem("wep_pistol") then
		ply:TakeInventoryItemClass("wep_pistol")
	end
end

impulse.RegisterVendor(VENDOR)
