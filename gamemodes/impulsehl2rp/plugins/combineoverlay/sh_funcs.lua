if SERVER then
	util.AddNetworkString("impulseHL2RPCombineMessage")
	util.AddNetworkString("impulseHL2RPCombineWaypoint")

	function meta:SendCombineMessage(text, color)
		net.Start("impulseHL2RPCombineMessage")
		net.WriteString(text)
		if color then
			net.WriteColor(color)
		end
		net.Send(self)
	end

	function meta:SendCombineWaypoint(message, pos, duration, icon, colour, unit)
		net.Start("impulseHL2RPCombineWaypoint")
		net.WriteString(message)
		net.WriteVector(pos)
		net.WriteUInt(duration or 90, 10)
		net.WriteUInt(icon or 1, 8)
		net.WriteUInt(colour or 1, 8)
		if unit then
			net.WriteUInt(unit:EntIndex(), 8)
		else
			net.WriteUInt(0, 8)
		end
		net.Send(self)
	end
else
	function meta:SendCombineMessage(text, color)
		impulse.AddCombineMessage(text, color)
	end

	function meta:SendCombineWaypoint(message, duration, icon, colour, unit, sender)
		impulse.AddCombineWaypoint(message, duration, icon, colour, unit, sender)
	end
end
