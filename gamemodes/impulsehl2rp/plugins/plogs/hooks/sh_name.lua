plogs.Register('Names', false)

plogs.AddHook("PlayerChangeRPName", function(ply, name)
	plogs.PlayerLog(ply, 'Names', ply:NameID().." has changed RP name to "..name, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)
