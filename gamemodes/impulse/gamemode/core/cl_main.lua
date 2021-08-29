--- A generic module that holds anything that doesnt fit elsewhere
-- @module Misc

/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

function GM:ForceDermaSkin()
	return "impulse"
end

local blur = Material("pp/blurscreen")

local superTesters = {
	["STEAM_0:1:53542485"] = true, -- mats
	["STEAM_0:1:75156459"] = true, -- jamsu
	["STEAM_0:1:83204982"] = true, -- oscar
	["STEAM_0:1:199354868"] = true,  -- enigma
	["STEAM_0:1:43061896"] = true, -- jim wakelin
	["STEAM_0:0:24607430"] = true, -- stranger
	["STEAM_0:0:26121174"] = true, -- greasy
	["STEAM_0:1:40283833"] = true -- tim cook
}

local mappers = {
	["STEAM_0:0:24607430"] = true -- stranger
}

local eventTeam = {}

local winners = {}


-- Please don't ever remove credit or users/badges from this section. People worked hard on this. Thanks!
impulse.Badges = {
	staff = {Material("icon16/shield.png"), "This player is a staff member.", function(ply) return not ply:IsIncognito() and ply:IsAdmin() end},
	donator = {Material("icon16/coins.png"), "This player is a donator.", function(ply) return ply:IsDonator() end},
	exdev = {Material("icon16/cog_go.png"), "This player is a ex impulse developer.", function(ply) return ply:SteamID() == "STEAM_0:1:102639297" end},
	dev = {Material("icon16/cog.png"), "This player is a impulse developer.", function(ply) return not ply:IsIncognito() and ply:IsDeveloper() end},
	vin = {Material("impulse/vin.png"), "Hi, it's me vin! The creator of impulse.", function(ply) return not ply:IsIncognito() and (ply:SteamID() == "STEAM_0:1:95921723") end},
	supertester = {Material("icon16/bug.png"), "This player made large contributions to the testing of impulse.", function(ply) return (superTesters[ply:SteamID()] or false) end},
	competition = {Material("icon16/rosette.png"), "This player has won a competition.", function(ply) return winners[ply:SteamID()] end},
	mapper = {Material("icon16/map.png"), "This player is a mapper that has collaborated with impulse.", function(ply) return mappers[ply:SteamID()] end},
	eventteam = {Material("icon16/controller.png"), "This player is a member of the event team.", function(ply) return eventTeam[ply:SteamID()] end},
	communitymanager = {Material("icon16/transmit.png"), "This player is a community manager. Feel free to ask them questions.", function(ply) return ply:GetUserGroup() == "communitymanager" end}
}

local cheapBlur = Color(0, 0, 0, 205)

--- Renders a blur effect on a panel. Call this inside PANEL:Paint
-- @realm client
-- @panel panel The panel to blur
-- @int layers Unknown
-- @int density Density
-- @color alpha Alpha
function impulse.blur(panel, layers, density, alpha)
	local x, y = panel:LocalToScreen(0, 0)

	if not impulse.GetSetting("perf_blur") then
		draw.RoundedBox(0, -x, -y, ScrW(), ScrH(), cheapBlur)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(-x, -y, ScrW(), ScrH())
	else
		surface.SetDrawColor(255, 255, 255, alpha)
		surface.SetMaterial(blur)

		for i = 1, 3 do
			blur:SetFloat("$blur", (i / layers) * density)
			blur:Recompute()

			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
		end
	end
end

--- Creates a work bar on the players screen
-- @realm client
-- @int time The time it will take to complete the bar
-- @string[opt] text Text to display on the bar
-- @func[opt] onDone Called when bar is complete
-- @bool[opt=false] popup If the bar should stop player input
function impulse.MakeWorkbar(time, text, onDone, popup)
	local bar = vgui.Create("impulseWorkbar")
	bar:SetEndTime(CurTime() + time)

	if text then
		bar:SetText(text)
	end
	
	if onDone then
		bar.OnEnd = onDone
	end

	if popup then
		bar:MakePopup()
	end
end

local myscrw, myscrh = 1920, 1080

function SizeW(width)
    local screenwidth = myscrw
    return width*ScrW()/screenwidth
end

function SizeH(height)
    local screenheight = myscrh
    return height*ScrH()/screenheight
end

function SizeWH(width, height)
    local screenwidth = myscrw
    local screenheight = myscrh
    return width*ScrW()/screenwidth, height*ScrH()/screenheight
end
