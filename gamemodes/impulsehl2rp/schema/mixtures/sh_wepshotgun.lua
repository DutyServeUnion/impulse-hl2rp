local MIX = {}

MIX.Class = "wepshotgun"

MIX.Level = 6
MIX.Bench = "weapon"

MIX.Output = "wep_shotgun"
MIX.Input = {
	["util_pipe"] = {take = 4},
	["util_glue"] = {take = 3},
	["util_gear"] = {take = 2},
	["util_refinedmetalplate"] = {take = 3}
}

impulse.RegisterMixture(MIX)

