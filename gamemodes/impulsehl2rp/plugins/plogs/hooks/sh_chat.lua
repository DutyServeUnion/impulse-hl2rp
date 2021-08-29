plogs.Register('Chat', false)

local hook_name = 'iPostPlayerSay'
plogs.AddHook(hook_name, function(pl, text)
	if (text ~= '') then
		local msg = pl:NameID() .. ' said ' .. string.Trim(text)

		plogs.PlayerLog(pl, 'Chat', msg, {
			['Name'] 	= pl:Name(),
			['SteamID']	= pl:SteamID()
		})
		plogsSlackLog("chat", msg)
	end
end)
