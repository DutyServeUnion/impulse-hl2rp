local PANEL = {}

function PANEL:Init()
	self.Name = ""
	self.CID = ""
	self.IsBOL = false
	self:SetCursor("hand")
	self:SetTooltip("Left click to interact.")
end

function PANEL:SetPlayer(player, apt)
	self.Colour = team.GetColor(player:Team()) -- Store colour and name micro optomization, other things can be calculated on the go.
	self.Name = player:Nick()
	self.Player = player
	self.Apt = apt or nil

 	self.modelIcon = vgui.Create("impulseSpawnIcon", self)
	self.modelIcon:SetPos(10,4)
	self.modelIcon:SetSize(52,52)
	self.modelIcon:SetModel(player:GetModel(), player:GetSkin())
	self.modelIcon:SetTooltip(false)
	self.modelIcon:SetDisabled(true)

	timer.Simple(0, function()
		if not IsValid(self) then
			return
		end

		local ent = self.modelIcon.Entity

		if IsValid(ent) and IsValid(self.Player) then
			for v,k in pairs(self.Player:GetBodyGroups()) do
				ent:SetBodygroup(k.id, self.Player:GetBodygroup(k.id))
			end
		end
	end)

	local staticOverlay = Material("effects/tvscreen_noise002a")
	staticOverlay:SetFloat("$salpha", "0.2")
	staticOverlay:Recompute()

	local greyCol = Color(100, 100, 100, 50)
	local outlineCol = Color(0, 0, 0, 180)

	function self.modelIcon:PaintOver(w, h) -- remove that mouse hover effect
		surface.SetDrawColor(greyCol)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(outlineCol)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local oldPaint = self.modelIcon.Paint
	local background =  Material("impulse/hl2rp/background-photo.png")
	function self.modelIcon:Paint(w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(background)
		surface.DrawTexturedRect(0, 0, w, h)

		oldPaint(self, w, h)

		surface.SetMaterial(staticOverlay)
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

local darkCol = Color(39, 60, 117, 130)
local outlineCol = Color(0, 0, 0, 180)

function PANEL:Paint(w,h)
	-- Frame
	surface.SetDrawColor(outlineCol)
	surface.DrawOutlinedRect(0, 0, w, h)
	surface.SetDrawColor(darkCol)
 	surface.DrawRect(1,1,w-1,h-2)

 	surface.SetTextColor(color_white)
 	surface.SetFont("BudgetLabel")

 	surface.SetTextPos(70, 7)
 	surface.DrawText("NAME: "..self.Name)

  	surface.SetTextPos(70, 35)
 	surface.DrawText("APT: "..self.Apt)
end

vgui.Register("impulseBlockTerminalPlayer", PANEL, "DPanel")

