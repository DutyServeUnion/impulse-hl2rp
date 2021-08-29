local ITEM = {}

ITEM.UniqueID = "ammo_smg"
ITEM.Name = "SMG Ammunition"
ITEM.Desc =  "A box full of small rounds that can be used in light automatic weapons."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/boxmrounds.mdl")
ITEM.FOV = 47.600286532951
ITEM.CamPos = Vector(-10.888252258301, 26.934097290039, 16.618911743164)
ITEM.NoCenter = true
ITEM.Weight = 0.8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(45, "SMG1")
	return true
end

impulse.RegisterItem(ITEM)
