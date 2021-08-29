/*
** Copyright (c) 2017 Jake Green (TheVingard)
** This file is private and may not be shared, downloaded, used or sold.
*/

DeriveGamemode("sandbox")
MsgC( Color( 83, 143, 239 ), "[impulse] Starting client load...\n" )

impulse = impulse or {} -- defining global function table
impulse.meta = FindMetaTable( "Player" )
impulse.lib = {}

include("shared.lua")
MsgC( Color( 0, 255, 0 ), "[impulse] Completed client load...\n" )

timer.Remove("HintSystem_OpeningMenu")
timer.Remove("HintSystem_Annoy1")
timer.Remove("HintSystem_Annoy2")

hook.Add( "PreDrawHalos", "PropertiesHover", function() -- overwrite exploitable context menu shit

	if ( !IsValid( vgui.GetHoveredPanel() ) || !vgui.GetHoveredPanel():IsWorldClicker() ) then return end

	local ent = properties.GetHovered( EyePos(), LocalPlayer():GetAimVector() )
	if ( !IsValid( ent ) ) then return end

	if ent:GetNoDraw() then
		return
	end

	local c = Color( 255, 255, 255, 255 )
	c.r = 200 + math.sin( RealTime() * 50 ) * 55
	c.g = 200 + math.sin( RealTime() * 20 ) * 55
	c.b = 200 + math.cos( RealTime() * 60 ) * 55

	local t = { ent }
	if ( ent.GetActiveWeapon && IsValid( ent:GetActiveWeapon() ) ) then table.insert( t, ent:GetActiveWeapon() ) end
	halo.Add( t, c, 2, 2, 2, true, false )
end )

RunConsoleCommand("cl_showhints",  "0") -- disable annoying gmod hints by default

