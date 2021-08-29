local ITEM = {}

ITEM.UniqueID = "cos_riothelmet"
ITEM.Name = "Riot Helmet"
ITEM.Desc =  "A standard issue riot helmet. Can protect against melee attacks and thrown objects. Reinforced polymer visor attached."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/bloocobalt/fo3/vaulttech/101-security_helmet.mdl")
ITEM.FOV = 7.8581661891117
ITEM.CamPos = Vector(-83.667625427246, 33.237823486328, -13.753582000732)
ITEM.NoCenter = true
ITEM.Weight = 2

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "head"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/bloocobalt/fo3/vaulttech/101-security_helmet.mdl"),
	pos = Vector(1, 0.6, 0),
	ang = Angle(0, -90, 270),
	scale = 1,
	matrixScale = Vector(1.25, 1.05, 1.15),
	bodygroups = "01"
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[2] = ITEM.CosmeticData

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, 2, true)
end

function ITEM:UnEquip(ply)
	ply:SyncRemoveVar(SYNC_COS_HEAD, nil, true)
end

impulse.RegisterItem(ITEM)
