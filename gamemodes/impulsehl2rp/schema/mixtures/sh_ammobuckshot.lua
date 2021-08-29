local MIX = {}

MIX.Class = "ammobuckshot"

MIX.Level = 6
MIX.Bench = "general"

MIX.Output = "ammo_buckshot"
MIX.Input = {
	["util_bulletcasing"] = {take = 2},
	["util_gunpowder"] = {take = 4}
}

impulse.RegisterMixture(MIX)
