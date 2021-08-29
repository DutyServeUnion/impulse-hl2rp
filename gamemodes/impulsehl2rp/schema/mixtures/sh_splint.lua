local MIX = {}

MIX.Class = "splint"

MIX.Level = 2
MIX.Bench = "general"

MIX.Output = "item_splint"
MIX.Input = {
	["util_wood"] = {take = 3},
	["util_cloth"] = {take = 1}
}

impulse.RegisterMixture(MIX)
