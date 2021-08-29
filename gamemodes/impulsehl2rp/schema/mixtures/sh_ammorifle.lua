local MIX = {}

MIX.Class = "ammorifle"

MIX.Level = 7
MIX.Bench = "general"

MIX.Output = "ammo_rifle"
MIX.Input = {
	["util_bulletcasing"] = {take = 3},
	["util_gunpowder"] = {take = 2}
}

impulse.RegisterMixture(MIX)
