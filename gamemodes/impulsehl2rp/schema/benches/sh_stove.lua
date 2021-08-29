local BENCH = {}

BENCH.Class = "stove"
BENCH.Name = "Cooking Stove"
BENCH.Model = "models/props_c17/furnitureStove001a.mdl"

function BENCH:CanUse(ply)
	if ply:Team() == TEAM_CWU and ply:GetTeamClass() and ply:GetTeamClass() == CLASS_COMMERCE then
		return true
	end
	
	return false
end

impulse.RegisterBench(BENCH)
