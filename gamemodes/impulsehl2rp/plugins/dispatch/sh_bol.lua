function meta:IsDispatchBOL()
	local bol = self:GetSyncVar(SYNC_DISPATCH_BOL, nil)

	if self:IsCP() then
		return false
	end

	if bol then
		return true, bol
	end

	return false
end

if CLIENT then
	net.Receive("impulseHL2RPSetBOL", function()
		local ply = net.ReadEntity()
		local crime = net.ReadUInt(8)

		if not IsValid(ply) or not ply:IsPlayer() then
			return
		end

		surface.PlaySound("npc/overwatch/radiovoice/allunitsbolfor243suspect.wav")

		LocalPlayer():SendCombineMessage("ALL UNITS BOL FOR SUSPECT "..ply:Name(), Color(204, 165, 8))
	end)
end
