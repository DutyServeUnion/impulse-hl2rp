local MIX = {}

MIX.Class = "wepak47"

MIX.Level = 7
MIX.Bench = "weapon"

MIX.Output = "wep_ak47"
MIX.Input = {
	["util_pipe"] = {take = 3},
	["util_glue"] = {take = 4},
	["util_gear"] = {take = 1},
	["util_refinedmetalplate"] = {take = 4},
	["util_wood"] = {take = 2}
}

impulse.RegisterMixture(MIX)
