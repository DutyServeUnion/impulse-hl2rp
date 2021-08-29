local MIX = {}

MIX.Class = "wepmini14"

MIX.Level = 8
MIX.Bench = "weapon"

MIX.Output = "wep_mini14"
MIX.Input = {
	["util_pipe"] = {take = 6},
	["util_glue"] = {take = 6},
	["util_gear"] = {take = 3},
	["util_refinedmetalplate"] = {take = 3},
	["util_wood"] = {take = 10}
}

impulse.RegisterMixture(MIX)
