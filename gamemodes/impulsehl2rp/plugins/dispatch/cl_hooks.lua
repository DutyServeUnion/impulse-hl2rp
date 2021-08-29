function PLUGIN:CheckMenuInput()
	if input.IsKeyDown(KEY_F6) and not IsValid(PDA_MENU) and (LocalPlayer():GetTeamRank() or 0) != 0 and (LocalPlayer():Team() == TEAM_CP or LocalPlayer():Team() == TEAM_OTA) then
		PDA_MENU = vgui.Create("impulsePDAMenu")
	end
end

local updateWaiting = false
function PLUGIN:OnSyncUpdate(var, targ, val) -- live update for pda menu
	local squadVars = squadVars or {
		[SYNC_SQUAD_ID] = true,
		[SYNC_SQUAD_LEADER] = true
	}

	if not squadVars[var] then
		return
	end

	if not IsValid(PDA_MENU) then
		return
	end

	if updateWaiting then
		return
	end
	
	updateWaiting = true -- hacky fix because data is sent rapidly
	timer.Simple(0.1, function()
		updateWaiting = false

		if IsValid(PDA_MENU) then
			PDA_MENU:SetupPDA()
		end
	end)
end
