plogs.Register('Rebel', false)

plogs.AddHook("HL2RPRebelState", function(ply, state)
	state = tostring(state)
	plogs.PlayerLog(ply, 'Rebel', ply:NameID().." changed rebel state to "..state, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)
