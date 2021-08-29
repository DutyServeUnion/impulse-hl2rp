local ITEM = {}

ITEM.UniqueID = "ammo_pistol"
ITEM.Name = "Pistol Ammunition"
ITEM.Desc =  "Small, compact ammunition that can be loaded into most pistols."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/boxsrounds.mdl")
ITEM.FOV = 30.179083094556
ITEM.CamPos = Vector(-13.753582000732, 36.676216125488, 17.191976547241)
ITEM.NoCenter = true
ITEM.Weight = 0.8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(20, "Pistol")
	return true
end

impulse.RegisterItem(ITEM)
