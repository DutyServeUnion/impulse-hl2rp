local ITEM = {}

ITEM.UniqueID = "item_antibiotics"
ITEM.Name = "Anti-Biotics"
ITEM.Desc =  "A small plastic capsule contaning anti-biotic pills. Able to cure infections."
ITEM.Category = "Medical"
ITEM.Model = Model("models/warz/consumables/medicine.mdl")
ITEM.FOV = 5
ITEM.CamPos = Vector(42.406875610352, -5.7306590080261, 12.607449531555)
ITEM.NoCenter = true
ITEM.Weight = 0.2

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.Medical = true
ITEM.MedicalTreatments = {
	["antibacteria"] = {TwoWayBed = true, Skill = 0, Time = 1.5, Power = 50, PowerTime = 120}
}

impulse.RegisterItem(ITEM)
