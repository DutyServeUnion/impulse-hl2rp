local ITEM = {}

ITEM.UniqueID = "ammo_357"
ITEM.Name = "357. Ammunition"
ITEM.Desc =  "Large, powerful ammunition that can be loaded into revolvers."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/357ammo.mdl")
ITEM.FOV = 11.396848137536
ITEM.CamPos = Vector(-24.068767547607, 59.025787353516, 20.630373001099)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(6, "357")
	return true
end

impulse.RegisterItem(ITEM)
