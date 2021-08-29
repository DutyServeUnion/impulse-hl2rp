local MIX = {}

MIX.Class = "wine"

MIX.Level = 8
MIX.Bench = "stove"
MIX.XPMultiplier = 0.5

MIX.Output = "food_wine"
MIX.Input = {
	["food_water"] = {take = 3},
	["food_apple"] = {take = 2}
}

impulse.RegisterMixture(MIX)
