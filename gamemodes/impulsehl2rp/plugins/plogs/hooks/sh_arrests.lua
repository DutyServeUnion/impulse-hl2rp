plogs.Register('Arrests', false)

plogs.AddHook("PlayerArrested", function(ply, detainer)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." was detained by "..detainer:NameID(), {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Detainer Name"] = detainer:Name(),
		["Detainer SteamID"] = detainer:SteamID()
	})
end)

plogs.AddHook("PlayerUnArrested", function(ply, detainer)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." was un-detained by "..detainer:NameID(), {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Detainer Name"] = detainer:Name(),
		["Detainer SteamID"] = detainer:SteamID()
	})
end)

plogs.AddHook("PlayerJailed", function(ply, detainer, time, charges)
	local charges = table.ToString(charges)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." was jailed by "..detainer:NameID().." for "..time.." seconds. Charges: "..charges, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Detainer Name"] = detainer:Name(),
		["Detainer SteamID"] = detainer:SteamID(),
		["Charges"] = charges
	})
end)

plogs.AddHook("PlayerJailSentenceEdit", function(ply, jailed, old, new)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." edited the jail sentece of "..jailed:NameID().." from "..old.." seconds to "..new.." seconds.", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Jailed Name"] = jailed:Name(),
		["Jailed SteamID"] = jailed:SteamID()
	})
end)

plogs.AddHook("PlayerUnJailed", function(ply)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." was unjailed.", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("DoInventorySearch", function(ply, searchee)
	plogs.PlayerLog(ply, 'Arrests', ply:NameID().." started searching "..searchee:NameID(), {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Searchee Name"] = searchee:Name(),
		["Searchee SteamID"] = searchee:SteamID()
	})
end)
