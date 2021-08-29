local MIX = {}

MIX.Class = "emp"

MIX.Level = 9
MIX.Bench = "general"

MIX.Output = "item_emp"
MIX.Input = {
	["util_refinedmetalplate"] = {take = 2},
	["util_glue"] = {take = 1},
	["util_plastic"] = {take = 1},
	["util_electronics"] = {take = 5},
	["util_pipe"] = {take = 1}
}

impulse.RegisterMixture(MIX)
