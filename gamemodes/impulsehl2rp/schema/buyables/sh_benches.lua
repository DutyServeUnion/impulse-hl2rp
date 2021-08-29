impulse.Business.Define("Cooking Stove", {
	bench = "stove",
	model = "models/props_c17/furnitureStove001a.mdl",
    refund = true,
	price = 50,
    removeOnTeamSwitch = true,
    teams = {TEAM_CWU},
    classes = {CLASS_COMMERCE}
})

impulse.Business.Define("General Workbench", {
	bench = "general",
	model = "models/mosi/fallout4/furniture/workstations/workshopbench.mdl",
    refund = true,
	price = 70,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
    	if ply:Team() == TEAM_CWU and ply:GetTeamClass() == CLASS_COMMERCE then
    		return true
    	end

    	return not ply:IsCP()
    end
})

impulse.Business.Define("Weaponry Workbench", {
	bench = "weapon",
	model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl",
    refund = true,
	price = 150,
    removeOnTeamSwitch = true,
    customCheck = function(ply)
    	return ply:Team() == TEAM_CITIZEN
    end
})

