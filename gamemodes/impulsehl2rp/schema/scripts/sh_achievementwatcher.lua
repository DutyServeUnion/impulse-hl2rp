if SERVER then
	util.AddNetworkString("impulseAchPUTCWin")

	hook.Add("PlayerDeath", "impulseAchDeath", function(victim, wep, attacker)
		if not victim.beenSetup or not attacker.beenSetup then
			return
		end

		attacker = attacker or (((wep:GetClass() or "") == "env_fire") and wep:GetOwner())-- hacky fix for molotov fire

		if not IsValid(attacker) or not attacker:IsPlayer() then
			return
		end

		if not attacker:Alive() then
			attacker:AchievementGive("ach_fromthegrave")
		end

		local invWeight = victim.InventoryWeight or 0

		if invWeight >= 15 then
			victim:AchievementGive("ach_deadweight")
		end

		if wep and IsValid(wep) and victim:GetPos():DistToSqr(attacker:GetPos()) >= 15500047.7401 then -- 100m in unrooted src units
			attacker:AchievementGive("ach_quickshot")
		end

		if victim:SteamID64() == "76561198152109175" then -- is vin :D
			attacker:AchievementGive("ach_vin")
		end

		if not attacker:IsCP() then
			if victim:Team() == TEAM_CA and attacker:HasInventoryItem("cos_facewrap") then
				attacker:AchievementGive("ach_unknownkiller")
			end

			if attacker:Health() == 1 and victim:Team() == TEAM_OTA and victim:GetTeamClass() then
				attacker:AchievementGive("ach_closeshave")
			end
		end

		if victim:GetXP() <= 30 then
			attacker:AchievementGive("ach_bambikiller")
		end

		if victim:GetMoney() >= 20000 then
			victim:AchievementGive("ach_costlydeath")
		end

		if wep and IsValid(wep) and wep:GetClass() == "ls_pickaxe" and victim:Team() == TEAM_CP and victim:GetTeamClass() then
			attacker.achPickaxeKills = (attacker.achPickaxeKills or 0) + 1

			if attacker.achPickaxeKills >= 3 then
				attacker:AchievementGive("ach_clobberer")
				attacker.achPickaxeKills = 0
			elseif attacker.achPickaxeKills == 1 then
				timer.Simple(240, function()
					if IsValid(attacker) then
						attacker.achPickaxeKills = 0
					end
				end)
			end
		end
	end)

	hook.Add("PlayerAddSkillXP", "impulseAchXP", function(ply)
		ply:AchievementCheck("ach_jackofalltrades")
	end)

	hook.Add("PlayerAddUserToDoor", "impulseAchDoor", function(ply, owners)
		if table.Count(owners) == 9 then
			ply:AchievementGive("ach_ourhouse")
		end
	end)

	local dancers = {}
	hook.Add("PlayerShouldTaunt", "impulseAchTaunt", function(ply, act)
		if act == 1642 then
			local pos = table.insert(dancers, ply)

			timer.Simple(12, function()
				dancers[pos] = nil
			end)

			if table.Count(dancers) > 14 then
				for v,k in pairs(dancers) do
					if IsValid(k) then
						k:AchievementGive("ach_party")
					end
				end

				dancers = {}
			end
		end
	end)

	hook.Add("PlayerCraftItem", "impulseAchCraft", function(ply, class)
		if class == "wep_axe" then
			ply:AchievementGive("ach_axe")
		end
	end)

	hook.Add("PlayerGetXP", "impulseAchXP", function(ply, amount)
		ply:AchievementCheck("ach_addict")
	end)

	net.Receive("impulseAchPUTCWin", function(len, ply)
		if not ply.OWOUSoWarm and ply.beenSetup then
			ply.OWOUSoWarm = true
			ply:AchievementGive("ach_pickupthatcan")
		end
	end)
else
	hook.Add("PickUpThatCanWin", "impulseAchPUTC", function()
		net.Start("impulseAchPUTCWin")
		net.SendToServer()
	end)
end
