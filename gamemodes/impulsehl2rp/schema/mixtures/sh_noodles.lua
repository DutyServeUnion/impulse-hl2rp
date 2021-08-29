local MIX = {}

MIX.Class = "noodles"

MIX.Level = 4
MIX.XPMultiplier = 0.3
MIX.Bench = "stove"

MIX.Output = "food_noodles"
MIX.Input = {
	["util_milk"] = {take = 1},
	["util_yeast"] = {take = 1}
}

impulse.RegisterMixture(MIX)
