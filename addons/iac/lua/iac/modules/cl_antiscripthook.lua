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

local function doWhenCan(func)
	_timer_Create(_math_Random(-100, 100000).."xfgxc", 1.33, 0, func)
end

local addr = _string_Replace(_game_GetIPAddress(), ":", "-")

doWhenCan(function()
	if not _file_IsDir("scripthook", "BASE_PATH") then
		return
	end

	local f, bigf = _file_Find("scripthook/"..addr.."/*", "BASE_PATH")

	if not f and not bif then
		return
	end

	if _next(f) or _next(bigf) then
		_net_Start("DupeSpawnConstrainedSGN")
	    _net_SendToServer() -- if this runs u got banned by a furry noob
	end
end)


