local PANEL = {}

function PANEL:Init()
	self:SetSize(640, 670)
	self:Center()
	self:SetTitle("")
	self:MakePopup()
	self:SetBackgroundBlur(true)

	self.talk = vgui.Create("DButton", self)
	self.talk:SetPos(420, 630)
	self.talk:SetSize(200, 30)
	self.talk:SetText("Talk about in on Discord")

	function self.talk:DoClick()
		gui.OpenURL("https://discord.impulse-community.com")
	end

	self.talk = vgui.Create("DButton", self)
	self.talk:SetPos(20, 630)
	self.talk:SetSize(200, 30)
	self.talk:SetText("Check out the changelog")

	function self.talk:DoClick()
		gui.OpenURL("https://news.impulse-community.com")
	end

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:SetPos(0, 25)
	self.scroll:SetSize(self:GetWide(), 600)
end

function PANEL:SetContent(cont)
	self.log = vgui.Create("DPanel", self.scroll)
	self.log.parsedMarkup = markup.Parse(cont, self:GetWide() - 30)
	self.log:SetSize(650, self.log.parsedMarkup:GetHeight() + 40)
	self.scroll:AddItem(self.log)

	function self.log:Paint()
		self.parsedMarkup:Draw(10, 15, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
end

vgui.Register("impulseUpdateMessage", PANEL, "DFrame")
