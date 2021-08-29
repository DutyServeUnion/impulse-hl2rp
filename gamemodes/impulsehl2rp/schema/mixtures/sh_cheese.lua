local MIX = {}

MIX.Class = "cheese"

MIX.Level = 5
MIX.Bench = "stove"
MIX.XPMultiplier = 0.5

MIX.Output = "food_cheese"
MIX.Input = {
	["food_water"] = {take = 2},
	["util_milk"] = {take = 4}
}

impulse.RegisterMixture(MIX)
