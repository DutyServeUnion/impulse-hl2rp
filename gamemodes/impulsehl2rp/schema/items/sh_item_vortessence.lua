local ITEM = {}

ITEM.UniqueID = "item_vortessence"
ITEM.Name = "Vortessence"
ITEM.Desc =  "A small nugget containing vortessence, said to induce supernatural powers to those that wield it."
ITEM.Category = "Tools"
ITEM.Model = Model("models/spitball_medium.mdl")
ITEM.ItemColour = Color(144, 0, 255)
ITEM.FOV = 15.338108882521
ITEM.CamPos = Vector(-10, 25, 9)
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Use"

function ITEM:OnUse(ply, door)
	if ply:Team() != TEAM_VORT then
		ply:Notify("You are not sure how to use this...")
		return false
	end

	if ply:GetModel() == "models/vortigaunt_slave.mdl" then
		ply:Notify("Your shackles prevent you from being able to harness the powers of the Vortessence.")
		return false
	end

	if ply.UsedVortessence then
		ply:Notify("You have already used the vortessence.")
		return false
	end

	ply.UsedVortessence = true
	ply:SetModel("models/vortiblue1.mdl")

	net.Start("impulseHL2RPVortessenceStart")
	net.Send(ply)

	timer.Simple(impulse.Config.VortessenceTime, function()
		if not IsValid(ply) then
			return
		end

		ply.UsedVortessence = false

		if ply:Team() != TEAM_VORT then
			return
		end

		if ply:GetModel() != "models/vortiblue1.mdl" then
			return
		end

		ply:SetModel("models/vortigaunt.mdl")
		ply:Notify("The effects of the vortessence have worn off...")
	end)

	return true
end

impulse.RegisterItem(ITEM)
