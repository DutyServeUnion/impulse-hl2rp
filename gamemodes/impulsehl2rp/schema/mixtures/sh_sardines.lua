local MIX = {}

MIX.Class = "sardines"

MIX.Level = 3
MIX.Bench = "stove"
MIX.XPMultiplier = 0.5

MIX.Output = "food_sardines"
MIX.Input = {
	["food_water"] = {take = 1},
	["util_cookingoil"] = {take = 1},
	["util_meat"] = {take = 1}
}

impulse.RegisterMixture(MIX)
