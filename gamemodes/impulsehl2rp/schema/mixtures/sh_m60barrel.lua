local MIX = {}

MIX.Class = "m60barrel"

MIX.Level = 9
MIX.Bench = "weapon"

MIX.Output = "util_m60barrel"
MIX.Input = {
	["util_pipe"] = {take = 6},
	["util_glue"] = {take = 3},
	["food_water"] = {take = 1}
}

impulse.RegisterMixture(MIX)
