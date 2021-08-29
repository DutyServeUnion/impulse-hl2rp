local PANEL = {}

function PANEL:Init()
	self:SetSize(600, 450)
	self:Center()
	self:SetSkin("combine")
	self:MakePopup()
	self.lblTitle:SetFont("BudgetLabel")
	self.lblTitle:SetTextColor(color_white)

	local panel = self
	local lp = LocalPlayer()

	local trace = {}
	trace.start = lp:EyePos()
	trace.endpos = trace.start + lp:GetAimVector() * 85
	trace.filter = lp

	local tr = util.TraceLine(trace)

	if IsValid(tr.Entity) and tr.Entity:GetClass() == "impulse_hl2rp_terminal" then
		self.terminalEnt = tr.Entity
	else
		return self:Remove()
	end

	self:SetTitle("<:: TERMINAL #"..self.terminalEnt:EntIndex())
end

function PANEL:SetupUI()
	self.menu = vgui.Create("DColumnSheet", self)
	self.menu:Dock(FILL)
	self.menu.Navigation:SetWidth(120)
	self.menu.Content:InvalidateLayout(true)

	if self.ArrestedPlayer and IsValid(self.ArrestedPlayer) and LocalPlayer():Team() == TEAM_CP then
		self.charges = vgui.Create("DPanel", self.menu)
		self.charges:Dock(FILL)

		self.chargesInfo = vgui.Create("DLabel", self.charges)
		self.chargesInfo:SetText("You are charging: "..self.ArrestedPlayer:Name())
		self.chargesInfo:SetFont("BudgetLabel")
		self.chargesInfo:Dock(TOP)

		self.chargesBody = vgui.Create("impulseChargesMenu", self.charges)
		self.chargesBody:Dock(FILL)
		self.chargesBody.master = self
	end

	self.bulletin = vgui.Create("DPanel", self.menu)
	self.bulletin:Dock(FILL)

	local cityCode = impulse.Dispatch.GetCityCode()
	local cityCodeData = impulse.Dispatch.CityCodes[cityCode]

	self.lblCityCode = vgui.Create("DLabel", self.bulletin)
	self.lblCityCode:Dock(TOP)
	self.lblCityCode:SetText("CITY CODE: "..cityCode.." ("..cityCodeData[1]..")")
	self.lblCityCode:SetColor(cityCodeData[2])
	self.lblCityCode:SetFont("BudgetLabel")

	self.lblCitizenCount = vgui.Create("DLabel", self.bulletin)
	self.lblCitizenCount:Dock(TOP)
	self.lblCitizenCount:SetText("CITIZEN POPULATION COUNT: "..tostring(#team.GetPlayers(TEAM_CITIZEN) + #team.GetPlayers(TEAM_CWU)))
	--self.lblCitizenCount:SetColor(Color(0, 0, 215))
	self.lblCitizenCount:SetFont("BudgetLabel")

	self.lblLocalUnit = vgui.Create("DLabel", self.bulletin)
	self.lblLocalUnit:SetText("\nLOCAL UNIT: "..LocalPlayer():Name().."\nLOCAL DIVISON: "..LocalPlayer():GetTeamClassName().."\nLOCAL RANK: "..LocalPlayer():GetTeamRankName().."\n")
	self.lblLocalUnit:SizeToContents()
	self.lblLocalUnit:Dock(TOP)
	self.lblLocalUnit:SetFont("BudgetLabel")

	self.lblReminder = vgui.Create("DLabel", self.bulletin)
	self.lblReminder:SetText("\n\n---------------------------------\nReminder: Memory replacement is the first step toward rank\npriviledges.\n---------------------------------\n\n---------------------------------\nReminder: Check BOL list regularly.\n---------------------------------")
	self.lblReminder:SetFont("BudgetLabel")
	self.lblReminder:SizeToContents()
	self.lblReminder:Dock(TOP)
	--self.lblCitizenCount:SetColor(Color(0, 0, 215))

	--if LocalPlayer():Team() == TEAM_CP and LocalPlayer():GetTeamClass() == TEAM_GRID then
	--	self.btnScanner = vgui.Create("DButton", self.bulletin)
	--	self.btnScanner:SetText("Deploy Scanner")
	--	self.btnScanner:SetFont("BudgetLabel")
	--	self.btnScanner:Dock(TOP)
	--end

	self.humanIndex = vgui.Create("DPanel", self)
	self.humanIndex:Dock(FILL)

	self.humanIndexList = vgui.Create("DListView", self.humanIndex)
	self.humanIndexList:Dock(FILL)
	self.humanIndexList:SetMultiSelect(false)
	self.humanIndexList:SetSortable(true)
	self.humanIndexList:SetSkin("combine")

	local title1 = self.humanIndexList:AddColumn("NAME")
	local title2 = self.humanIndexList:AddColumn("CID")
	title1.Header:SetFont("BudgetLabel")
	title2.Header:SetFont("BudgetLabel")

	for v,k in pairs(player.GetAll()) do
		if not k:IsCP() then
			local line = self.humanIndexList:AddLine(k:Name(), k:SteamID64())
			for v,k in pairs(line.Columns) do
				k:SetFont("BudgetLabel")
			end

			function line:UpdateColors()
				return color_white
			end
		end
	end

	local doConvicts = false

	if self.Convicts and LocalPlayer():CanUseTerminalConvicts() then
		doConvicts = true

		self.convictIndex = vgui.Create("DPanel", self)
		self.convictIndex:Dock(FILL)

		self.convictIndexList = vgui.Create("DScrollPanel", self.convictIndex)
		self.convictIndexList:Dock(FILL)

		for v,k in pairs(self.Convicts) do		
			if IsValid(v) and v:IsPlayer() then
				local entry = self.convictIndexList:Add("impulseTerminalPlayer")
				entry:SetPlayer(v, 1)
				entry:SetHeight(60)
				entry:Dock(TOP)
				entry.convictData = k
				entry.master = self
			end
		end
	end

	local doDispatch = false
	local panel = self

	if IsValid(self.terminalEnt) and self.terminalEnt:GetOverwatchIndex() and (LocalPlayer():IsCPCommand() or LocalPlayer():Team() == TEAM_CA) then
		doDispatch = true

		self.dispatch = vgui.Create("DPanel", self)
		self.dispatch:Dock(FILL)

		self.changeStateLbl = vgui.Create("DLabel", self.dispatch)
		self.changeStateLbl:SetText("CHANGE CITY CODE:")
		self.changeStateLbl:SetFont("BudgetLabel")
		self.changeStateLbl:SizeToContents()
		self.changeStateLbl:Dock(TOP)

		self.changeStateBtn = vgui.Create("DComboBox", self.dispatch)
		self.changeStateBtn:SetValue(cityCodeData[1])
		self.changeStateBtn.lastThingy = cityCodeData[1]
		self.changeStateBtn:SetTextColor(cityCodeData[2])
		self.changeStateBtn:SetDark(true)
		self.changeStateBtn:SetSortItems(false)

		function self.changeStateBtn:Paint(w,h)
			local alpha = 90
			surface.SetDrawColor(39, 60, 117, alpha)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(0, 0, 0, 180)
			surface.DrawOutlinedRect(0, 0, w, h)

			surface.SetDrawColor(180, 180, 180, 2)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)

			draw.SimpleText(self:GetText(), "DebugFixed", 5, 3, self:GetTextColor())
			return true
		end

		local panel = self

		function self.changeStateBtn:OnSelect(index, text, value)
			local ply = LocalPlayer()

			if self.skip then
				self.skip = false
				return
			end

			if ply:Team() != TEAM_CA then
				if not ply:IsCPCommand() then -- frick glua
					return ply:Notify("You must be a higher rank to perform this action.")
				end
			end

			if index < 4 or ((ply:Team() == TEAM_CP and ply:GetTeamRank() == RANK_CMD) or ply:IsAdmin()) then
				local name = impulse.Dispatch.CityCodes[index][1]

				local confirm = Derma_Query("Change City Code to: "..name.."?", "CONFIRMATION REQUIRED", "CONFIRM", function()
					if IsValid(self) and IsValid(panel) then
						self.lastThingy = index
						
						net.Start("impulseHL2RPDispatchCityCode")
						net.WriteUInt(index, 4)
						net.SendToServer()

						self.skip = true
						self:ChooseOptionID(self.lastThingy or 1)

						panel:Remove()
					end
				end, "ABORT", function()
					if IsValid(self) and IsValid(panel) then
						panel:Remove()
						return ply:Notify("Aborted.")
					end
				end)

				confirm:SetSkin("combine")
			else
				panel:Remove()
				return ply:Notify("You must be a higher rank to perform this action.")
			end
		end

		for v,k in SortedPairs(impulse.Dispatch.CityCodes) do
			local name = k[1]
			if cityCodeData[1] == name then
				name = name.." (CURRENT CODE)"
			end

			self.changeStateBtn:AddChoice(name, v)
		end

		self.changeStateBtn:Dock(TOP)

		self.dispatchLineLbl = vgui.Create("DLabel", self.dispatch)
		self.dispatchLineLbl:SetText("CIVIL ADDRESS SYSTEM:")
		self.dispatchLineLbl:SetFont("BudgetLabel")
		self.dispatchLineLbl:SizeToContents()
		self.dispatchLineLbl:SetPos(0, 60)

		self.dispatchLineScroll = vgui.Create("DScrollPanel", self.dispatch)
		self.dispatchLineScroll:SetPos(0, 80)
		self.dispatchLineScroll:SetSize(450, 300)

		for v,k in pairs(impulse.Config.DispatchLines) do
			local dispatchBtn = self.dispatchLineScroll:Add("DButton")
			dispatchBtn:SetText(k.name)
			dispatchBtn:SetFont("DebugFixed")
			dispatchBtn:Dock(TOP)
			dispatchBtn:DockMargin(0, 0, 0, 5)
			dispatchBtn.Announcement = v

			function dispatchBtn:DoClick()
				net.Start("impulseHL2RPDispatchAnnounce")
				net.WriteUInt(self.Announcement, 8)
				net.SendToServer()
			end
		end
	end

	if LocalPlayer():IsCP() and LocalPlayer():GetTeamRank() >= RANK_DVL then
		self.disipline = vgui.Create("DPanel", self.menu)
		self.disipline:Dock(FILL)

		self.disiplineList = vgui.Create("DListView", self.disipline)
		self.disiplineList:Dock(FILL)
		self.disiplineList:SetMultiSelect(false)
		self.disiplineList:SetSortable(true)
		self.disiplineList:SetSkin("combine")

		local title1 = self.disiplineList:AddColumn("UNIT")
		local title2 = self.disiplineList:AddColumn("CID")
		title1.Header:SetFont("BudgetLabel")
		title2.Header:SetFont("BudgetLabel")

		for v,k in pairs(player.GetAll()) do
			if k:Team() == TEAM_CP and k != LocalPlayer() then
				local line = self.disiplineList:AddLine(k:Name(), k:SteamID64())
				for v,k in pairs(line.Columns) do
					k:SetFont("BudgetLabel")
				end

				function line:UpdateColors()
					return color_white
				end
			end
		end

		local warning = "YOU MAY ONLY DEMOTE IF THIS USER HAS BROKEN THE RULES. YOU CAN NOT DEMOTE A VALID ROGUE UNIT.\nABUSE OF THIS SYSTEM WILL RESULT IN WHITELIST REMOVAL AND A BAN."

		function self.disiplineList:OnRowSelected(index, row)
			local m = DermaMenu()
			m:SetSkin("combine")
			m:AddOption("Demote", function()
				Derma_Query("Are you sure you want to demote "..row:GetValue(1).."?\nThis will ban them from combine teams for a short time.\n\n"..warning,
					"CONFIRMATION OF DEMOTION",
					"DEMOTE",
					function()
						local targ = player.GetBySteamID64(row:GetValue(2))
						if not IsValid(targ) then
							return 
						end

						net.Start("impulseHL2RPDemoteCP")
						net.WriteEntity(targ)
						net.SendToServer()
					end,
					"CANCEL"):SetSkin("combine")
			end):SetIcon("icon16/delete.png")

			m:Open()
		end
	end

	self.bolIndex = vgui.Create("DPanel", self)
	self.bolIndex:Dock(FILL)

	if LocalPlayer():IsCPCommand() then
		self.bolPlayer = vgui.Create("DComboBox", self.bolIndex)
		self.bolPlayer:SetPos(0, 5)
		self.bolPlayer:SetSize(450, 20)
		self.bolPlayer:SetValue("Select Citizen...")
		self.bolPlayer:SetSkin("Default")

		for v,k in pairs(player.GetAll()) do
			if not k:IsCP() and not k:IsDispatchBOL() then
				self.bolPlayer:AddChoice(k:Name(), k)
			end
		end

		self.bolCrime = vgui.Create("DComboBox", self.bolIndex)
		self.bolCrime:SetPos(0, 25)
		self.bolCrime:SetSize(450, 20)
		self.bolCrime:SetValue("Select Conviction...")
		self.bolCrime:SetSkin("Default")

		for v,k in pairs(impulse.Config.ArrestCharges) do
			self.bolCrime:AddChoice(k.name, v)
		end

		self.bolAdd = vgui.Create("DButton", self.bolIndex)
		self.bolAdd:SetText("Add BOL")
		self.bolAdd:SetPos(0, 47)
		self.bolAdd:SetSize(450, 20)
		self.bolAdd:SetFont("BudgetLabel")

		function self.bolAdd:Think()
			if panel.bolCrime:GetValue() == "Select Conviction..." or panel.bolPlayer:GetValue() == "Select Citizen..." then
				self:SetDisabled(true)
			else
				self:SetDisabled(false)
			end
		end

		local xx = self

		function self.bolAdd:DoClick()
			local name, ply = panel.bolPlayer:GetSelected()
			local charge, crime = panel.bolCrime:GetSelected()

			if not IsValid(ply) and not ply:IsDispatchBOL() then
				return
			end

			local panel = Derma_Query("Please confirm that you wish to set the BOL status of "..name..".",
				"BOL ADD CONFIRMATION",
				"ADD BOL",
				function()
					net.Start("impulseHL2RPAddBOL")
					net.WriteEntity(ply)
					net.WriteUInt(crime, 8)
					net.SendToServer()

					xx:Remove()
				end,"CANCEL")
			panel:SetSkin("combine")
		end
	end

	self.bolIndexList = vgui.Create("DScrollPanel", self.bolIndex)
	self.bolIndexList:SetPos(0, 80)
	self.bolIndexList:SetSize(500, 450)

	for v,k in pairs(player.GetAll()) do
		local bol, crime = k:IsDispatchBOL()		
		if bol then
			local entry = self.bolIndexList:Add("impulseTerminalPlayer")
			entry:SetBOLPlayer(k, crime)
			entry:SetHeight(60)
			entry:Dock(TOP)
			entry.master = self
		end
	end

	self.camIndex = vgui.Create("DPanel", self)
	self.camIndex:Dock(FILL)

	self.camExit = vgui.Create("DButton", self.camIndex)
	self.camExit:SetText("EXIT CAMERA")
	self.camExit:SetFont("BudgetLabel")
	self.camExit:SetPos(0, 0)
	self.camExit:SetSize(450, 20)

	if not WATCHING_CAM then
		self.camExit:SetDisabled(true)
	end

	function self.camExit:DoClick()
		WATCHING_CAM = nil
		impulse.hudEnabled = true
		self:SetDisabled(true)
	end

	self.camList = vgui.Create("DListView", self.camIndex)
	self.camList:SetPos(0, 30)
	self.camList:SetSize(450, 500)
	self.camList:SetMultiSelect(false)
	self.camList:SetSortable(true)
	self.camList:SetSkin("combine")

	local title1 = self.camList:AddColumn("CAM")
	local title2 = self.camList:AddColumn("STATUS")
	title1.Header:SetFont("BudgetLabel")
	title2.Header:SetFont("BudgetLabel")

	for v,k in pairs(ents.FindByClass("npc_combine_camera")) do
		local camid = k:GetSyncVar(SYNC_CAM_CAMID, nil)

		if not camid then
			continue
		end

		local line = self.camList:AddLine(camid, k:IsCameraEnabled() and "ONLINE" or "OFFLINE")
		for v,k in pairs(line.Columns) do
			k:SetFont("BudgetLabel")
		end

		function line:UpdateColors()
			return color_white
		end

		line.Ent = k
	end

	self.camList:SortByColumn(1)

	function self.camList:OnRowSelected(index, row)
		local m = DermaMenu()
		m:AddOption("View camera", function()
			if not IsValid(row) then
				return
			end

			if not IsValid(row.Ent) then
				return
			end

			if not row.Ent:IsCameraEnabled() then
				return LocalPlayer():Notify("Camera is offline.")
			end

			net.Start("impulseHL2RPCameraView")
			net.WriteEntity(row.Ent)
			net.SendToServer()

			WATCHING_CAM = row.Ent
			WATCHING_CAM_POS = LocalPlayer():GetPos()
			impulse.hudEnabled = false

			panel.camExit:SetDisabled(false)
		end)

		m:Open()
	end

	self:AddTab("BULLETIN", self.bulletin)

	if self.ArrestedPlayer and IsValid(self.ArrestedPlayer) and LocalPlayer():Team() == TEAM_CP then
		self:AddTab("CIVIL CHARGES", self.charges)
	end

	self:AddTab("BOL INDEX", self.bolIndex)
	self:AddTab("CAM INDEX", self.camIndex)
	self:AddTab("HUMN. INDEX", self.humanIndex)

	if doConvicts then
		self:AddTab("CONV. INDEX", self.convictIndex)
	end

	--self:AddTab("OVRWTCH. INDEX", testPanel)

	if self.terminalEnt:GetOverwatchIndex() and (LocalPlayer():IsCPCommand() or LocalPlayer():Team() == TEAM_CA) then
		self:AddTab("DISPATCH", self.dispatch)
	end

	if LocalPlayer():IsCP() and LocalPlayer():GetTeamRank() >= RANK_DVL then
		self:AddTab("DISIPLINE", self.disipline)
	end

	hook.Run("TerminalExtraUI", self)
end

function PANEL:OnRemove()
	net.Start("impulseHL2RPTerminalLeave")
	net.SendToServer()

	WATCHING_CAM = nil
	impulse.hudEnabled = true
end

local useSounds = {
	"ambient/machines/combine_terminal_idle1.wav",
	"ambient/machines/combine_terminal_idle2.wav",
	"ambient/machines/combine_terminal_idle4.wav"
}

function PANEL:AddTab(name, panel)
	local newSheet = self.menu:AddSheet(name, panel)

	newSheet.Button:SetFont("BudgetLabel")

	local btnClick = newSheet.Button.DoClick
	local panel = self
	newSheet.Button.DoClick = function()
		btnClick()
		panel.terminalEnt:EmitSound(useSounds[math.random(1, #useSounds)], 60)
	end
end


vgui.Register("impulseTerminalMenu", PANEL, "DFrame")
