local MIX = {}

MIX.Class = "combatgasmask"

MIX.Level = 8
MIX.Bench = "general"

MIX.Output = "cos_combatgasmask"
MIX.Input = {
	["util_cloth"] = {take = 3},
	["util_glue"] = {take = 1},
	["util_plastic"] = {take = 4}
}

impulse.RegisterMixture(MIX)
