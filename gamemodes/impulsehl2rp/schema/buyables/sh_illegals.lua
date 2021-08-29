impulse.Business.Define("Brewing Barrel", {
    entity = "impulse_hl2rp_brewingbarrel",
    model = "models/props_c17/woodbarrel001.mdl",
    description = "A barrel to brew alcohol.",
    price = 95,
    refundAdd = 75,
    refund = true,
    removeOnTeamSwitch = true,
    postSpawn = function(ent, ply)
    	ply.BarrelCount = (ply.BarrelCount or 0) + 1
    end,
    customCheck = function(ply)
        if ply:Team() != TEAM_CITIZEN then
            return false
        end
        
    	local barrelCount = ply.BarrelCount or 0

    	if barrelCount >= impulse.Config.MaxBarrels then
    		ply:Notify("You have reached the max amount of brewing barrels.")
    		return false
    	else
    		return true
    	end
    end
})
