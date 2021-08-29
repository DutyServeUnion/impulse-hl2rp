local MIX = {}

MIX.Class = "ied"

MIX.Level = 10
MIX.Bench = "weapon"

MIX.Output = "item_ied"
MIX.Input = {
	["util_plastic"] = {take = 16},
	["util_glue"] = {take = 6},
	["util_electronics"] = {take = 6},
	["util_gunpowder"] = {take = 45}
}

impulse.RegisterMixture(MIX)
