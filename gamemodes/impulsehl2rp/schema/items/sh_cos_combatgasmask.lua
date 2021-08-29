local ITEM = {}

ITEM.UniqueID = "cos_combatgasmask"
ITEM.Name = "Combat Gas Mask"
ITEM.Desc =  "A full face gas mask used to protect the wearer from toxic gases."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/tnb/items/gasmask.mdl")
ITEM.FOV = 12.213467048711
ITEM.CamPos = Vector(46.418338775635, 20.630373001099, 32.091690063477)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "face"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/tnb/items/gasmask.mdl"),
	pos = Vector(2.75, -1, 0),
	ang = Angle(25, 0, 270),
	scale = 1.1,
	femalePos = Vector(2.75, -1.1, 0),
	femaleScale = 1
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[1] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 1, true)
	ply.GasSafe = true
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
	ply.GasSafe = false
end

impulse.RegisterItem(ITEM)
