local VENDOR = {}

VENDOR.UniqueID = "otareq"
VENDOR.Name = "Overwatch Requisition Supply Officer"
VENDOR.Desc = "Can supply OTA units with equipment."

VENDOR.Model = "models/Combine_Soldier_PrisonGuard.mdl"
VENDOR.Skin = 1
VENDOR.Sequence = "idle_unarmed"
VENDOR.Gender = "cp" -- male, female, cp
VENDOR.Talk = true

VENDOR.Sell = {
	["item_ziptie"] = {
		Restricted = true,
		Max = 1
	},
	["item_healthvial"] = {
		Restricted = true,
		Max = 1,
		Cooldown = 600
	},
	["att_evrscope"] = {
		Desc = "RANGER only",
		Restricted = true,
		Max = 1,
		Cooldown = 60,
		CanBuy = function(ply)
			return ply:GetTeamClass() == CLASS_RANGER
		end
	},
	["item_breachingcharge"] = {
		Restricted = true,
		Max = 3
	}
}

VENDOR.Buy = {}

function VENDOR:CanUse(ply)
	return ply:Team() == TEAM_OTA and ply:GetTeamClass() != nil
end

impulse.RegisterVendor(VENDOR)
