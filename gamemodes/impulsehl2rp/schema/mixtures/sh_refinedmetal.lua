local MIX = {}

MIX.Class = "refinedmetal"

MIX.Level = 6
MIX.Bench = "general"

MIX.Output = "util_refinedmetalplate"
MIX.Input = {
	["util_metalplate"] = {take = 2},
	["util_glue"] = {take = 1}
}

impulse.RegisterMixture(MIX)
