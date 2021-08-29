plogs.Register('Buyables', false)

plogs.AddHook("PlayerBuyablePurchase", function(ply, buyable)
	plogs.PlayerLog(ply, 'Buyables', ply:NameID() .. ' purchased ' .. buyable, {
		['Name'] 	= ply:Name(),
		['SteamID']	= ply:SteamID()
	})
end)
