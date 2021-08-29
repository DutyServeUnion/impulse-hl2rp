local PANEL = {}

function PANEL:Init()
	local model = LocalPlayer():GetModel()
	local skin = LocalPlayer():GetSkin()
	local displayBodygroup

	if LocalPlayer():GetBodygroup(1) == 6 then
		displayBodygroup = 1
	else
		displayBodygroup = 6
	end

	self.doThink = false
	self.startTime = 0
	self:SetSize(300, 450)
	self:SetTitle("Locker")
	self:MakePopup()
	self:Center()

	self.modelPreview = vgui.Create("impulseModelPanel", self)
	self.modelPreview:SetPos(25, 50)
	self.modelPreview:SetSize(250, 300) 
	self.modelPreview:SetModel(model, skin)
	self.modelPreview:MoveToBack()
	self.modelPreview:SetCursor("arrow")
	self.modelPreview:SetFOV(self.modelPreview:GetFOV() - 19)
 	function self.modelPreview:LayoutEntity(ent)
 		ent:SetAngles(Angle(0, 43, 0))
 	end

 	timer.Simple(0, function()
		if not IsValid(self.modelPreview) then
			return
		end

		local ent = self.modelPreview.Entity

		if IsValid(ent) then
			for v,k in pairs(LocalPlayer():GetBodyGroups()) do
				ent:SetBodygroup(1, displayBodygroup)
			end
		end
	end)

	self.progressBar = vgui.Create("DProgress", self)
	self.progressBar:SetPos(25, 370)
	self.progressBar:SetSize(250, 5)
	self.progressBar:SetFraction(0)

	self.changeButton = vgui.Create("DButton", self)
	self.changeButton:SetPos(25, 375)
	self.changeButton:SetSize(250, 50)
	self.changeButton:SetText("Change Clothes")
	self.changeButton.DoClick = function()
		self.changeButton:SetDisabled(true)
		self.startTime = CurTime()
		self.doThink = true

		surface.PlaySound("ambient/materials/squeeker2.wav")

		timer.Simple(2, function()
			if IsValid(self) then
				net.Start("impulseHL2RPUseLocker")
				net.SendToServer()

				LocalPlayer():Notify("You have changed clothes.")
				self:Close()
			end
		end)
	end

end

function PANEL:Think()
	if self.doThink then
		self.progressBar:SetFraction(math.Clamp((CurTime() - self.startTime) / ((self.startTime + 2) - self.startTime), 0, 1) )
	end
end

vgui.Register("impulseLockerMenu", PANEL, "DFrame")
