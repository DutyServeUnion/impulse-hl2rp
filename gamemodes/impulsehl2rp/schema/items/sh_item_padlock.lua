local ITEM = {}

ITEM.UniqueID = "item_padlock"
ITEM.Name = "Padlock"
ITEM.Desc =  "Can be used to secure containers with a passcode."
ITEM.Category = "Tools"
ITEM.Model = Model("models/props_wasteland/prison_padlock001a.mdl")
ITEM.FOV = 27.457020057307
ITEM.CamPos = Vector(-10, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.UseName = "Use on container"

function ITEM:OnUse(ply, ent)
	net.Start("impulseInvContainerSetCode")
	net.Send(ply)

	ply.ContainerCodeSet = ent
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:GetClass() == "impulse_container" and ent:CPPIGetOwner() == ply 
end

impulse.RegisterItem(ITEM)
