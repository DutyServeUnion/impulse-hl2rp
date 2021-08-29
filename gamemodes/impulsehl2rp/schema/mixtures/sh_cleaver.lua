local MIX = {}

MIX.Class = "cleaver"

MIX.Level = 5
MIX.Bench = "general"

MIX.Output = "item_cleaver"
MIX.Input = {
	["util_metalplate"] = {take = 5},
	["util_wood"] = {take = 2}
}

impulse.RegisterMixture(MIX)
