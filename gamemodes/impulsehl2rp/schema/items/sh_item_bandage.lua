local ITEM = {}

ITEM.UniqueID = "item_bandage"
ITEM.Name = "Bandage"
ITEM.Desc =  "Can be used to stop bleeding."
ITEM.Category = "Medical"
ITEM.Model = Model("models/warz/items/bandage.mdl")
ITEM.FOV = 13.574498567335
ITEM.CamPos = Vector(-2.8653295040131, 25, 10.888252258301)
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Bandage"
ITEM.UseWorkBarTime = 3
ITEM.UseWorkBarName = "Bandaging..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "items/smallmedkit1.wav"

function ITEM:OnUse(ply, target)
	ply:Notify("placeholder")
	return true
end

impulse.RegisterItem(ITEM)
