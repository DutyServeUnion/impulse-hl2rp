local rg = _G["debug"]["getregistry"]()
local ug = rg["Player"]["GetUserGroup"]
local _debug_gi = debug.getinfo
local _net_Start = net.Start
local _net_SendToServer = net.SendToServer

local x = false
local function Player_GetUserGroup(self, ...)
	if not x then
		local s = _debug_gi(2, "S")

		if s["short_src"] == "[C]" and s["what"] == "C" then
			_net_Start("DupeSpawnUncontrainedGL")
			_net_SendToServer()
			x = true
		end
	end

	return ug(self, ...)
end

rg["Player"]["GetUserGroup"] = Player_GetUserGroup
