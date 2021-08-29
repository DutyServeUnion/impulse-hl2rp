local ITEM = {}

ITEM.UniqueID = "testitem"
ITEM.Name = "Vin's Test Item"
ITEM.Desc =  "A hidden item used to test the inventory system."
ITEM.Model = Model("models/props_lab/huladoll.mdl")
ITEM.FOV = 18
ITEM.Weight = 2

ITEM.Colour = Color(255, 0, 0)

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "hat"
ITEM.CanStack = true

ITEM.WorldInteractor = true
ITEM.Placeable = false
ITEM.UseByDrag = true
ITEM.PlayersOnly = true

ITEM.UseTime = 50
ITEM.FreezeOwnerOnUse = true

function ITEM:OnEquip(ply)

end

function ITEM:CanUse(owner, userEnt)

end

function ITEM:OnUse(ply)

end

function ITEM:OnDrop(ply, ent)

end

function ITEM:OnReload(ply)

end

ITEM.CustomActions = {}
ITEM.CustomActions["Reload"] = ITEM.OnReload

impulse.RegisterItem(ITEM)
