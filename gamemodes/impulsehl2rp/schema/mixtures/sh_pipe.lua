local MIX = {}

MIX.Class = "pipe"

MIX.Level = 2
MIX.Bench = "general"

MIX.Output = "util_pipe"
MIX.Input = {
	["util_metalplate"] = {take = 2}
}

impulse.RegisterMixture(MIX)
