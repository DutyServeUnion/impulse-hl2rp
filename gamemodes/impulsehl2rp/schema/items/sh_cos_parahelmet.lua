local ITEM = {}

ITEM.UniqueID = "cos_parahelmet"
ITEM.Name = "Mk III Helmet"
ITEM.Desc =  "A British cold-war paratrooper helmet with a camo net attached for additional concealment."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/britisharmy/parahelmet1.mdl")
ITEM.FOV = 17.929799426934
ITEM.CamPos = Vector(33.237823486328, 25, 9)
ITEM.Weight = 3

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "head"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/britisharmy/parahelmet1.mdl"),
	femalePos = Vector(-0.3, 4.9, 0),
	pos = Vector(0.5, 5.9, 0),
	ang = Angle(0, 0, 270),
	scale = 1
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[7] = ITEM.CosmeticData

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, 7, true)
	ply.HasHelmet = true
end

function ITEM:UnEquip(ply)
	ply:SyncRemoveVar(SYNC_COS_HEAD, nil, true)
	ply.HasHelmet = false
end

impulse.RegisterItem(ITEM)
