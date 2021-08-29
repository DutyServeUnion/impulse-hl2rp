local MIX = {}

MIX.Class = "sniperscope"

MIX.Level = 10
MIX.Bench = "weapon"

MIX.Output = "att_huntingscope"
MIX.Input = {
	["util_pipe"] = {take = 2},
	["util_glue"] = {take = 2},
	["util_gear"] = {take = 1},
	["util_plastic"] = {take = 2},
	["util_electronics"] = {take = 3}
}

impulse.RegisterMixture(MIX)
