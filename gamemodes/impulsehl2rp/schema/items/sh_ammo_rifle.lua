local ITEM = {}

ITEM.UniqueID = "ammo_rifle"
ITEM.Name = "Rifle Ammunition"
ITEM.Desc =  "A box full of large rounds that can penetrate armour, commonly used in heavier weapons."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/boxmrounds.mdl")
ITEM.FOV = 47.600286532951
ITEM.CamPos = Vector(-10.888252258301, 26.934097290039, 16.618911743164)
ITEM.NoCenter = true
ITEM.Weight = 1.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(45, "Rifle")
	return true
end

impulse.RegisterItem(ITEM)
