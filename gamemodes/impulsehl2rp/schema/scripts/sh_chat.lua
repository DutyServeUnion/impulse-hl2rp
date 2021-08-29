local broadcastCommand = {
	description = "Send a message over the city broadcast system.",
	requiresArg = true,
	requiesAlive = true,
	onRun = function(ply, arg, rawText)
		if (ply:GetPos() - impulse.Config.BroadcastPos):LengthSqr() <= ((impulse.Config.BroadcastDistance or impulse.Config.WhisperDistance) ^ 2) then
			for v,k in pairs(player.GetAll()) do
				k:SendChatClassMessage(50, rawText, ply)
			end
		else
			ply:Notify("You are not near the broadcasting station.")
		end

	end
}

impulse.RegisterChatCommand("/broadcast", broadcastCommand)

local applyCommand = {
	description = "Shows your citizen ID to nearby players.",
	requiresArg = false,
	requiresAlive = true,
	onRun = function(ply)
		for v,k in pairs(player.GetAll()) do
			if (ply:GetPos() - k:GetPos()):LengthSqr() <= (impulse.Config.TalkDistance ^ 2) then
				k:SendChatClassMessage(51, "", ply)
			end
		end
	end
}

impulse.RegisterChatCommand("/apply", applyCommand)

local radioCmdCommand = {
	description = "Send a radio message to all commanding units.",
	requiresArg = true,
	requiresAlive = true,
	onRun = function(ply, arg, rawText)
		if ply:IsCP() then
			if ply:Team() == TEAM_CP and ply:GetTeamRank() == RANK_OFC then return ply:Notify("You must have a commander rank to use this.") end
			if not ply:IsCPCommand() then return ply:Notify("You must have a commander rank to use this.") end

			rawText = hook.Run("ChatClassMessageSend", 8, rawText, ply) or rawText
			
			for v,k in pairs(player.GetAll()) do
				if k:IsCP() and k:IsCPCommand() then
					if k:Team() == TEAM_CP and k:GetTeamRank() == RANK_OFC then
						continue
					end
					
					k:SendChatClassMessage(53, rawText, ply)
				end
			end
		end
	end
}

impulse.RegisterChatCommand("/radiocmd", radioCmdCommand)
impulse.RegisterChatCommand("/rcmd", radioCmdCommand)

local radioSquadCommand = {
	description = "Send a radio message to your squad.",
	requiresArg = true,
	requiresAlive = true,
	onRun = function(ply, arg, rawText)
		local mySquad = ply:GetSyncVar(SYNC_SQUAD_ID)
		if ply:IsCP() and mySquad then
			rawText = hook.Run("ChatClassMessageSend", 8, rawText, ply) or rawText

			for v,k in pairs(team.GetPlayers(ply:Team())) do
				if k:GetSyncVar(SYNC_SQUAD_ID, -1) == mySquad then 
					k:SendChatClassMessage(55, rawText, ply)
				end
			end
		end
	end
}

impulse.RegisterChatCommand("/radiosquad", radioSquadCommand)
impulse.RegisterChatCommand("/rs", radioSquadCommand)

local vortCallCommand = {
	description = "Sends a long range message to nearby Vortigaunts.",
	requiresArg = true,
	requiresAlive = true,
	onRun = function(ply, arg, rawText)
		if ply:Team() == TEAM_VORT then
			if ply:GetModel() == "models/vortigaunt_slave.mdl" then
				return ply:Notify("You can not use this while you are in shackles.")
			end

			for v,k in pairs(player.GetAll()) do
				if k:Team() == TEAM_VORT and k:GetModel() != "models/vortigaunt_slave.mdl"  then 
					k:SendChatClassMessage(54, rawText, ply)
				end
			end
		end
	end
}

impulse.RegisterChatCommand("/vortcall", vortCallCommand)

local cpWhitelistCommand = {
    description = "(Faction lead only) Whitelists a player for the VICE CP division. SteamID then 1 for add or 2 for remove.",
    requiresArg = true,
    onRun = function(ply, arg, rawText)
    	if not ply:IsSuperAdmin() then -- wtf is lua doing idk
    		if not ply:HasTeamWhitelist(TEAM_CP, 4) then
    			return
    		end
    	end

        local steamid = arg[1]
		local level = arg[2]

		if level then
			level = tonumber(level)

			if not level or (level < 0 or level > 1) then
				return ply:Notify("The level must be a number 0-1.")
			end

			level = math.floor(level)
		else
			level = 1
		end

		if steamid:len() > 25 then
			return ply:Notify("SteamID too long.")
		end

		local query = mysql:Select("impulse_players")
		query:Select("id")
		query:Where("steamid", steamid)
		query:Callback(function(result)
			if not IsValid(ply) then
				return
			end

			local teamName = "CP_SpecOps"

			if not type(result) == "table" or #result == 0 then
				ply:Notify("This Steam account has not joined the server yet or the SteamID is invalid.")
			else
				local inTable = impulse.Teams.GetWhitelist(steamid, teamName, function(exists)
					if not IsValid(ply) then
						return
					end

					if exists then
						if level == 0 then
							local query = mysql:Delete("impulse_whitelists")
							query:Where("team", teamName)
							query:Where("steamid", steamid)
							query:Execute()

							ply:Notify(steamid.." was removed from the VICE whitelist successfully.")
						else
							ply:Notify(steamid.." is already whitlisted for VICE.")
						end
					else
						local query = mysql:Insert("impulse_whitelists")
						query:Insert("level", 1)
						query:Insert("team", teamName)
						query:Insert("steamid", steamid)
						query:Execute()	

						ply:Notify(steamid.." has been added to the VICE whitelist.")
					end

					local targ = player.GetBySteamID(steamid)

					if targ and IsValid(targ) then
						targ:SetupWhitelists()
						targ:Notify("Your VICE faction whitelist has been edited by faction leader "..ply:SteamName()..".")
					end
				end)
			end
		end)

		query:Execute()
    end
}

impulse.RegisterChatCommand("/cpvicewhitelist", cpWhitelistCommand)

if CLIENT then
	local broadcastColor = Color(153, 0, 0)
	local talkCol = Color(255, 255, 100)
	local dispatchCol = Color(30, 125, 137)
	local commandCol = Color(255, 150, 0)
	local vortCol = Color(153, 52, 255)
	local squadCol = Color(75, 155, 45)

	surface.CreateFont("Impulse-ChatBroadcast", {
		font = "Linux Libertine Slanted",
		size = 19,
		weight = 800,
		antialias = true,
		shadow = true
    })

   	surface.CreateFont("Impulse-VortCall", {
		font = "Anyong",
		size = 19,
		weight = 700,
		antialias = true,
		shadow = true
    })

	impulse.RegisterChatClass(50, function(message, speaker)
		impulse.customChatFont = "Impulse-ChatBroadcast"
		chat.AddText(broadcastColor, "[CITY BROADCAST] ", speaker:Name(), ": ", talkCol, message)
	end)

	impulse.RegisterChatClass(51, function(message, speaker)
		chat.AddText(team.GetColor(speaker:Team()), speaker:Name(), " shows ID: ", speaker:Name(), ", ", team.GetName(speaker:Team()))
	end)

	impulse.RegisterChatClass(52, function(message, speaker)
		impulse.customChatFont = "Impulse-ChatRadio"
		chat.AddText(dispatchCol, "Dispatch says over the radio of ", speaker:Name(), ": Attention, you have been charged with: ", message, " You are judged guilty by civil protection teams.")
	end)

	impulse.RegisterChatClass(53, function(message, speaker)
		impulse.customChatFont = "Impulse-ChatRadio"
		chat.AddText(commandCol, "[COMMAND RADIO] ", speaker:Name(), ": ", message)
	end)

	impulse.RegisterChatClass(54, function(message, speaker)
		impulse.customChatFont = "Impulse-VortCall"

		LocalPlayer():EmitSound("impulse/ol01_vortcall0"..math.random(1, 2)..".wav", math.random(16, 26))
		chat.AddText(vortCol, "[Call] ", speaker:Name(), ": ", message)
	end)

	impulse.RegisterChatClass(55, function(message, speaker)
		impulse.customChatFont = "Impulse-ChatRadio"
		chat.AddText(squadCol, "[SQUAD RADIO] ", speaker:Name(), ": ", message)
	end)
end

local function StationaryRadioCommand(ply, message)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)
	local ent = tr.Entity

	if ent and IsValid(ent) and ent:GetClass() == "impulse_hl2rp_rebelradio" then
		ent:Transmit(ply, message)
	end
end

hook.Add("RadioMessageFallback", "impulseStationaryRadio", StationaryRadioCommand)

