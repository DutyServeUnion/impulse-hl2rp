local VENDOR = {}

VENDOR.UniqueID = "medical"
VENDOR.Name = "CWU Medical Supplier"
VENDOR.Desc = "Can sell medical supplies to the CWU."

VENDOR.Model = "models/player/impulse_zelpa/male_08.mdl"
VENDOR.Skin = 14
VENDOR.Bodygroups = "091"
VENDOR.Gender = "male" -- male, female, cp
VENDOR.Talk = true

VENDOR.Sell = {
	["item_healthkit"] = {
		Cost = 40,
		Max = 3,
		Restricted = true
	},
	["item_splint"] = {
		Cost = 10,
		BuyMax = 4,
		TempCooldown = 600
	},
	["item_doxepin"] = {
		Cost = 120,
		Max = 3,
		Restricted = true
	},
	["cos_surgerymask"] = {
		Max = 1,
		Restricted = true
	}
}

function VENDOR:CanUse(ply)
	return ply:Team() == TEAM_CWU and ply:GetTeamClass() == CLASS_MEDIC
end

impulse.RegisterVendor(VENDOR)
