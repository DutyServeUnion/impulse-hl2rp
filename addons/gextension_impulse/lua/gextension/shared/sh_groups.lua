//////////////////////////////////////
//     	  GExtension (c) 2019       //
//                                  //
//  Created by Jakob 'ibot3' Müller //
//                                  //
//  You are not permitted to share, //
//   	 trade, give away, sell     //
//      or otherwise distribute     //
//////////////////////////////////////

function meta_ply:GE_HasPermission(permission)
	local group = self:GE_GetGroup()

	if not group then return false end

	local permissions = group["permissions"]

	if table.HasValue(permissions, "super") or table.HasValue(permissions, permission) then
		return true
	else
		return false
	end
end

function meta_ply:GE_GetGroupSetting(setting)
	local group_settings = self:GE_GetGroup()["settings"]

	if group_settings[setting] then
		return group_settings[setting]
	end
	
	return false
end

function meta_ply:GE_GetGroup()
	if GExtension.Groups[self:GetUserGroup()] then
		return GExtension.Groups[self:GetUserGroup()]
	else
		return false
	end
end

net.Receive("GExtension_Net_GroupData", function()
	GExtension.Groups = net.ReadTable()
end)
