local ITEM = {}

ITEM.UniqueID = "cos_fishcap"
ITEM.Name = "Fisherman's Cap"
ITEM.Desc =  "A brown flat-cap commonly worn by the Mysterious Fisherman."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/sirgibs/ragdolls/hl2/fisherman_hat.mdl")
ITEM.FOV = 2
ITEM.CamPos = Vector(-8.2521486282349, 7.3352437019348, 431.17477416992)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = true
ITEM.Permanent = true

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "head"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/sirgibs/ragdolls/hl2/fisherman_hat.mdl"),
	pos = Vector(0.5, -64.45, 0),
	ang = Angle(0, -90, 270),
	scale = 1.05,
	femalePos = Vector(0.7, -55, 0),
	femaleScale = 0.9
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[8] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, 8, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_HEAD, nil, true)
end

impulse.RegisterItem(ITEM)
