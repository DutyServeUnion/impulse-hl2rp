local MIX = {}

MIX.Class = "facewrap"

MIX.Level = 4
MIX.Bench = "general"

MIX.Output = "cos_facewrap"
MIX.Input = {
	["util_cloth"] = {take = 3}
}

impulse.RegisterMixture(MIX)
