local PANEL = {}

function PANEL:Show()
    local title = self.block.name

    self:SetSkin("combine")
    self:SetSize(200, 150)
    self:Center()
    self:SetTitle(title)
    self.lblTitle.UpdateColours = function(label, skin)
        label:SetTextStyleColor(Color(255, 255, 255))
    end
    self:MakePopup()
    self:SetMouseInputEnabled(true)

    if LocalPlayer():IsCP() then
        self:OpenCPDerma()
    elseif LocalPlayer():HasApartment() then
        if LocalPlayer():IsApartmentOwner() then
            self:OpenManagementDerma()
        else
            self:OpenLeaveDerma()
        end
    else
        self:OpenBuyDerma()
    end
end

function PANEL:OpenBuyDerma()
    self.comboBox = vgui.Create("DComboBox", self )
    self.comboBox:SetSize(150, 25)
    self.comboBox:SetPos(25, 50)
    self.comboBox:SetTextColor(Color(0, 0, 0))
    self.comboBox:SetValue("Select an apartment.")
    for v,k in pairs(self.listedApartments) do
        self.comboBox:AddChoice(k.name, v)
    end


    self.buyApt = vgui.Create("DButton", self )
    self.buyApt:SetSize(150, 25)
    self.buyApt:SetPos(25, 100)
    self.buyApt:SetDisabled(true)
    self.buyApt:SetColor(Color(255, 255, 255))
    self.buyApt:SetText("Purchase Apartment")
    self.buyApt.DoClick = function()
        net.Start("impulseHL2RPBuyApartment")
        net.WriteInt(self.blockIndex, 8)
        net.WriteInt(self.comboBox:GetOptionData(self.comboBox:GetSelectedID()), 8)
        net.SendToServer()
        self:Close()
    end

    self.comboBox.OnSelect = function()
        self.buyApt:SetDisabled(false)
    end
end

function PANEL:OpenLeaveDerma()
    self.sellApt = vgui.Create("DButton", self )
    self.sellApt:SetSize(150, 25)
    self.sellApt:SetPos(25, 75)
    self.sellApt:SetText("Leave Apartment.")
    self.sellApt.DoClick = function()
        net.Start("impulseHL2RPLeaveApartment")
        net.SendToServer()
        self:Close()
    end
end

function PANEL:OpenCPDerma()
    self:SetSize(500, 300)
    self:Center()

    self.blockInhabs = vgui.Create("DPanel", self)
    self.blockInhabs:Dock(FILL)

    self.blockInhabsList = vgui.Create("DScrollPanel", self.blockInhabs)
    self.blockInhabsList:Dock(FILL)

    self.loadScreen = self.blockInhabsList:Add("DProgress")
	self.loadScreen:SetFraction(0)
    self.loadScreen:Dock(FILL)

    self.loadLabel = self.blockInhabsList:Add("DLabel")
    self.loadLabel:SetText("RETRIEVING INHABITANTS")
    self.loadLabel:SetContentAlignment(5)
    self.loadLabel:Dock(FILL)
    self.loadLabel:SetTextColor(Color(0, 0, 0))

    self.doThink = true
    self.startTime = CurTime()

    LocalPlayer():SendCombineMessage("Hooking into apartment mainframe...")

    timer.Simple(3, function()
        if !IsValid(self) then return end
        local inhabsTable = {}
        for v,k in pairs(self.block.apartments) do
            local door = Entity(k.doors[1])
            if !IsValid(door) then return end
                self.doThink = false
                self.loadScreen:Remove()
                local inhabs = door:GetSyncVar(SYNC_DOOR_OWNERS, {})
                for a,b in pairs(inhabs) do
                    local entry = self.blockInhabsList:Add("impulseBlockTerminalPlayer")
                    entry:SetPlayer(Entity(b), k.name)
                    entry:SetHeight(60)
                    entry:Dock(TOP)
                end
        end
    end)
end

function PANEL:OpenManagementDerma()
    self:SetSize(200, 175)

    self.inhabsLabel = vgui.Create("DLabel", self)
    self.inhabsLabel:SetPos(27, 50)
    self.inhabsLabel:SetContentAlignment(5)
    self.inhabsLabel:SetText("- INHABITANT MANAGEMENT -")
    self.inhabsLabel:SizeToContents()

    self.addInhabsButton = vgui.Create("DButton", self)
    self.addInhabsButton:SetSize(70, 25)
    self.addInhabsButton:SetPos(25, 75)
    self.addInhabsButton:SetText("Add")
    self.addInhabsButton.DoClick = function()
        self:OpenAddInhabsDerma()
    end

    self.removeInhabsButton = vgui.Create("DButton", self)
    self.removeInhabsButton:SetSize(70, 25)
    self.removeInhabsButton:SetPos(105, 75)
    self.removeInhabsButton:SetText("Remove")
    self.removeInhabsButton.DoClick = function()
        self:OpenRemoveInhabsDerma()
    end

    self.sellApt = vgui.Create("DButton", self )
    self.sellApt:SetSize(150, 25)
    self.sellApt:SetPos(25, 125)
    self.sellApt:SetText("Sell Apartment")
    self.sellApt.DoClick = function()
        net.Start("impulseHL2RPLeaveApartment")
        net.SendToServer()
        self:Close()
    end

end

function PANEL:OpenAddInhabsDerma()
    local dm = DermaMenu()
    local apt = LocalPlayer():GetApartment()

    for v,k in pairs(player.GetAll()) do
        if k == LocalPlayer() then
            continue
        end

        if k:HasApartment() or k:IsCP() then
            continue
        end

        local name = k:Nick()
    	
        if k:GetFriendStatus() == "friend" then
            name = "(FRIEND) " .. name 
        end

        local x = dm:AddOption(name, function()
            net.Start("impulseHL2RPAptAddInhabitant")
            net.WriteEntity(k)
            net.SendToServer()
        end)
        
        x:SetIcon("icon16/user_add.png")
    end
    dm:Open()

end

function PANEL:OpenRemoveInhabsDerma()
    local dm = DermaMenu()
    local apt = LocalPlayer():GetApartment()

    for v,k in pairs(player.GetAll()) do
        if k:GetApartment() != apt or k == LocalPlayer() then
            continue
        end

        local name = k:Nick()

        if k:GetFriendStatus() == "friend" then
            name = "(FRIEND) " .. name 
        end

        local x = dm:AddOption(name, function()
            net.Start("impulseHL2RPAptRemoveInhabitant")
            net.WriteEntity(k)
            net.SendToServer()
        end)

        x:SetIcon("icon16/user_delete.png")
    end

    dm:Open()
end

function PANEL:Think()
	if self.doThink then
		self.loadScreen:SetFraction(math.Clamp((CurTime() - self.startTime) / ((self.startTime + 3) - self.startTime), 0, 1) )
	end
end

vgui.Register("impulseApartmentPanel", PANEL, "DFrame")

