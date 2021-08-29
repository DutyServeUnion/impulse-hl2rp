local ITEM = {}

ITEM.UniqueID = "cos_chefhat"
ITEM.Name = "Chef Hat"
ITEM.Desc =  "The chef's hat. Tall and fluffy!"
ITEM.Category = "Clothing"
ITEM.Model = Model("models/chefhat.mdl")
ITEM.FOV = 4.9484240687679
ITEM.CamPos = Vector(160, -38.510028839111, 7.5644698143005)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = false
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "head"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/chefhat.mdl"),
	pos = Vector(-0.85, 5.4, 0),
	ang = Angle(5, 90, 270),
	scale = 0.95,
	femalePos = Vector(0.7, -55, 0),
	femaleScale = 0.9
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[10] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, 10, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, nil, true)
end

impulse.RegisterItem(ITEM)
