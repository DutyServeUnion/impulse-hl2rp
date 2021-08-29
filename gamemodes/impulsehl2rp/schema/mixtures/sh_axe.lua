local MIX = {}

MIX.Class = "axe"

MIX.Level = 1
MIX.Bench = "general"

MIX.Output = "wep_axe"
MIX.Input = {
	["util_metalplate"] = {take = 1},
	["util_wood"] = {take = 2}
}

impulse.RegisterMixture(MIX)
