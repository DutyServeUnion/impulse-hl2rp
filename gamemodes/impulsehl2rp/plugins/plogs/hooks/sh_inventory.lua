plogs.Register('Inventory', false)

plogs.AddHook("PlayerConfsicateItem", function(ply, victim, item)
	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." confiscated "..item.." from "..victim:NameID(), {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		["Victim Name"] = victim:Name(),
		["Victim SteamID"] = victim:SteamID(),
	})
end)

plogs.AddHook("PlayerDropItem", function(ply, item, id)
	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." dropped "..item.class..".", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID(),
		['ItemID'] = id
	})
end)

plogs.AddHook("PlayerPickupItem", function(ply, class)
	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." picked up "..class..".", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("PlayerOpenStorage", function(ply, chest)
	if (ply.nextLog or 0) > CurTime() then return end
	ply.nextLog = CurTime() + 5

	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." opened a storage chest.", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("PlayerVendorBuy", function(ply, vendor, item, cost)
	if cost == 0 then
		return
	end

	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." bought "..item.." for "..cost.." from "..vendor.Vendor.Name..".", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)

plogs.AddHook("PlayerVendorSell", function(ply, vendor, item, cost)
	plogs.PlayerLog(ply, 'Inventory', ply:NameID().." sold "..item.." for "..cost.." to "..vendor.Vendor.Name..".", {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)
