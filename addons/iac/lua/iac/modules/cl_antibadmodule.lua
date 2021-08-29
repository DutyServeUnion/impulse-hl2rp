local blacklistedModules = table.Copy(iac.Config.BadModules)
local _pairs = pairs
local _file_Exists = file.Exists
local _net_Start = net.Start
local _net_WriteString = net.WriteString
local _net_SendToServer = net.SendToServer
local _hook_Add = hook.Add
local _timer_Create = timer.Create
local _math_Random = math.random
local _string_Replace = string.Replace

local function doWhenCan(func)
	_timer_Create(_math_Random(-100, 100000).."xfgxc", 1, 0, function()
		func()
	end)
end


for v,k in _pairs(blacklistedModules) do
	if _file_Exists("lua/bin/"..k, "GAME") or _file_Exists("lua/bin/".._string_Replace(k, "32", "64"), "GAME") then
		doWhenCan(function()
			_net_Start("advDupeClaifyNetwork")
			_net_WriteString(k)
			_net_SendToServer()
		end)

   		break
	end
end

