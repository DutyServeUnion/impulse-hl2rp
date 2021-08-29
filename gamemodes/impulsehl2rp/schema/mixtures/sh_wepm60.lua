local MIX = {}

MIX.Class = "wepm60"

MIX.Level = 9
MIX.Bench = "weapon"

MIX.Output = "wep_m60"
MIX.Input = {
	["util_m60barrel"] = {take = 1},
	["util_glue"] = {take = 3},
	["util_gear"] = {take = 4},
	["util_refinedmetalplate"] = {take = 5}
}

impulse.RegisterMixture(MIX)
