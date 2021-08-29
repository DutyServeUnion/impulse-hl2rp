plogs.Register('Kills', true, Color(255,0,0))

plogs.AddHook('PlayerDeath', function(pl, _, attacker)
	local copy = {
		['Name'] = pl:Name(),
		['SteamID']	= pl:SteamID(),
	}
	local weapon = ''
	if IsValid(attacker) then
		if attacker:IsPlayer() then
			copy['Attacker Name'] = attacker:Name()
			copy['Attacker SteamID'] = attacker:SteamID()

			if (pl.LastSnapshotID or -1) == (attacker.LastSnapshotID or -2) then
				copy['Snapshot ID'] = pl.LastSnapshotID	
			end

			weapon = ' with ' .. (IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon():GetClass() or 'unknown')
			attacker = attacker:NameID()
		else
			if attacker.CPPIGetOwner and IsValid(attacker:CPPIGetOwner()) then
				weapon = ' with ' .. attacker:GetClass()
				attacker = attacker:CPPIGetOwner():NameID()
			else
				attacker = attacker:GetClass()
			end
		end
	else
		attacker = tostring(attacker)
	end
	local msg = attacker .. ' killed ' .. pl:NameID() .. weapon

	plogs.PlayerLog(pl, 'Kills', msg, copy)
	plogsSlackLog("death", msg)
end)


plogs.Register('Damage', false)

plogs.AddHook('EntityTakeDamage', function(ent, dmginfo)
	if ent:IsPlayer() then
		local copy = {
	    	['Name'] = ent:Name(),
			['SteamID']	= ent:SteamID(),
	    }
	    local weapon = ''
	    local attacker = dmginfo:GetAttacker()
		if IsValid(attacker) then
			if attacker == Entity(0) then
				return
			end

			if attacker == ent then
				return
			end
			
			if attacker:IsPlayer() then
				copy['Attacker Name'] = attacker:Name()
				copy['Attacker SteamID'] = attacker:SteamID()
				weapon = ' with ' .. (IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon():GetClass() or 'unknown')
				attacker = attacker:NameID()
			else
				if attacker.CPPIGetOwner and IsValid(attacker:CPPIGetOwner()) then
					weapon = ' with ' .. attacker:GetClass()
					attacker = attacker:CPPIGetOwner():NameID()
				else
					attacker = attacker:GetClass()
				end
			end
		else
			attacker = tostring(attacker)
		end
		plogs.PlayerLog(ent, 'Damage', attacker .. ' did ' .. math.Round(dmginfo:GetDamage(), 0) .. ' damage to ' .. ent:NameID() .. weapon, copy)
	end
end)
