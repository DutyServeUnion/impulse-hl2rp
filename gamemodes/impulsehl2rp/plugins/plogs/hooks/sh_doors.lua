plogs.Register('Doors', false)

plogs.AddHook("PlayerPurchaseDoor", function(ply, door)
	plogs.PlayerLog(ply, 'Doors', ply:NameID().." purchased a door.", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		['Door'] = door:EntIndex()
	})
end)

plogs.AddHook("PlayerSellDoor", function(ply, door)
	plogs.PlayerLog(ply, 'Doors', ply:NameID().." sold a door.", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		['Door'] = door:EntIndex()
	})
end)
