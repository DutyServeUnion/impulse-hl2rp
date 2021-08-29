local ITEM = {}

ITEM.UniqueID = "ammo_buckshot"
ITEM.Name = "Buckshot Ammunition"
ITEM.Desc =  "A box contaning large buckshot rounds. Can be loaded into most shotguns."
ITEM.Category = "Ammo"
ITEM.Model = Model("models/items/boxbuckshot.mdl")
ITEM.FOV = 39.434097421203
ITEM.CamPos = Vector(-10.315186500549, 21.203437805176, 10.315186500549)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Load"

function ITEM:OnUse(ply)
	ply:GiveAmmo(12, "Buckshot")
	return true
end

impulse.RegisterItem(ITEM)
