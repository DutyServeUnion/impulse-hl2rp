if GExtension.ChatTags and not DarkRP then
	hook.Add("OnPlayerChat", "GExtension_ChatTags_OnPlayerChat", function(ply, msg)
		if IsValid(ply) then
			local group = ply:GE_GetGroup()

			if group then
				local foundException = false

				if GExtension.ChatTagExceptions then
					for _, v in pairs(GExtension.ChatTagExceptions) do
						if string.StartWith(msg, v) then
							foundException = true
						end
					end
				end
				
				if not foundException then
					local teamcolor = team.GetColor(ply:Team())

					deadTag = ""

					if not ply:Alive() then
						deadTag = "*DEAD* "
					end

					chat.AddText(GExtension:Hex2RGB(group["hexcolor"]), "[", group["displayname"], "]", " ", Color(255, 0, 0), deadTag, teamcolor, ply:Nick(), Color(255,255,255), ": ", msg)

					return true
				end
			end
		end
	end)
end
