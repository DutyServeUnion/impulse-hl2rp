local ITEM = {}

ITEM.UniqueID = "item_syringe"
ITEM.Name = "Flu Immuniser Syringe"
ITEM.Desc =  "A syringe contaning one dose of flu immuniser."
ITEM.Category = "Medical"
ITEM.Model = Model("models/hitman6/syringemodern.mdl")
ITEM.FOV = 2.4212034383954
ITEM.CamPos = Vector(-138.45272827148, 110.94555664063, 9)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.Medical = true
ITEM.MedicalTreatments = {
	["antibacteria"] = {TwoWayBed = true, Skill = 0, Time = 1.5, Power = 50, PowerTime = 120}
}

impulse.RegisterItem(ITEM)
