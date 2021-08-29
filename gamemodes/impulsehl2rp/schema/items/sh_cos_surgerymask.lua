local ITEM = {}

ITEM.UniqueID = "cos_surgerymask"
ITEM.Name = "Surgery Mask"
ITEM.Desc =  "A basic dust mask that can protect the wearer against germs."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/dean/gtaiv/mask.mdl")
ITEM.FOV = 25
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "face"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/dean/gtaiv/mask.mdl"),
	pos = Vector(1.3, 0, 0),
	ang = Angle(0, -90, 270),
	scale = 1,
	femalePos = Vector(1.3, -0.9, 0)
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[5] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 5, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
end

impulse.RegisterItem(ITEM)
