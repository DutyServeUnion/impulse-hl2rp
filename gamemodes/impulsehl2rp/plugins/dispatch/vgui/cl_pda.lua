local PANEL = {}

function PANEL:Init()
	self:SetSize(360, 450)
	self:Center()
	self:SetSkin("combine")
	self:MakePopup()
	self.lblTitle:SetFont("BudgetLabel")
	self.lblTitle:SetTextColor(color_white)

	local panel = self
	local lp = LocalPlayer()

	self:SetTitle("<:: PDA")
	self:SetupPDA()
end

local pdaSounds = {
	[TEAM_CP] = {
		"npc/metropolice/vo/on1.wav",
		"npc/metropolice/vo/on2.wav",
		"npc/metropolice/vo/off1.wav",
		"npc/metropolice/vo/off2.wav",
		"npc/metropolice/vo/off3.wav"
	},
	[TEAM_OTA] = {
		"npc/combine_soldier/vo/on1.wav",
		"npc/combine_soldier/vo/on2.wav",
		"npc/combine_soldier/vo/off1.wav",
		"npc/combine_soldier/vo/off2.wav",
		"npc/combine_soldier/vo/off3.wav"
	}
}
local function pdaSound()
	local teamSounds = pdaSounds[LocalPlayer():Team()]

	if teamSounds then
		surface.PlaySound(teamSounds[math.random(1, #teamSounds)])
	end
end

local squadCol = Color(75, 155, 45)
function PANEL:SetupPDA()
	if IsValid(self.make) then
		self.make:Remove()
	end

	if IsValid(self.scroll) then
		self.scroll:Remove()
	end

	local panel = self
	local lp = LocalPlayer()
	local squad = lp:GetSyncVar(SYNC_SQUAD_ID)
	local isLeader = lp:GetSyncVar(SYNC_SQUAD_LEADER)
	local n = lp:Team() == TEAM_CP and "PT" or "SQUAD"
	local curSquads = 0

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:SetPos(10, 80)
	self.scroll:SetSize(340, 370)

	local squads = {}
	for v,k in pairs(team.GetPlayers(lp:Team())) do
		local sqd = k:GetSyncVar(SYNC_SQUAD_ID)
		local isLdr = k:GetSyncVar(SYNC_SQUAD_LEADER)

		if not sqd then
			continue
		end

		local function addUnit(s)
			local base = vgui.Create("DPanel")
			base:SetSkin("combine")
			function base:Paint()
			end

			local lbl = vgui.Create("DLabel", base)
			lbl:SetPos(0, 0)
			lbl:SetText("  ⏺ "..k:Nick()..(isLdr and " (LDR)" or ""))
			lbl:SetFont("DebugFixed")
			lbl:SizeToContents()

			if sqd == squad then
				lbl:SetTextColor(squadCol)
			end

			if sqd == squad and isLeader and not k == LocalPlayer() then
				local kick = vgui.Create("DButton", base)
				kick:SetText("KICK")
				kick:SetFont("DebugFixed")
				kick:SetPos(290, 2)
				kick:SetSize(35, 16)

				function kick:DoClick()
					pdaSound()

					if not IsValid(k) then
						return LocalPlayer():Notify("This player disconnected!")
					end
					
					net.Start("impulseSquadKick")
					net.WriteEntity(k)
					net.SendToServer()
				end
			end

			if isLdr then
				s.members:InsertAtTop(base)
				s.HasLeader = true
			else
				s.members:AddItem(base)
			end

			s.count = (s.count or 0) + 1
		end

		if not squads[sqd] then
			squads[sqd] = vgui.Create("DCollapsibleCategory", self.scroll)
			squads[sqd]:SetLabel(n.." "..sqd)
			squads[sqd]:Dock(TOP)
			squads[sqd].Header:SetFont("DebugFixed")

			if sqd == squad then
				squads[sqd].Header:SetTextColor(squadCol)
			else
				squads[sqd]:SetExpanded(false)
			end

			local colInv = Color(29, 50, 107, 120)
			squads[sqd].Paint = function(self)
				self:SetBGColor(colInv)
			end

			local oldMP = squads[sqd].Header.OnMousePressed
			squads[sqd].Header.OnMousePressed = function(self, code)
				oldMP(self, code)

				if code == MOUSE_RIGHT and ((isLeader and sqd != squad) or (lp:Team() == TEAM_CP and lp:GetTeamRank() >= RANK_DVL))  then
					local m = DermaMenu()

					if isLeader and sqd != squad then
						local requests, pRequests = m:AddSubMenu("Requests")
						pRequests:SetIcon("icon16/transmit.png")

						requests:AddOption("Reinforcement", function()
							pdaSound()
							if lp:Team() == TEAM_CP then
								surface.PlaySound("npc/metropolice/vo/reinforcementteamscode3.wav")
							else
								surface.PlaySound("npc/combine_soldier/vo/overwatchrequestreinforcement.wav")
							end
							
							net.Start("impulseSquadAction")
							net.WriteBool(false)
							net.WriteString("reinforce")
							net.WriteUInt(sqd, 8)
							net.SendToServer()
						end):SetIcon("icon16/group_go.png")
					end

					if lp:GetTeamRank() >= RANK_DVL then
						local orders, pOrders = m:AddSubMenu("Orders")
						pOrders:SetIcon("icon16/lightning_go.png")

						orders:AddOption("Custom order", function()
							pdaSound()

							local x = Derma_StringRequest("PDA", "ENTER ORDER (MAX. 85 CHARS)", "",
								function(t)
									if not IsValid(self) then
										return
									end

									pdaSound()

									net.Start("impulseSquadAction")
									net.WriteBool(true)
									net.WriteString("custom")
									net.WriteUInt(sqd, 8)
									net.WriteString(t)
									net.SendToServer()
								end, 
								nil, "SEND ORDER", "CANCEL")
							x:SetSkin("combine")
						end):SetIcon("icon16/lightning.png")

						orders:AddOption("Block inspection", function()
							pdaSound()

							local x = vgui.Create("DFrame")
							x:SetSize(300, 60)
							x:Center()
							x:SetTitle("BLOCK SELECTION")
							x:MakePopup()
							x:SetSkin("combine")

							local drop = vgui.Create("DComboBox", x)
							drop:Dock(TOP)

							for v,k in pairs(impulse.Config.ApartmentBlocks) do
								drop:AddChoice(k.name, v)
							end

							function drop:OnSelect(index, val, id)
								if not squads[sqd] then
									return
								end

								pdaSound()

								net.Start("impulseSquadAction")
								net.WriteBool(true)
								net.WriteString("block")
								net.WriteUInt(sqd, 8)
								net.WriteUInt(id, 8)
								net.SendToServer()

								x:Remove()
							end


						end):SetIcon("icon16/house.png")
						orders:AddOption("Disband", function()
							pdaSound()

							local x = Derma_Query("DISBAND CONFIRMATION", "PDA", "CONFIRM",
								function(t)
									if not IsValid(self) then
										return
									end

									pdaSound()

									net.Start("impulseSquadAction")
									net.WriteBool(true)
									net.WriteString("disband")
									net.WriteUInt(sqd, 8)
									net.SendToServer()
								end, 
								"CANCEL")
							x:SetSkin("combine")
						end):SetIcon("icon16/bomb.png")
					end

					m:Open()

					pdaSound()
				end
			end

			local s = squads[sqd]
			s.squadId = sqd

			s.members = vgui.Create("DPanelList", s)
			s.members:EnableHorizontal(false)
			s:SetContents(s.members)

			if not squad or squad == sqd then
				s.join = vgui.Create("DButton", squads[sqd].Header)
				s.join:SetText(sqd == squad and "LEAVE" or "JOIN")
				s.join:SetFont("DebugFixed")
				s.join:SetPos(250, 0)
				s.join:SetSize(90, 20)
				s.join:SetTextColor(sqd == squad and Color(255, 0, 0) or nil)

				if sqd != squad and not lp:SquadCanJoin(sqd) then
					s.join:SetDisabled(true)
				end

				function s.join:DoClick()
					if sqd != squad then
						net.Start("impulseSquadJoin")
						net.WriteUInt(sqd, 8)
						net.SendToServer()
					else
						net.Start("impulseSquadLeave")
						net.SendToServer()
					end

					pdaSound()
				end
			end

			addUnit(s)

			curSquads = curSquads + 1
			continue
		else
			addUnit(squads[sqd])
		end
	end

	for v,k in pairs(squads) do
		if not k.HasLeader and squad == v then
			k.claim = vgui.Create("DButton", k.Header)
			k.claim:SetText("CLAIM")
			k.claim:SetFont("DebugFixed")
			k.claim:SetPos(150, 0)
			k.claim:SetSize(90, 20)

			function k.claim:DoClick()
				net.Start("impulseSquadClaim")
				net.SendToServer()

				pdaSound()
			end
		end

		k:SetLabel(n.." "..k.squadId.."    ("..k.count.."/"..(lp:Team() == TEAM_CP and impulse.Config.MaxSquadSizeCP or impulse.Config.MaxSquadSizeOTA)..")")
	end

	self.make = vgui.Create("DButton", self)
	self.make:SetPos(10, 50)
	self.make:SetSize(340, 20)
	self.make:SetFont("DebugFixed")
	self.make:SetText("CREATE "..n.." ("..curSquads.."/"..(lp:Team() == TEAM_CP and impulse.Config.MaxSquadsCP or impulse.Config.MaxSquadsOTA)..")")

	if not lp:SquadCanMake() then
		self.make:SetDisabled(true)
	end

	function self.make:DoClick()
		net.Start("impulseSquadMake")
		net.SendToServer()

		pdaSound()
	end
end

function PANEL:PaintOver()
	local lp = LocalPlayer()
	local squad = lp:GetSyncVar(SYNC_SQUAD_ID)
	local isLeader = lp:GetSyncVar(SYNC_SQUAD_LEADER)
	local n = lp:Team() == TEAM_CP and "PT" or "SQUAD"

	if squad then
		draw.SimpleText("LOCAL "..n..": "..squad, "DebugFixed", 10, 30)
	else
		draw.SimpleText("AWAITING "..n.." ASSIGNMENT - SELECT BELOW:", "DebugFixed", 10, 30)
	end
end

function PANEL:Think()
	local t = LocalPlayer():Team()

	if t != TEAM_CP and t != TEAM_OTA then
		return self:Remove()
	end

	if not LocalPlayer():Alive() then
		return self:Remove()
	end
end

vgui.Register("impulsePDAMenu", PANEL, "DFrame")
