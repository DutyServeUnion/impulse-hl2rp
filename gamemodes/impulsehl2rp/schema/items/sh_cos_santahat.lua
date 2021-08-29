local ITEM = {}

ITEM.UniqueID = "cos_santahat"
ITEM.Name = "Santa Hat"
ITEM.Desc =  "It's that time of the year again!"
ITEM.Colour = Color(235, 3, 0)
ITEM.Category = "Clothing"
ITEM.Model = Model("models/cloud/kn_santahat.mdl")
ITEM.FOV = 6.769340974212
ITEM.CamPos = Vector(-100, -77.936965942383, 0.57306587696075)
ITEM.NoCenter = true
ITEM.Weight = 0

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "head"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/cloud/kn_santahat.mdl"),
	pos = Vector(0, -1, 0),
	ang = Angle(-90, 0, 90),
	scale = 1,
	femalePos = Vector(0.4, -2.1, 0),
	femaleScale = 1.05,
	teamCustomPos = {
		[TEAM_CP] = Vector(0, -2, 0),
		[TEAM_OTA] = Vector(-1.5, -1, 0)
	},
	teamCustomScale = {
		[TEAM_CP] = 1.2,
		[TEAM_OTA] = 1.2
	}
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[6] = ITEM.CosmeticData

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, 6, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, nil, true)
end

impulse.RegisterItem(ITEM)
