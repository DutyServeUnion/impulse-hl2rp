local PANEL = {}

function PANEL:Init()
	self:SetSize(900, 810)
	self:Center()
	self:SetTitle("ops support tools")
	self:MakePopup()

	local sheet = vgui.Create("DColumnSheet", self)
	sheet:Dock(FILL)

	local b = vgui.Create("DPanel", sheet)
	b:Dock(FILL)
	b.Paint = function() end

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("Target (Steam64 ID):")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

	local s64 = vgui.Create("DTextEntry", b)
	s64:SetFont("ChatFont")
	s64:SetPos(0, 20)
	s64:SetSize(900, 30)
	s64:SetPlaceholderText("Steam64 ID")

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("Refund:")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

    local scroll = vgui.Create("DScrollPanel", b)
    scroll:SetTall(500)
    scroll:Dock(TOP)

    local refund = {}
    local refund2 = {}
    local cats = {}

    for v,k in pairs(impulse.Inventory.Items) do
        if not cats[k.Category or "Unknown"] then 
            local cat = scroll:Add("DCollapsibleCategory")
            cat:Dock(TOP)
            cat:SetLabel(k.Category or "Unknown")
            cat:SetExpanded(false)
            
            cats[k.Category or "Unknown"] = vgui.Create("DPanelList", panel)
            local list =  cats[k.Category or "Unknown"]
            list:Dock(FILL)
            list:SetSpacing(5)
            cat:SetContents(list)
        end

        local btn = vgui.Create("DButton")
        btn:SetText("  "..k.Name.." ("..k.UniqueID..")")
        btn:SetContentAlignment(4)
        btn:Dock(TOP)
        btn:SetFont("Impulse-Elements18")
        btn:DockMargin(0, 0, 0, 5)
        btn.ItemClass = k.UniqueID

        function btn:DoClick()
        	Derma_StringRequest("impulse", "Amount of "..k.Name.." to refund", "1", function(val)
        		if not tonumber(val) then
        			return LocalPlayer():Notify("Not a number.")
        		end

        		local val = math.Clamp(math.floor(val), 0, 30)

        		if val == 0 then
        			refund[self.ItemClass] = nil

        			for v,k in pairs(refund2) do
        				if k[1] == self.ItemClass then
        					refund2[v] = nil
        				end
        			end

        			return LocalPlayer():Notify("Removed "..self.ItemClass)
        		end

        	    for v,k in pairs(refund2) do
        			if k[1] == self.ItemClass then
        				refund2[v] = nil
        			end
        		end
        		
        		refund[self.ItemClass] = val
        		table.insert(refund2, {self.ItemClass, val})

        		LocalPlayer():Notify("Selected "..k.Name.." x"..val..".")
        	end)
        end

        cats[k.Category or "Unknown"]:AddItem(btn)
    end

   	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("Total:")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)

	local lbl = vgui.Create("DLabel", b)
	lbl:SetText("Nothing")
	lbl:SetFont("Impulse-Elements18")
	lbl:Dock(TOP)
	lbl:SetContentAlignment(7)
	lbl:SetWrap(true)
	lbl:SetTall(70)

	function lbl:Think()
		local t = ""
		for v,k in pairs(refund2) do
			t = t..k[1].." x"..k[2]..", "
		end

		self:SetText(t)
	end

	local confirm = vgui.Create("DButton", b)
	confirm:SetPos(0, 700)
	confirm:SetSize(600, 60)
	confirm:SetText("Issue Refund")

	function confirm:DoClick()
		local id = string.Trim(s64:GetValue(), " ")

		if id == "" or not tonumber(id) then
			return LocalPlayer():Notify("Invalid Steam64ID.")
		end

		if not refund2 or table.Count(refund2) < 1 then
			return LocalPlayer():Notify("No refund items selected.")
		end

		local data = pon.encode(refund)

		net.Start("impulseOpsSTDoRefund")
		net.WriteString(id)
		net.WriteUInt(#data, 32)
		net.WriteData(data, #data)
		net.SendToServer()
	end

	sheet:AddSheet("Refunder", b, "icon16/bricks.png")
end

vgui.Register("impulseSupportTool", PANEL, "DFrame")
