local ITEM = {}

ITEM.UniqueID = "item_camerarepairkit"
ITEM.Name = "Camera Repair Kit"
ITEM.Desc =  "This kit contains replacement parts and tools to repair damaged surveillance cameras."
ITEM.Category = "Tools"
ITEM.Model = Model("models/combine_turrets/floor_turret_gib1.mdl")
ITEM.FOV = 20.379656160458
ITEM.CamPos = Vector(-57.306591033936, -25.21489906311, 8.5959882736206)
ITEM.NoCenter = true
ITEM.Weight = 3.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Repair nearby broken cameras"

function ITEM:OnUse(ply)
	local pos = ply:GetPos()

    for v,k in pairs(ents.FindByClass("npc_combine_camera")) do
    	if not k:IsCameraEnabled() and k:GetPos():DistToSqr(pos) < (500 ^ 2) then
    		ply:EmitSound("ambient/energy/weld2.wav")
            ply:Notify("You have repaired a broken camera.")

    		k:RepairCombineCamera()
    		return true
    	end
    end

    ply:Notify("No broken cameras found nearby.")
	return false
end

impulse.RegisterItem(ITEM)
