local MIX = {}

MIX.Class = "lockpick"

MIX.Level = 6
MIX.Bench = "general"

MIX.Output = "item_lockpick"
MIX.Input = {
	["util_pipe"] = {take = 2},
	["util_glue"] = {take = 1}
}

impulse.RegisterMixture(MIX)
