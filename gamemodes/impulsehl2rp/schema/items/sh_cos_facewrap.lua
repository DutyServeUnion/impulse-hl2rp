local ITEM = {}

ITEM.UniqueID = "cos_facewrap"
ITEM.Name = "Face Wrap"
ITEM.Desc =  "A black face wrap made out of cloth. Can be used to hide your identity."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/sal/halloween/ninja.mdl")
ITEM.FOV = 34
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "face"
ITEM.CanStack = false

ITEM.CosmeticData = {
	model = Model("models/sal/halloween/ninja.mdl"),
	pos = Vector(0.5, 2, -0.2),
	ang = Angle(0, -90, 270),
	scale = 1,
	femalePos = Vector(0.5, 0.8, -0.2),
	onEntLoad = function(ply, ent)
		if ply:GetSyncVar(SYNC_TROPHYPOINTS, 0) >= 1100 then
			ent:SetSkin(5)
		end
	end
}

impulse.Cosmetics = impulse.Cosmetics or {} -- register cosmetic into impulse
impulse.Cosmetics[4] = ITEM.CosmeticData

function ITEM:CanEquip(ply)
	return not ply:IsCP()
end

function ITEM:OnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, 4, true)
end

function ITEM:UnEquip(ply)
	ply:SetSyncVar(SYNC_COS_FACE, nil, true)
end

impulse.RegisterItem(ITEM)
