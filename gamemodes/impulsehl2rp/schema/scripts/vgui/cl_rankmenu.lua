local PANEL = {}

function PANEL:Init()
	self:SetSize(500, 400)
	self:Center()
	self:SetTitle("Division and rank selection")
	self:MakePopup()

	self.characterPreview = vgui.Create("impulseModelPanel", self)
	self.characterPreview:SetSize(600, 400)
	self.characterPreview:SetPos(115, 30)
	self.characterPreview:SetFOV(80)
	self.characterPreview:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())
	self.characterPreview:MoveToBack()
	self.characterPreview:SetCursor("arrow")

	function self.characterPreview:LayoutEntity(ent) 
		ent:SetAngles(Angle(0, 40, 0))
	end

	self.divisionLbl = vgui.Create("DLabel", self)
 	self.divisionLbl:SetFont("Impulse-Elements18-Shadow")
	self.divisionLbl:SetText("Divison:")
	self.divisionLbl:SizeToContents()
	self.divisionLbl:SetPos(10, 40)

	self.divisionSelect = vgui.Create("DComboBox", self)
	self.divisionSelect:SetPos(10, 60)
	self.divisionSelect:SetSize(300, 23)
	self.divisionSelect:SetSortItems(false)
	self.divisionSelect:SetValue("Select a divison")

	local xp = LocalPlayer():GetXP()

	for v,k in pairs(impulse.Teams.Data[LocalPlayer():Team()].classes) do
		local add = (k.whitelistLevel and " and whitelist") or ""
		if k.xp <= xp then
			self.divisionSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false)
		else
			self.divisionSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false, "icon16/lock.png")
		end
	end

	local panel =  self

	function self.divisionSelect:OnSelect(index, value, data)
		local div = impulse.Teams.Data[LocalPlayer():Team()].classes[data]
		panel.descLblT:SetText(div.description)
		panel.descLblT:SetWrap(true)

		if div.model then
			panel.characterPreview:SetModel(div.model)
		end

		if div.skin then
			panel.characterPreview.Entity:SetSkin(div.skin)
		end

		if div.noSubMats then
			panel.characterPreview.Entity:SetSubMaterial(0, nil)
		else
			if panel.characterPreview.subMats then
				for v,k in pairs(panel.characterPreview.subMats) do
					panel.characterPreview.Entity:SetSubMaterial(v - 1, k)
				end
			elseif LocalPlayer():Team() == TEAM_CP then
				panel.characterPreview.Entity:SetSubMaterial(0, "models/impulse/cp/rank_i4")
			end
		end

		if div.xp > LocalPlayer():GetXP() then
			panel.doneBtn.DivisionName = nil
			return
		end

		panel.doneBtn.DivisionName = div.name
		panel.doneBtn.Division = data
	end

	self.rankLbl = vgui.Create("DLabel", self)
 	self.rankLbl:SetFont("Impulse-Elements18-Shadow")
	self.rankLbl:SetText("Rank:")
	self.rankLbl:SizeToContents()
	self.rankLbl:SetPos(10, 90)

	self.rankSelect = vgui.Create("DComboBox", self)
	self.rankSelect:SetPos(10, 110)
	self.rankSelect:SetSize(300, 23)
	self.rankSelect:SetSortItems(false)
	self.rankSelect:SetValue("Select a rank")

	for v,k in pairs(impulse.Teams.Data[LocalPlayer():Team()].ranks) do
		local add = (k.whitelistLevel and " + whitelist") or ""
		if k.xp <= xp then
			self.rankSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false)
		else
			self.rankSelect:AddChoice(k.name.." - Requires "..k.xp.."XP"..add, v, false, "icon16/lock.png")
		end
	end

	function self.rankSelect:OnSelect(index, value, data)
		local rank = impulse.Teams.Data[LocalPlayer():Team()].ranks[data]
		local div = impulse.Teams.Data[LocalPlayer():Team()].classes[panel.doneBtn.Division]

		if rank.model then
			panel.characterPreview:SetModel(rank.model)
		end

		if rank.subMaterial then
			panel.characterPreview.subMats = {}
			for v,k in pairs(rank.subMaterial) do
				panel.characterPreview.Entity:SetSubMaterial(v - 1, k)
				panel.characterPreview.subMats[v] = k
			end
		end

		if div and div.noSubMats then
			panel.characterPreview.Entity:SetSubMaterial(0, nil)
		end

		if rank.xp > LocalPlayer():GetXP() then
			panel.doneBtn.RankName = nil
			return
		end

		panel.doneBtn.RankName = rank.name
		panel.doneBtn.Rank = data
	end

	self.descLbl = vgui.Create("DLabel", self)
 	self.descLbl:SetFont("Impulse-Elements18-Shadow")
	self.descLbl:SetText("Description:")
	self.descLbl:SizeToContents()
	self.descLbl:SetPos(10, 160)

	self.descLblT = vgui.Create("DLabel", self)
 	self.descLblT:SetText("")
 	self.descLblT:SetFont("Impulse-Elements14")
 	self.descLblT:SetPos(10, 180)
 	self.descLblT:SetContentAlignment(7)
  	self.descLblT:SetSize(300, 400)

  	self.doneBtn = vgui.Create("DButton", self)
  	self.doneBtn:SetPos(10, 370)
  	self.doneBtn:SetSize(300, 23)
  	self.doneBtn:SetText("No divison or rank selected")
  	self.doneBtn:SetDisabled(true)

  	function self.doneBtn:Think()
  		if self.DivisionName and self.RankName then
  			self:SetText("Become a "..self.DivisionName.." "..self.RankName)
  			self:SetDisabled(false)
  			return
  		end

  		self:SetDisabled(true)
  		self:SetText("No valid division and/or rank selected")
  	end

  	function self.doneBtn:DoClick()
  		if self.Division and self.Rank then
	  		net.Start("impulseHL2RPRankBecome")
	  		net.WriteUInt(self.Division, 8)
	  		net.WriteUInt(self.Rank, 8)
	  		net.SendToServer()

	  		panel:Remove()
	  	end
  	end
end

vgui.Register("impulseRankMenu", PANEL, "DFrame")
