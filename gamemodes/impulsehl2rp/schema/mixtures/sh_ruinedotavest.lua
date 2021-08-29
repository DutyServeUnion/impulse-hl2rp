local MIX = {}

MIX.Class = "ruinedotavest"

MIX.Level = 6
MIX.Bench = "general"

MIX.Output = "util_ceramicplate"
MIX.Input = {
	["util_ruinedotavest"] = {take = 1}
}

impulse.RegisterMixture(MIX)
