local ITEM = {}

ITEM.UniqueID = "item_lockpick"
ITEM.Name = "Lockpick"
ITEM.Desc =  "Can be used to bypass the locks of most doors, with some skill."
ITEM.Category = "Tools"
ITEM.Model = Model("models/weapons/w_crowbar.mdl")
ITEM.FOV = 16.568767908309
ITEM.CamPos = Vector(-17.191976547241, 16.618911743164, 100)
ITEM.Weight = 0.5

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = true

ITEM.UseName = "Use"
ITEM.UseWorkBarTime = 6
ITEM.UseWorkBarName = "Lockpicking..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "weapons/357/357_reload1.wav"

function ITEM:OnUse(ply, door)
	local chance = math.random(1, 100)
	local skill = ply:GetSkillLevel("lockpick")

	if chance < (75 + ((skill * 2) * 1.4)) then
		if door:IsPlayer() and door:GetSyncVar(SYNC_ARRESTED, false) then
			door:UnArrest()
			door.JailEscaped = true
			door:Notify("You have been lockpicked out of your restraints by "..ply:Nick()..".")

			ply:EmitSound("weapons/357/357_reload4.wav")
			ply:AddSkillXP("lockpick", math.random(15, 25))
			ply:Notify("You lockpicked "..door:Nick().." out off their restraints.")

			door:AchievementGive("ach_greatescape")
			return
		end

		if door:IsPlayer() and door:Team() == TEAM_VORT and door:GetModel() == "models/vortigaunt_slave.mdl" then
			door:SetModel("models/vortigaunt.mdl")
			door:Notify("You have had your shackles removed by "..ply:Nick()..".")

			if door:HasWeapon("ls_broom") then
				door:StripWeapon("ls_broom")
			end
			
			ply:Notify("You lockpicked "..door:Nick().." out of their shackles.")
			return
		end

		if door:IsPropDoor() then
			door:Fire("open", "", 0)
            door:Fire("setanimation", "open", 0)
        else
        	door:Fire("unlock", "", 0)
		end

		door:EmitSound("doors/latchunlocked1.wav")

	    ply:EmitSound("weapons/357/357_reload4.wav")
		ply:Notify("You have successfully lockpicked the door.")
		ply:AddSkillXP("lockpick", math.random(15, 25))
	else
		ply:EmitSound("weapons/357/357_reload3.wav")
		ply:Notify("The lockpick broke.")
		ply:AddSkillXP("lockpick", math.random(45, 65))

		return true
	end
end

function ITEM:ShouldTraceUse(ply, ent)
    if ent:IsPropDoor() then
        return true
    end
    
    if ent:IsPlayer() and ent:GetSyncVar(SYNC_ARRESTED, false) then
    	return true
    end

    if ent:IsPlayer() and ent:GetModel() == "models/vortigaunt_slave.mdl" then
    	return true
    end

	if not ent:IsDoor() then
		return false
	end

	local group = ent:GetSyncVar(SYNC_DOOR_GROUP, nil)

	if not ent:GetSyncVar(SYNC_DOOR_BUYABLE, true) and not group then
		return false
	end 

	if (group == 1 or group == 2) then
		if ent:GetClass() == "func_door" then
			return false
		else
			return true
		end
	elseif SERVER and (not ent:GetSyncVar(SYNC_DOOR_BUYABLE, true) and not ent.IsApartmentDoor) then
		return false
	end

	return true
end

impulse.RegisterItem(ITEM)
