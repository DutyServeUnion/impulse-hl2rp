local ITEM = {}

ITEM.UniqueID = "ammo_ar2"
ITEM.Name = "AR2 Ammunition"
ITEM.Desc =  "A cartridge for use in the AR-2 pulse rifle."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/combine_rifle_cartridge01.mdl")
ITEM.FOV = 18.988538681948
ITEM.CamPos = Vector(25.67335319519, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 1.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(60, "AR2")
	return true
end

impulse.RegisterItem(ITEM)
