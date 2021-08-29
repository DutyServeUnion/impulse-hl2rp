if string.find(game.GetMap(), "rp_apex_industrial") == nil then return end

local elevatorCommand = {
	description = "Calls the Plaza elevator. (Combine only)",
	requiesAlive = true,
	onRun = function(ply, arg, rawText)
		if not ply:IsCP() then
			return	
		end

		if (ply:GetPos() - Vector(1858.6030273438, 3585.53125, 125.53125)):LengthSqr() <= (800 ^ 2) then
			for v,k in pairs(ents.FindByName("nexus_tunnel_elevator1")) do
				k:Fire("Open")
			end

			ply:Notify("You have called the Plaza elevator.")
		else
			ply:Notify("You are not near the Plaza elevator.")
		end

	end
}

impulse.RegisterChatCommand("/plazaelevator", elevatorCommand)
