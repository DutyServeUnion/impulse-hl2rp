local _AddCSLuaFile = AddCSLuaFile
local _file_Exists = file.Exists
local _file_Find = file.Find
local _hook_Add = hook.Add
local _hook_Run = hook.Run
local _include = include
local _print = print
local _ipairs = ipairs
local owo = MsgC

if SERVER then
	owo(Color(76, 209, 55), "[iac] Starting load...\n")
end

iac = iac or {}
iac.garb = collectgarbage("count")
iac.Config = iac.Config or {}
iac.Punishers = iac.Punishers or {}
iac.Modules = iac.Modules or {}
iac.Data = iac.Data or {}
iac.GBans = iac.GBans or {}
iac.Logs = iac.Logs or {}

local bootstrapper = {}

function bootstrapper.LoadFile(fileName)
	if (!fileName) then
		error("[iac] File to include has no name!")
	end

	if fileName:find("sv_") then
		if (SERVER) then
			_include(fileName)
		end
	elseif fileName:find("sh_") then
		if (SERVER) then
			_AddCSLuaFile(fileName)
		end
		_include(fileName)
	elseif fileName:find("cl_") then
		if (SERVER) then
			_AddCSLuaFile(fileName)
		else
			_include(fileName)
		end
	elseif fileName:find("rq_") then
		if (SERVER) then
			_AddCSLuaFile(fileName)
		end

		_G[string.sub(fileName, 26, string.len(fileName) - 4)] = _include(fileName)
	end
end

function bootstrapper.LoadHooks(file, variable, uid)
    local PLUGIN = {}
    _G[variable] = PLUGIN
    PLUGIN.impulseLoading = true

    bootstrapper.LoadFile(file)

    local c = 0

    for v,k in pairs(PLUGIN) do
        if type(k) == "function" then
            c = c + 1
            hook.Add(v, "iacHook"..uid..c, function(...)
                return k(nil, ...)
            end)
        end
    end

    if PLUGIN.OnLoaded then
        PLUGIN.OnLoaded()
    end

    PLUGIN.impulseLoading = nil
    _G[variable] = nil
end

function bootstrapper.LoadDir(directory, hookMode, variable, uid)
	for k, v in _ipairs(_file_Find(directory.."/*.lua", "LUA")) do
    	if hookMode then
    		bootstrapper.LoadHooks(directory.."/"..v, variable, uid)
    	else
    		bootstrapper.LoadFile(directory.."/"..v)

    		if SERVER then
    			owo(Color(76, 209, 55), "[iac] Loading "..v.."\n")
    		end
    	end
	end
end

--bootstrapper.LoadHooks("iac/punishers/"..iac.Config.Punisher..".lua", true, "PUNISHER", "punisher")
bootstrapper.LoadDir("iac/libs")
bootstrapper.LoadDir("iac/config")
bootstrapper.LoadDir("iac/core")
bootstrapper.LoadDir("iac/modules")

if SERVER then
	owo(Color(76, 209, 55), "[iac] Loaded!\n")
end
