local MIX = {}

MIX.Class = "bread"

MIX.Level = 1
MIX.XPMultiplier = 0.3
MIX.Bench = "stove"

MIX.Output = "food_bread"
MIX.Input = {
	["food_water"] = {take = 1},
	["util_yeast"] = {take = 1}
}

impulse.RegisterMixture(MIX)
