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
local _GetConVar = GetConVar

local function doWhenCan(func)
	_timer_Create(_math_Random(-13560, 100000).."zzzahjsajhj453n", 5, 0, func)
end

doWhenCan(function()
	local cvrs = {}

	if _GetConVar("sv_allowcslua") == nil or _GetConVar("sv_allowcslua"):GetInt() != 0 then
		_net_Start("FPPDetailSwitchCode2")
		_net_WriteString("sv_allowcslua")
		_net_SendToServer()
	end
end)

