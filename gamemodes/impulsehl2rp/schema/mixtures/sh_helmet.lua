local MIX = {}

MIX.Class = "cos_parahelmet"

MIX.Level = 9
MIX.Bench = "general"

MIX.Output = "cos_parahelmet"
MIX.Input = {
	["util_cloth"] = {take = 4},
	["util_glue"] = {take = 3},
	["util_refinedmetalplate"] = {take = 6}
}

impulse.RegisterMixture(MIX)
