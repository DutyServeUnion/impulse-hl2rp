local update = "1.4"
local content = [[<font=Impulse-Elements18><font=Impulse-SpecialFont>What's new in 1.4?</font>

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Welcome to District 47, #SteamName!</font></colour>
District 47 is a sprawling city map, returning us to a similar setting to City 17 B210. Check out the new hospital, OTA training simulations or try your luck entering the sewers...

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Pimp my weapon - attachments are here</font></colour>
Attachments are finally here! The hunting scope has been added for the Mini-14 along with the more advanced EVR scope for the AR2. Equipping these attachments will completely modify the behaviour of each weapon, requiring careful learning and attention to be used properly - you've been warned.

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Check out RANGER - join the elite of Overwatch</font></colour>
RANGER is back? No, not really. This is pretty different to the RANGER from Apex. RANGER is a new division that specialises in long-range combat, but also has the versatility to fight toe to toe with medium ranged foes with their EVR scopes!

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Oh yea - the OTA quiz is here too</font></colour>
You'll have to take it when you become OTA. Good luck, remember, no cheating!

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Insanity</font></colour>
You can now go insane. Be careful what you eat. If you go insane, visit a Doctor quick, if you're too slow you will never be cured.

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Be gone cheaters - our new homemade anti-cheat, IAC</font></colour>
IAC is our shiny new evidence based anti-cheat!

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Back to basics - reworked melee hit detection</font></colour>
We've reworked melee hit detection to be hull based, basically this means you don't have to directly hit your target with a melee weapon to damage them!

<colour=90, 200, 250, 255><font=Impulse-Elements23-Shadow>Hey you! The one reading the bottom of the changelog</font></colour>
We need Game Moderators! Seriously, we really do. We'd love for you to apply (after reading the requirements)! Go to https://impulse-community.com, head to General Chat and click 'Join the game moderation team'.
</font>]]

local show = false

net.Receive("impulseNewUpdateMessage", function()
	local jointime = net.ReadUInt(32)

	if jointime > 1600378262 then
		return
	end

	if game.GetMap() != "rp_nc_d47_v2" then
		return
	end

	local c = cookie.GetNumber("impulse_updatemessage_seen_"..update)

	if c and tobool(c) == true then
		return
	end

	cookie.Set("impulse_updatemessage_seen_"..update, 1)

	show = true
end)

function PLUGIN:ShowMenuModalMessage()
	if not show then
		return
	end

	local x = vgui.Create("impulseUpdateMessage")
	x:SetContent(string.Replace(content, "#SteamName", LocalPlayer():SteamName()))
end
