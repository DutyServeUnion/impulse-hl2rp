local MIX = {}

MIX.Class = "metalplate"

MIX.Level = 3
MIX.Bench = "general"

MIX.Output = "util_metalplate"
MIX.Input = {
	["util_combinescrap"] = {take = 1}
}

impulse.RegisterMixture(MIX)
