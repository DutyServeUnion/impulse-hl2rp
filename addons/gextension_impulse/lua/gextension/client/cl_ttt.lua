local battery_max = 100
local battery_min = 10

local function GetRechargeRate()
   local r = GetGlobalFloat("ttt_voice_drain_recharge", 0.05)
   if LocalPlayer().voice_battery < battery_min then
      r = r / 2
   end
   return r
end

local function GetDrainRate()
	if not GetGlobalBool("ttt_voice_drain", false) then return 0 end

   if GetRoundState() != ROUND_ACTIVE then return 0 end
   local ply = LocalPlayer()
   if (not IsValid(ply)) or ply:IsSpec() then return 0 end

   if ply:IsAdmin() or ply:IsDetective() or GExtension.Voicedrain then
      return GetGlobalFloat("ttt_voice_drain_admin", 0)
   else
      return GetGlobalFloat("ttt_voice_drain_normal", 0)
   end
end

local function IsTraitorChatting(client)
   return client:IsActiveTraitor() and (not client.traitor_gvoice)
end

function GExtension:TTT_Voice_Tick()
   if not GetGlobalBool("ttt_voice_drain", false) then return end

   local client = LocalPlayer()
   if VOICE.IsSpeaking() and (not IsTraitorChatting(client)) then
      client.voice_battery = client.voice_battery - GetDrainRate()

      if not VOICE.CanSpeak() then
         client.voice_battery = 0
         RunConsoleCommand("-voicerecord")
      end
   elseif client.voice_battery < battery_max then
      client.voice_battery = client.voice_battery + GetRechargeRate()
   end
end

timer.Simple(5, function()
   if GAMEMODE_NAME == "terrortown" and VOICE then
      VOICE.Tick = function()
         GExtension:TTT_Voice_Tick()
      end
   end
end)
