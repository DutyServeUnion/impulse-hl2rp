local MIX = {}

MIX.Class = "ammopistol"

MIX.Level = 2
MIX.Bench = "general"

MIX.Output = "ammo_pistol"
MIX.Input = {
	["util_bulletcasing"] = {take = 2},
	["util_gunpowder"] = {take = 1}
}

impulse.RegisterMixture(MIX)
