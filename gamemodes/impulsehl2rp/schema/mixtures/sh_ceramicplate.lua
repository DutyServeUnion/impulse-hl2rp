local MIX = {}

MIX.Class = "ceramicplate"

MIX.Level = 9
MIX.Bench = "general"

MIX.Output = "util_ceramicplate"
MIX.Input = {
	["util_glue"] = {take = 3},
	["util_refinedmetalplate"] = {take = 7}
}

impulse.RegisterMixture(MIX)
