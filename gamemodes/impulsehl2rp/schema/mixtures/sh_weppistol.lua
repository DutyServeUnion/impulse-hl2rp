local MIX = {}

MIX.Class = "weppistol"

MIX.Level = 2
MIX.Bench = "weapon"

MIX.Output = "wep_pistol"
MIX.Input = {
	["util_pipe"] = {take = 1},
	["util_glue"] = {take = 2},
	["util_gear"] = {take = 1},
	["util_plastic"] = {take = 2},
	["util_metalplate"] = {take = 2}
}

impulse.RegisterMixture(MIX)
