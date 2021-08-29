local ITEM = {}

ITEM.UniqueID = "util_yeast"
ITEM.Name = "Bag of Yeast"
ITEM.Desc = "A bag containing yeast."
ITEM.Model = Model("models/props_junk/garbage_bag001a.mdl")
ITEM.FOV = 33.17335243553
ITEM.CamPos = Vector(-1.1461317539215, 2.292263507843, 33.237823486328)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Pour into barrel"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Mixing yeast..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "impulse/craft/powder/3.wav"

function ITEM:OnUse(ply, barrel)
    if barrel:AddIngredient("Yeast") then
        return true
    else
        ply:Notify("You are unable to add more yeast.")
    end
end

function ITEM:ShouldTraceUse(ply, ent)
    return ent:GetClass() == "impulse_hl2rp_brewingbarrel" and ent:GetEndTime() == 0
end

impulse.RegisterItem(ITEM)
