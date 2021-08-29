local MIX = {}

MIX.Class = "pickaxe"

MIX.Level = 5
MIX.Bench = "general"

MIX.Output = "wep_pickaxe"
MIX.Input = {
	["util_metalplate"] = {take = 3},
	["util_wood"] = {take = 5}
}

impulse.RegisterMixture(MIX)
