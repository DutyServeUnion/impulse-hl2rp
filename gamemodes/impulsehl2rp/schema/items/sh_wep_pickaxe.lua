local ITEM = {}

ITEM.UniqueID = "wep_pickaxe"
ITEM.Name = "Pickaxe"
ITEM.Desc = "A old wooden pickaxe, can be used to mine various metals."
ITEM.Category = "Weapons"
ITEM.Model = Model("models/props_mining/pickaxe01.mdl")
ITEM.FOV = 49.777936962751
ITEM.CamPos = Vector(44.126075744629, 22.349569320679, 14.326647758484)
ITEM.NoCenter = true
ITEM.Weight = 4.5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = true
ITEM.CraftIfRestricted = false

ITEM.Illegal = true
ITEM.Equipable = true
ITEM.EquipGroup = "melee"
ITEM.CanStack = false

ITEM.WeaponClass = "ls_pickaxe"

impulse.RegisterItem(ITEM)
