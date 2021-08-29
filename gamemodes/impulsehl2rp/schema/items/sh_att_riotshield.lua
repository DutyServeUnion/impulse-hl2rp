local ITEM = {}

ITEM.UniqueID = "att_riotshield"
ITEM.Name = "Riot Shield"
ITEM.Desc =  "A tough polymer shield that can be used alongside a stun baton to provide additional protection."
ITEM.Category = "Attachments"
ITEM.Model = Model("models/bshields/rshield.mdl")
ITEM.FOV = 15.899713467049
ITEM.CamPos = Vector(-76.103149414063, 147.62178039551, -117.24928283691)
ITEM.Weight = 3

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee_attachment"
ITEM.CanStack = false

ITEM.AttachmentClass = "riot_shield"

impulse.RegisterItem(ITEM)
