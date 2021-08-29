local ITEM = {}

ITEM.UniqueID = "att_huntingscope"
ITEM.Name = "Hunting Scope"
ITEM.Desc =  "A magnifnied hunting sight, increases weapon range and damage."
ITEM.Category = "Attachments"
ITEM.Model = Model("models/props_lab/box01a.mdl")
ITEM.FOV = 20.392550143266
ITEM.CamPos = Vector(22.005731582642, 25, 9)
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "primary_attachment"
ITEM.CanStack = false

ITEM.AttachmentClass = "hunting_scope"

impulse.RegisterItem(ITEM)
