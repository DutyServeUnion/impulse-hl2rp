local MIX = {}

MIX.Class = "bulletcasing"

MIX.Level = 3
MIX.Bench = "general"

MIX.Output = "util_bulletcasing"
MIX.Input = {
	["util_pipe"] = {take = 1}
}

impulse.RegisterMixture(MIX)
