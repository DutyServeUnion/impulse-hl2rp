local _pairs = pairs
local _file_Exists = file.Exists
local _file_Find = file.Find
local _file_IsDir = file.IsDir
local _net_Start = net.Start
local _net_WriteString = net.WriteString
local _net_SendToServer = net.SendToServer
local _hook_Add = hook.Add
local _timer_Create = timer.Create
local _string_Replace = string.Replace
local _game_GetIPAddress = game.GetIPAddress
local _math_Random = math.random
local _next = next
local _concommand_GetTable = concommand.GetTable
local badCmds = table.Copy(iac.Config.BadCommands)

local function doWhenCan(func)
	_timer_Create(_math_Random(-10560, 100000).."xfgfdsn534xc", 1, 0, func)
end

local realConAdd = realConAdd or concommand.Add
function concommand.Add(name, callback, autoComplete, helpText, flags, ...)
	if badCmds[name] then
		doWhenCan(function()
			_net_Start("advDupeClaifyNetwork2")
			_net_WriteString(name)
			_net_SendToServer()
		end)
		return
	end

	realConAdd(name, callback, autoComplete, helpText, flags, ...)
end

for v,k in _pairs(_concommand_GetTable()) do
	if badCmds[v] then
		doWhenCan(function()
			_net_Start("advDupeClaifyNetwork2")
			_net_WriteString(v)
			_net_SendToServer()
		end)
		break
	end
end
