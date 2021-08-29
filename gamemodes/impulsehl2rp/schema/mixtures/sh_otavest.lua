local MIX = {}

MIX.Class = "cos_otavest"

MIX.Level = 10
MIX.Bench = "general"

MIX.Output = "cos_otavest"
MIX.Input = {
	["util_cloth"] = {take = 8},
	["util_glue"] = {take = 3},
	["util_ceramicplate"] = {take = 1},
	["util_paint"] = {take = 1}
}

impulse.RegisterMixture(MIX)
