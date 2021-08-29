//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

function GExtension:FromJson(json_string)
	if not isstring(json_string) or string.Trim(json_string) == "" then
		json_string = "{}"
	end

	return util.JSONToTable(json_string)
end

function GExtension:ToJson(table_from)
	local json_string = "{}"

	if istable(table_from) then
		json_string = util.TableToJSON(table_from)
	end

	return json_string
end

--[[function GExtension:FormatDate(unix)
	return os.date(self.TimeFormat, tonumber(unix))
end--]]

local charset = {}

-- qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function GExtension:RandomString(length)
	math.randomseed(os.time())

  	if length > 0 then
	    return self:RandomString(length - 1) .. charset[math.random(1, #charset)]
	else
	    return ""
	end
end

function GExtension:FormatString(str, replaces)
	if istable(replaces) then
		for index, replace in pairs(replaces) do
			str = string.Replace(tostring(str), "%" .. tostring(index) .. "%", tostring(replace))
		end
	end

	return str
end

function GExtension:RemoveQuotes(str)
	str = string.Replace(tostring(str), "'", "")
	str = string.Replace(tostring(str), '"', "")
	str = string.Replace(tostring(str), '`', "")
	str = string.Replace(tostring(str), '\\', "")

	return str
end

function  GExtension:HTMLSpecialChars(text)
	text = string.Replace(text, "&", "&amp;")
	text = string.Replace(text, '"', "&quot;")
	text = string.Replace(text, "'", "&apos;")
	text = string.Replace(text, "<", "&lt;")
	text = string.Replace(text, ">", "&gt;")

	return text
end

function GExtension:Hex2RGB(hex)
    hex = hex:gsub("#","")
    if(string.len(hex) == 3) then
        return Color(tonumber("0x"..hex:sub(1,1)) * 17, tonumber("0x"..hex:sub(2,2)) * 17, tonumber("0x"..hex:sub(3,3)) * 17)
    elseif(string.len(hex) == 6) then
        return Color(tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)))
    else
    	return Color(255,255,255)
    end
end

function GExtension:IsConsole(obj)
	if type(obj) == "Entity" and (obj.EntIndex and obj:EntIndex() == 0) and !IsValid(obj) then
		return true
	else
		return false
	end
end

function GExtension:CurrentTime()
	return os.time()-- - (self.TimeOffset * 60 * 60)
end

function GExtension:FormatDate(unix)
	local offset = self.TimeOffset

	if offset == "" then
		offset = "local"
	end

	local format = "!" .. self.TimeFormat 

	if offset == "local" then
      local now = os.time()
      local local_t = os.date("*t", now)
      local utc_t = os.date("!*t", now)
      local delta = (local_t.hour - utc_t.hour)*60 + (local_t.min - utc_t.min)
      local h, m = math.modf( delta / 60)
      offset = string.format("%+.4d", 100 * h + 60 * m)
   end

   offset = offset or "GMT"
   --format = string.gsub(format, "%%z", offset)

   if offset == "GMT" then
      offset = "+0000"
   end

   offset = string.gsub(offset, ":", "")

   local sign = 1

   if string.sub(offset, 1, 1) == "-" then
      sign = -1
      offset = string.sub(offset, 2)
   elseif string.sub(offset, 1,1) == "+" then
      offset = string.sub(offset, 2)
   end

   offset = sign * (tonumber(string.sub(offset, 1, 2))*60 + tonumber(string.sub(offset, 3, 4)))*60

   return os.date(format, unix + offset)
end
