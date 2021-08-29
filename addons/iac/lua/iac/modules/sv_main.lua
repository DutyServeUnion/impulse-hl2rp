net.Receive("FPPDetailSwitchCode2", function(len, pl)
    if (IsValid(pl) and pl:IsPlayer()) then
        local length = net.ReadUInt(8)
		Player:Ban(length, true)
	else
		print("[IMPULSE][DEBUG] Player was not valid, unsuccessful ban."])
	end
end)

net.Receive("DupeSpawnConstrainedSGN", function(len, pl)
    if (IsValid(pl) and pl:IsPlayer()) then
		Player:Ban(0, true)
	else
		print("[IMPULSE][DEBUG] Player was not valid, unsuccessful ban."])
	end
end)