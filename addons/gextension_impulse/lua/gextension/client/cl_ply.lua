function GExtension:Profile(steamid)
	gui.OpenURL(self.WebURL .. "?t=user&id=" .. steamid)
end
