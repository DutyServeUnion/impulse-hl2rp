local MIX = {}

MIX.Class = "applepie"

MIX.Level = 7
MIX.Bench = "stove"
MIX.XPMultiplier = 0.5

MIX.Output = "food_applepie"
MIX.Input = {
	["util_milk"] = {take = 1},
	["util_yeast"] = {take = 2},
	["food_apple"] = {take = 2}
}

impulse.RegisterMixture(MIX)
