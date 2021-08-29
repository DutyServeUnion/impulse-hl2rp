local MIX = {}

MIX.Class = "wepsmg"

MIX.Level = 5
MIX.Bench = "weapon"

MIX.Output = "wep_smg"
MIX.Input = {
	["util_pipe"] = {take = 2},
	["util_glue"] = {take = 1},
	["util_gear"] = {take = 1},
	["util_refinedmetalplate"] = {take = 3}
}

impulse.RegisterMixture(MIX)
