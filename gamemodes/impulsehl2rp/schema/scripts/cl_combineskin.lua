local SKIN = {}
SKIN.fontFrame = "BudgetLabel"
SKIN.fontTab = "BudgetLabel"
SKIN.fontButton = "BudgetLabel"
SKIN.fontCategoryHeader = "BudgetLabel"
SKIN.Colours = table.Copy(derma.SkinList.Default.Colours)
SKIN.Colours.Window.TitleActive = Color(0, 0, 0)
SKIN.Colours.Window.TitleInactive = Color(255, 255, 255)

SKIN.Colours.Button.Normal = Color(255, 255, 255, 255)
SKIN.Colours.Button.Hover = Color(255, 255, 255)
SKIN.Colours.Button.Down = Color(251, 197, 49)
SKIN.Colours.Button.Disabled = Color(0, 0, 0, 100)
SKIN.Colours.Label.Dark = SKIN.Colours.Label.Bright

function SKIN:PaintFrame(panel)
	surface.SetDrawColor(0, 0, 0, 195)
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

	surface.SetDrawColor(Color(47, 54, 64))
	surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())
end

function SKIN:DrawGenericBackground(x, y, w, h)
	surface.SetDrawColor(45, 45, 45, 240)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawOutlinedRect(x, y, w, h)

	surface.SetDrawColor(100, 100, 100, 25)
	surface.DrawOutlinedRect(x + 1, y + 1, w - 2, h - 2)
end

function SKIN:PaintPanel(panel)
	if (panel:GetPaintBackground()) then
		local w, h = panel:GetWide(), panel:GetTall()

		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
end

function SKIN:PaintButton(panel)
	if (panel:GetPaintBackground()) then
		local w, h = panel:GetWide(), panel:GetTall()
		local alpha = 50

		if (panel:GetDisabled()) then
			alpha = 10
		elseif (panel.Depressed) then
			alpha = 180
		elseif (panel.Hovered) then
			alpha = 75
		end

		surface.SetDrawColor(39, 60, 117, alpha)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(180, 180, 180, 2)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
	end
end

function SKIN:PaintListViewLine(panel, w, h)
	if ( panel:IsSelected() ) then
		surface.SetDrawColor(39, 60, 117, 130)
		surface.DrawRect(0, 0, w, h)
	elseif ( panel.Hovered ) then
		self.tex.Input.ListBox.Hovered( 0, 0, w, h )
	elseif ( panel.m_bAlt ) then
		self.tex.Input.ListBox.EvenLine( 0, 0, w, h )
	end
end

function SKIN:PaintListView(panel, w, h)
	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawRect(0, 0, w, h)
end

-- I don't think we gonna need minimize button and maximize button.
function SKIN:PaintWindowMinimizeButton(panel, w, h)
end

function SKIN:PaintWindowMaximizeButton(panel, w, h)
end

local closeCol = Color(255, 20, 20, 255)
function SKIN:PaintWindowCloseButton(panel, w, h)
	draw.SimpleText("X", "BudgetLabel", 5, 5, closeCol, 0, 0)
end

derma.DefineSkin("combine", "A combine themed skin for impulse Half-Life 2 Roleplay.", SKIN)
derma.RefreshSkins()
