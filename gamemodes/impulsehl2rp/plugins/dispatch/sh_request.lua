if SERVER then
	util.AddNetworkString("impulseHL2RPRequest")
else
	net.Receive("impulseHL2RPRequest", function()
		local sender = net.ReadUInt(8)
		local message = net.ReadString()
		sender = Entity(sender)

		if sender and IsValid(sender) and sender:IsPlayer() then
			LocalPlayer():SendCombineMessage("NEW REQUEST FROM: "..sender:Name(), Color(0, 0, 255))
			LocalPlayer():SendCombineMessage("MESSAGE: "..message, Color(0, 0, 255))

			impulse.AddCombineWaypoint("Civil Request", sender:GetPos(), 90, 2, 5, nil, nil, sender)

			surface.PlaySound("npc/overwatch/radiovoice/allteamsrespondcode3.wav")
		end
	end)
end

local requestCommand = {
	description = "Sends a request to Civil Protection teams for assistance.",
	requiresArg = true,
	requiesAlive = true,
	onRun = function(ply, arg, rawText)
		if ply:Alive() and (ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_CWU) then
			if (ply.nextRequest or 0) > CurTime() then 
				return ply:Notify("Please wait a while before sending another request.") 
			end

			if ply:GetSyncVar(SYNC_ARRESTED, false) then
				return ply:Notify("You can not send a request when arrested.")
			end

			if ply:IsRebel() then
				return ply:Notify("You can not send a request as a rebel.")
			end

			local recipFilter = RecipientFilter()

			for v,k in pairs(player.GetAll()) do
				if k:Team() == TEAM_CP then
					recipFilter:AddPlayer(k)
				end
			end

			net.Start("impulseHL2RPRequest")
			net.WriteUInt(ply:EntIndex(), 8)
			net.WriteString(rawText)
			net.Send(recipFilter)

			ply:Notify("You have sent a request to Civil Protection teams.")
			ply:EmitBudgetSound("ambient/levels/prison/radio_random2.wav")
			ply.nextRequest = CurTime() + 30
		else
			ply:Notify("You must be a citizen to make a request.")
		end
	end
}

impulse.RegisterChatCommand("/request", requestCommand)
