local PANEL = {}

function PANEL:Init()
	self:SetDrawBackground(false)

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:Dock(FILL)

	self.checkboxes = {}

	for v,k in pairs(impulse.Config.ArrestCharges) do
		self:AddCharge(v,k)
	end

	self.emitButton = vgui.Create("DButton", self)
	self.emitButton:Dock(BOTTOM)
	self.emitButton:SetFont("BudgetLabel")
	self.emitButton:SetText("Emit (Charges: 0 | Cycles: 0)")

	local panel = self

	function self.emitButton:DoClick()
		local chargeCount = 0
		local charges = {}
		for v,k in pairs(panel.checkboxes) do
			table.insert(charges, v)
			chargeCount = chargeCount + 1
		end

		if chargeCount > 0 then
			net.Start("impulseHL2RPTerminalCharge")
			net.WriteUInt(#charges, 4)

			for a,b in pairs(charges) do
				net.WriteUInt(b, 8)
			end
			
			net.SendToServer()
		end

		panel.master:Remove()
	end

	self.search = vgui.Create("DTextEntry", self)
	self.search:Dock(BOTTOM)
	self.search:SetUpdateOnType(true)

	self.searchLbl = vgui.Create("DLabel", self)
	self.searchLbl:SetPos(5, 356)
	self.searchLbl:SetFont("BudgetLabel")
	self.searchLbl:SetText("Search")

	local savedValues = {}

	function self.search:OnValueChange(val)
		val = string.PatternSafe(string.lower(val))

		panel.scroll:Remove()
		panel.scroll = vgui.Create("DScrollPanel", panel)
		panel.scroll:Dock(FILL)

		for v,k in pairs(impulse.Config.ArrestCharges) do
			if string.find(string.lower(k.name), val) then
				panel:AddCharge(v,k)
			end
		end
	end
end

function PANEL:AddCharge(id, data)
	local checkbox = self.scroll:Add("DCheckBoxLabel")
	checkbox:SetFont("BudgetLabel")
	checkbox:SetText(data.name)
	checkbox.chargeID = id
	checkbox:SizeToContents()
	checkbox:Dock(TOP)
	checkbox:DockMargin(4, 4, 1, 1)

	checkbox:SetValue(self.checkboxes[id] or false)

	local panel = self

	function checkbox:OnChange(val)
		if val then
			panel.checkboxes[self.chargeID] = val
		else
			panel.checkboxes[self.chargeID] = nil
		end

		self.value = val

		local chargeCount = 0
		local cycleCount = 0
		for v,k in pairs(panel.checkboxes) do
			cycleCount = cycleCount + impulse.Config.ArrestCharges[v].severity 
			chargeCount = chargeCount + 1
		end

		local maxTime = impulse.Config.MaxJailTimeGrunt

		if LocalPlayer():IsCPCommand() then
			maxTime = impulse.Config.MaxJailTime
		end

		panel.emitButton:SetText("Emit (Charges: "..chargeCount.." | Cycles: "..math.Clamp(cycleCount, 0, (maxTime / 60))..")")
	end


	function checkbox:Think()
		if not checkbox.value and table.Count(panel.checkboxes) >= impulse.Config.MaxArrestCharges then
			self:SetDisabled(true)
		else
			self:SetDisabled(false)
		end
	end
end

vgui.Register("impulseChargesMenu", PANEL, "DPanel")
