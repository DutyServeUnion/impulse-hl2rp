plogs.Register('Terminal', false)

plogs.AddHook("OnDispatchAnnounce", function(ply, announcement)
	plogs.PlayerLog(ply, 'Terminal', ply:NameID().." activated announcement "..announcement, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("OnCityCodeChanged", function(ply, code)
	plogs.PlayerLog(ply, 'Terminal', ply:NameID().." changed the city code to "..code, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("OnCPDemoted", function(ply, targ)
	plogs.PlayerLog(ply, 'Terminal', ply:NameID().." demoted "..targ:NameID(), {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		['Target SteamID'] = targ:SteamID()
	})
end)
