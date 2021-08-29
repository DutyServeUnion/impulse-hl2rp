if SERVER then
	util.AddNetworkString("impulseHL2RPJoinRank")

	hook.Add("PlayerSetCombineRank", "impulseHL2RPJoinRankNotify", function(ply)
		local recipFilter = RecipientFilter()

		for v,k in pairs(player.GetAll()) do
			if k:IsCP() then
				recipFilter:AddPlayer(k)
			end
		end

		net.Start("impulseHL2RPJoinRank")
		net.WriteUInt(ply:EntIndex(), 8)
		net.Send(recipFilter)
	end)
else
	net.Receive("impulseHL2RPJoinRank", function()
		local ply = net.ReadUInt(8)
		ply = Entity(ply)

		if ply and IsValid(ply) and ply:IsPlayer() then
			LocalPlayer():SendCombineMessage(ply:Name().." IS 10-8")
		end
	end)
end

local dispatchNumbers = {
	[0] = "npc/overwatch/radiovoice/zero.wav",
	[1] = "npc/overwatch/radiovoice/one.wav",
	[2] = "npc/overwatch/radiovoice/two.wav",
	[3] = "npc/overwatch/radiovoice/three.wav",
	[4] = "npc/overwatch/radiovoice/four.wav",
	[5] = "npc/overwatch/radiovoice/five.wav",
	[6] = "npc/overwatch/radiovoice/six.wav",
	[7] = "npc/overwatch/radiovoice/seven.wav",
	[8] = "npc/overwatch/radiovoice/eight.wav",
	[9] = "npc/overwatch/radiovoice/nine.wav"
}

function impulse.DispatchNumbersToVoice(number)
	number = tostring(number)
	local sounds = {}

	for v,k in pairs(string.ToTable(number)) do
		k = tonumber(k)
		if dispatchNumbers[k] then
			table.insert(sounds, dispatchNumbers[k])
		end
	end

	return sounds
end

function impulse.DispatchVoiceRead(lines, wait)
	local wait = wait or .6
	local queue = 0

	for v,k in pairs(lines) do
		timer.Simple(queue, function()
			surface.PlaySound(k)
		end)
		queue = queue + wait
	end

	return queue - wait
end
