local MIX = {}

MIX.Class = "gear"

MIX.Level = 4
MIX.Bench = "general"

MIX.Output = "util_gear"
MIX.Input = {
	["util_metalplate"] = {take = 4},
	["util_glue"] = {take = 1}
}

impulse.RegisterMixture(MIX)
