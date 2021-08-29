if SERVER then
	util.AddNetworkString("impulseHL2RPBioDeath")

	hook.Add("PlayerDeath", "impulseHL2RPBiosignal", function(victim)
		if victim:IsCP() and victim.impulseZone then
			local recipFilter = RecipientFilter()

			for v,k in pairs(player.GetAll()) do
				if k:IsCP() then
					recipFilter:AddPlayer(k)
				end
			end

			net.Start("impulseHL2RPBioDeath")
			net.WriteUInt(victim:EntIndex(), 8)
			net.WriteUInt(victim.impulseZone, 8)
			net.Send(recipFilter)
		end
	end)
else
	net.Receive("impulseHL2RPBioDeath", function(len, ply)
		local unit = net.ReadUInt(8)
		local zone = net.ReadUInt(8)
		zone = impulse.Config.Zones[zone]
		unit = Entity(unit)

		if zone and unit and IsValid(unit) and unit:IsPlayer() and unit:IsCP() then
			LocalPlayer():SendCombineMessage("LOST BIOSIGNAL FOR UNIT: "..unit:Name().." | LOCATION: "..string.upper(zone.name), Color(255, 0, 0))
			impulse.AddCombineWaypoint("BIOSIGNAL LOSS", unit:GetPos(), 120, 3, 4, 4, unit)

			local digits = unit:GetDigits()
			local readTime = 0
			
			surface.PlaySound("npc/overwatch/radiovoice/lostbiosignalforunit.wav")
			
			timer.Simple(2, function()
				if digits then
					local nameSounds = impulse.DispatchNumbersToVoice(digits)

					readTime = impulse.DispatchVoiceRead(nameSounds) + 1
				end

				timer.Simple(readTime, function()
					surface.PlaySound("npc/overwatch/radiovoice/unitdownat.wav")
				end)

				timer.Simple(readTime + 1, function()
	    			surface.PlaySound("npc/overwatch/radiovoice/404zone.wav")
				end)

				timer.Simple(readTime + 2.3, function()
	    			surface.PlaySound("npc/overwatch/radiovoice/allteamsrespondcode3.wav")
				end)
			end)
		end
	end)
end
