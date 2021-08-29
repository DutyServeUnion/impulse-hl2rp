local MIX = {}

MIX.Class = "wepmolotov"

MIX.Level = 4
MIX.Bench = "general"

MIX.Output = "wep_molotov"
MIX.Input = {
	["util_cloth"] = {take = 8},
	["food_water"] = {take = 1},
	["util_moonshine"] = {take = 1}
}

impulse.RegisterMixture(MIX)
