-- marked for removal, can be replaced with Derma_Query

local PANEL = {}

function PANEL:Init()
    self:SetSize(250, 125)
    self:SetTitle("// SCANNER DISCONNECT PROTOCOL //")
    self:Center()
    
    self.QuitLabel = vgui.Create("DLabel", self)
    self.QuitLabel:SetText("PLEASE CONFIRM SCANNER DISCONNECT")
    self.QuitLabel:SetPos(25, 25)
    self.QuitLabel:SetSize(300, 50)

    self.QuitBtn = vgui.Create("DButton", self)
    self.QuitBtn:SetText("DISCONNECT")
    self.QuitBtn:SetPos(25, 75)
    self.QuitBtn:SetSize(200, 25)
    self.QuitBtn.DoClick = function()
        net.Start("impulseHL2RPScannerExitScanner")
        net.SendToServer()
        self:Close()
    end
end

vgui.Register("impulseQuitScanner", PANEL, "DFrame")

