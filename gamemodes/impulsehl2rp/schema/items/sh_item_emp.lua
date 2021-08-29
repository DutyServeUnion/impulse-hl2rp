local ITEM = {}

ITEM.UniqueID = "item_emp"
ITEM.Name = "EMP Tool"
ITEM.Desc =  "Can be used to bypass combine technology and defensive doors."
ITEM.Category = "Tools"
ITEM.Model = Model("models/weapons/w_emptool.mdl")
ITEM.FOV = 17.113180515759
ITEM.CamPos = Vector(-10, 25, 9)
ITEM.NoCenter = true
ITEM.Weight = 0.6

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.UseName = "Use on door"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Overloading..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "ambient/energy/weld1.wav"

function ITEM:OnUse(ply, door)
	local chance = math.random(1, 10)

	if chance > 5 then
		door:Fire("open")
	    ply:EmitSound("buttons/combine_button1.wav")
		ply:Notify("You have successfully overloaded the door.")
	else
		ply:EmitSound("ambient/energy/zap1.wav")
		ply:Notify("The EMP attempt failed.")
	end
end

function ITEM:ShouldTraceUse(ply, ent)
	return ent:GetClass() == "func_door" and (ent:GetSyncVar(SYNC_DOOR_GROUP) == 1 or ent:GetSyncVar(SYNC_DOOR_GROUP) == 2)
end

impulse.RegisterItem(ITEM)
