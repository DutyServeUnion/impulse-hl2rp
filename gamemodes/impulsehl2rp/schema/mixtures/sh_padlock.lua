local MIX = {}

MIX.Class = "padlock"

MIX.Level = 5
MIX.Bench = "general"

MIX.Output = "item_padlock"
MIX.Input = {
	["util_metalplate"] = {take = 2}
}

impulse.RegisterMixture(MIX)
