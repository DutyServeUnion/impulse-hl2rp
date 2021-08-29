local lastSongs = lastSongs or {}
CUSTOM_MUSICKITS = CUSTOM_MUSICKITS or {}

file.CreateDir("impulse")
file.CreateDir("impulse/musickits")

CreateClientConVar("impulse_music_forcecombat", "0", false, false, "If we should force the combat state for music. Used for debugging.", 0, 1)
CreateClientConVar("impulse_music_debug", "0", false, false, "Prints details about the currently playing music to console. Used for debugging.", 0, 1)

local function DebugPrint(msg)
	if GetConVar("impulse_music_debug"):GetBool() then
		print("[impulse] [musicdebug] "..msg)
	end
end

local function ReadMusicKit(name)
	local txt = file.Read("impulse/musickits/"..name)

	if not txt then
		return "Failed to read music kit file."
	end
	
	local json = util.JSONToTable(txt)
	local antiCrash = {}

	if not json or not istable(json) then
		return "Corrupted music kit file. Check formatting."
	end

	if not json.Name or not isstring(json.Name) then
		return "Missing name value, or name value is not a string."
	end

	if not json.Combat or not istable(json.Combat) or not json.Ambient or not istable(json.Ambient) then
		return "Missing combat and ambient tracks."
	end

	if table.Count(json.Combat) < 4 then
		return "At least 4 tracks are required in the combat track list."
	end

	if table.Count(json.Ambient) < 4 then
		return "At least 4 tracks are required in the ambient track list."
	end

	for v,k in pairs(json.Ambient) do
		if not istable(k) or not k.Sound or not k.Length or not isstring(k.Sound) or not isnumber(k.Length) then
			return "Ambient track "..v.." is missing required data."
		end

		if antiCrash[k.Sound] then
			return "Same sound is used more than once, this is not allowed."
		end

		antiCrash[k.Sound] = true
	end

	for v,k in pairs(json.Combat) do
		if not istable(k) or not k.Sound or not k.Length or not isstring(k.Sound) or not isnumber(k.Length) then
			return "Combat track "..v.." is missing required data."
		end

		if antiCrash[k.Sound] then
			return "Same sound is used more than once, this is not allowed."
		end

		antiCrash[k.Sound] = true
	end

	if json.DeathSound and not isstring(json.DeathSound) then
		return "DeathSound must be a string."
	end

 	-- compile it
	local comp = {}

	comp.Ambient = {}
	comp.Combat = {}

	for v,k in pairs(json.Ambient) do
		table.insert(comp.Ambient, {k.Sound, k.Length})
	end

	for v,k in pairs(json.Combat) do
		table.insert(comp.Combat, {k.Sound, k.Length})
	end

	if json.DeathSound then
		comp.DeathSound = json.DeathSound
	end

	CUSTOM_MUSICKITS[json.Name] = comp

	print("[impulse] [musickits] Loaded "..json.Name.." ("..name..") music kit.")
end

local function GetMusicKits()
	local kits = file.Find("impulse/musickits/*.json", "DATA")
	local comp = {}

	for v,k in pairs(kits) do
		local err = ReadMusicKit(k)

		if err then
			print("[impulse] [musickits] Failed to load "..k.." | "..err)
			impulse.MenuMessage.Add("musickit-error", "Music Kit Error", "Error when loading '"..k.."' music kit.\nError: "..err, Color(255, 0, 0), "https://impulse-community.com/threads/music-kit-creation-guide.2379/", "Read the music kit guide")
			continue
		end
	end
end

GetMusicKits()

local names = {"Default"}
for v,k in pairs(CUSTOM_MUSICKITS) do
	table.insert(names, v)
end

impulse.DefineSetting("music_kit", {name="Music kit", category="Music", type="dropdown", default="Default", options=names})

concommand.Add("impulse_reloadmusickits", function()
	print("[impulse] Reloading music kits...")
	CUSTOM_MUSICKITS = {}

	impulse.MenuMessage.Remove("musickit-error")
	GetMusicKits()

	local names = {"Default"}
	for v,k in pairs(CUSTOM_MUSICKITS) do
		table.insert(names, v)
	end

	impulse.DefineSetting("music_kit", {name="Music kit", category="Music", type="dropdown", default="Default", options=names})
end)

local function GetRandomSong(style)
	local x = impulse.Config.PassiveMusic
	if style == "combat" then
		x = impulse.Config.CombatMusic
	end

	local kitName = impulse.GetSetting("music_kit")
	if kitName and kitName != "Default" and CUSTOM_MUSICKITS[kitName] then
		if style == "combat" then
			x = CUSTOM_MUSICKITS[kitName].Combat
		else
			x = CUSTOM_MUSICKITS[kitName].Ambient
		end
	end

	local t = x[math.random(1, #x)]
	local r = t[1]

	if lastSongs[r] then
		return GetRandomSong(style)
	end

	local highest = -1
	local lowest = 999999
	local key = ""
	for v,k in pairs(lastSongs) do
		if k < lowest then
			lowest = k
			key = v
		end

		if k > highest then
			highest = k
		end	
	end

	if table.Count(lastSongs) > 2 then
		lastSongs[key] = nil
	end

	lastSongs[r] = highest + 1

	DebugPrint("Selected track "..r.." (length: "..t[2]..")")

	return r, t[2]
end

local function InCombat() -- simple for now
	local forcedCombat = GetConVar("impulse_music_forcecombat"):GetBool()

	if forcedCombat then
		return true
	end

	return impulse.Dispatch.GetCityCode() >= CODE_JW
end

function PLUGIN:DefineSettings()
	impulse.DefineSetting("music_enabled", {name="Music enabled", category="Music", type="tickbox", default=true})
	impulse.DefineSetting("music_ambientvol", {name="Ambient music volume", category="Music", type="slider", default=0, minValue=0, maxValue=100})
	impulse.DefineSetting("music_combatvol", {name="Combat music volume", category="Music", type="slider", default=25, minValue=0, maxValue=100})
end

function PLUGIN:GetDeathSound()
	local kitName = impulse.GetSetting("music_kit")

	if kitName and CUSTOM_MUSICKITS[kitName] and CUSTOM_MUSICKITS[kitName].DeathSound then
		return CUSTOM_MUSICKITS[kitName].DeathSound
	end 
end

local nextThink = 0
local currentPassive = currentPassive or nil
local currentCombat = currentCombat or nil
local currentPassiveFading = currentPassiveFading or nil
local currentCombatFading = currentCombatFading or nil
function PLUGIN:Think()
	local ctime = CurTime()
	if nextThink > ctime then
		return
	end

	nextThink = ctime + 1

	local kitName = impulse.GetSetting("music_kit")
	local swap = false

	if lastKitName and kitName != lastKitName then
		swap = true
	end

	lastKitName = kitName

	if swap or LocalPlayer():Team() == 0 or ((impulse) and (IsValid(impulse.MainMenu) and not impulse.MainMenu.popup and impulse.MainMenu:IsVisible()) or IsValid(impulse.SplashScreen)) then
		if currentPassive then
			timer.Remove("impulseMusicPassiveTrackTime")
			currentPassive:Stop()
		end

		if currentCombat then
			timer.Remove("impulseMusicCombatTrackTime")
			currentCombat:Stop()
		end

		return
	end

	if not impulse.GetSetting("music_enabled", false) or impulse.Ops.EventManager.GetEventMode() or not LocalPlayer():Alive() then
		if currentPassive and currentPassive:IsPlaying() then
			timer.Remove("impulseMusicPassiveTrackTime")
			currentPassive:FadeOut(1.5)

			timer.Simple(1.5, function()
				if currentPassive then
					currentPassive:Stop()
				end
			end)
		end

		if currentCombat and currentCombat:IsPlaying() then
			timer.Remove("impulseMusicCombatTrackTime")
			currentCombat:FadeOut(1.5)

			timer.Simple(1.5, function()
				if currentCombat then
					currentCombat:Stop()
				end
			end)
		end

		return
	end

	local inCombat = InCombat()

	if inCombat then
		if currentPassive and currentPassive:IsPlaying() then
			if not currentPassiveFading then
				timer.Remove("impulseMusicPassiveTrackTime")
				currentPassive:FadeOut(6)
				currentPassiveFading = true
				DebugPrint("Fading out ambient to move to combat...")

				timer.Simple(6, function()
					currentPassive:Stop()
					currentPassiveFading = false
					DebugPrint("Stopped ambient track")
				end)
			end
		end

		if not currentCombat or not currentCombat:IsPlaying() then
			local s, l = GetRandomSong("combat")

			currentCombat = CreateSound(LocalPlayer(), s)
			currentCombat:SetSoundLevel(0)
			currentCombat:PlayEx(0, 100)
			currentCombat:ChangeVolume(impulse.GetSetting("music_combatvol") / 200, 6)

			DebugPrint("Playing combat track...")

			timer.Remove("impulseMusicCombatTrackTime")
			timer.Create("impulseMusicCombatTrackTime", l, 1, function()
				if currentCombat then
					currentCombat:Stop()
					DebugPrint("Stopping combat track (track complete)...")
				end
			end)
		end

		return
	elseif currentCombat and currentCombat:IsPlaying() then
		if not currentCombatFading then
			timer.Remove("impulseMusicCombatTrackTime")
			currentCombat:ChangeVolume(0, 120)
			currentCombatFading = true
			DebugPrint("Fading out combat to move to ambient...")

			timer.Simple(8, function()
				currentCombat:Stop()
				currentCombatFading = false
				DebugPrint("Stopped combat track")
			end)
		end

		return
	end

	if not currentPassive or not currentPassive:IsPlaying() then
		local s, l = GetRandomSong("passive")

		currentPassive = CreateSound(LocalPlayer(), s)
		currentPassive:SetSoundLevel(0)
		currentPassive:PlayEx(0, 100)
		currentPassive:ChangeVolume(impulse.GetSetting("music_ambientvol") / 200, 12)

		DebugPrint("Playing ambient track...")

		timer.Remove("impulseMusicPassiveTrackTime")
		timer.Create("impulseMusicPassiveTrackTime", l, 1, function()
			if currentPassive then
				currentPassive:Stop()
				DebugPrint("Stopping ambient track (track complete)...")
			end
		end)
	end
end
