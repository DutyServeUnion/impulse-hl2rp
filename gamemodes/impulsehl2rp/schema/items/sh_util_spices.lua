local ITEM = {}

ITEM.UniqueID = "util_spices"
ITEM.Name = "Bag of Spices"
ITEM.Desc = "A bag containing a mix of spices."
ITEM.Model = Model("models/gibs/props_canteen/vm_sneckol.mdl")
ITEM.FOV = 25
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Pour into barrel"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Mixing spices..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "impulse/craft/powder/1.wav"

function ITEM:OnUse(ply, barrel)
    if barrel:AddIngredient("Spices") then
        return true
    else
        ply:Notify("You are unable to add more spices.")
    end
end

function ITEM:ShouldTraceUse(ply, ent)
    return ent:GetClass() == "impulse_hl2rp_brewingbarrel" and ent:GetEndTime() == 0
end

impulse.RegisterItem(ITEM)
