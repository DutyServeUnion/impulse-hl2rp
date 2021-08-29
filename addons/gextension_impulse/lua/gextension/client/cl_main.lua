//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

net.Receive("GExtension_Net_RunLua", function()
	local lua = net.ReadString()

	if lua then
		lua = string.Replace(lua, '\\', '')

		RunString(lua) 
	end
end)

hook.Add("InitPostEntity", "GExtension_Main_InitPostEntity", function()
	if IsValid(LocalPlayer()) then
		http.Fetch(GExtension.WebURL .. 'request.php?t=user&id=' .. LocalPlayer():SteamID64())
		http.Fetch(GExtension.WebURL .. 'request.php?t=main')
	end
end)
