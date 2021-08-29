local MIX = {}

MIX.Class = "ammosmg"

MIX.Level = 5
MIX.Bench = "general"

MIX.Output = "ammo_smg"
MIX.Input = {
	["util_bulletcasing"] = {take = 2},
	["util_gunpowder"] = {take = 1}
}

impulse.RegisterMixture(MIX)
