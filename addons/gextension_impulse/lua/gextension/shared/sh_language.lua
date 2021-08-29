//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

local lang_callbacks = {}

if SERVER then
	util.AddNetworkString("GExtension_Net_LanguageDownload")
	util.AddNetworkString("GExtension_Net_RequestLanguage")
end

function GExtension:LoadLanguage(lang)
	local filename = "gextension/languages/" .. lang .. ".txt"

	if not file.Exists(filename, "DATA") then return false end

	local translations = self:FromJson(file.Read(filename))

	local count = 0

	for k,v in pairs(translations) do
		GExtension.Language[k] = v
		count = count + 1
	end

	if count < 1 then
		return false
	end

	GExtension:Print("neutral", "Language loaded: " .. lang)

	return true
end

function GExtension:InitLanguageFinish()
	if self.LanguageCode == "en" then return end

	local filename = "gextension/languages/" .. self.LanguageCode .. ".txt"

	if ((os.time() - file.Time(filename, "DATA")) > 86400) or not file.Exists(filename, "DATA") then
		self:DownloadLanguage(self.LanguageCode, function()
			if not self:LoadLanguage(self.LanguageCode) then
				GExtension:Print("error", "Could not load language: " .. self.LanguageCode)
			end
		end)
	else
		if not self:LoadLanguage(self.LanguageCode) then
			GExtension:Print("error", "Could not load language: " .. self.LanguageCode)
		end
	end
end

function GExtension:InitLanguage()
	if not file.IsDir("gextension", "DATA") then
		file.CreateDir("gextension")
	end
	if not file.IsDir("gextension/languages", "DATA") then
		file.CreateDir("gextension/languages")
	end

	local filename = "gextension/languages/en.txt"

	if ((os.time() - file.Time(filename, "DATA")) > 86400) or not file.Exists(filename, "DATA") then
		self:DownloadLanguage("en", function()
			if not self:LoadLanguage("en") then
				GExtension:Print("error", "Could not load language: en")
			end

			GExtension:InitLanguageFinish()
		end)
	else
		if not self:LoadLanguage("en") then
			GExtension:Print("error", "Could not load language: en")
		end

		GExtension:InitLanguageFinish()
	end
end

function GExtension:Lang(key)
	if GExtension.Language[key] then
		return GExtension.Language[key]
	else
		return key
	end
end

function GExtension:DownloadLanguage(lang, callback)
	if SERVER then
		local request = 
		{
			url			= "https://customercenter.ibot3.de/api.php",
			method		= "GET",
			parameters  = {
				t = "languagecenter",
				product = "gex",
				category = "lua",
				action = "GetTranslations",
				lang = lang
			},
			success		= function( code, body, headers )
				if code == 200 then
					local translations = GExtension:FromJson(body)
					if translations and istable(translations) and table.Count(translations) > 1 then
						file.Write("gextension/languages/" .. lang .. ".txt", GExtension:ToJson(translations))
						GExtension:Print("neutral", "Language updated: " .. lang)

						if callback then callback() end
					end
				end
			end,
			failed		= function( reason )
				GExtension:Print("error", "Could not access language server | Error: " .. reason)

				if callback then callback() end
			end
		}
		
		HTTP(request)
	end
	
	if CLIENT then
		lang_callbacks[lang] = callback

		timer.Simple(5, function()
			net.Start("GExtension_Net_RequestLanguage")
				net.WriteString(lang)
			net.SendToServer()
		end)
	end
end

if CLIENT then
	net.Receive("GExtension_Net_LanguageDownload", function()
		local lang = net.ReadString()
		local translations = net.ReadString()

		file.Write("gextension/languages/" .. lang .. ".txt", translations)
		GExtension:Print("neutral", "Language updated: " .. lang)

		if lang_callbacks[lang] then lang_callbacks[lang]() end
	end)

	hook.Add("Initialize", "GExtension_Language_Initialize", function()
		GExtension:InitLanguage()
	end)
end

if SERVER then
	net.Receive("GExtension_Net_RequestLanguage", function(len, ply)
		local lang = net.ReadString()

		if lang != "en" and lang != GExtension.LanguageCode then lang = "en" end

		local filename = "gextension/languages/" .. lang .. ".txt"

		if file.Exists(filename, "DATA") then
			local translations = file.Read(filename, "DATA")

			if translations then
				net.Start("GExtension_Net_LanguageDownload")
					net.WriteString(lang)
					net.WriteString(translations)
				net.Send(ply)
			end
		end
	end)

	hook.Add("GExtensionInitialized", "GExtension_Language_GExtensionInitialized", function()
		GExtension:InitLanguage()
	end)
end
