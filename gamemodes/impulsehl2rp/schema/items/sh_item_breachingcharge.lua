local ITEM = {}

ITEM.UniqueID = "item_breachingcharge"
ITEM.Name = "Breaching Charge"
ITEM.Desc =  "Can blow open doors."
ITEM.Model = Model("models/weapons/w_slam.mdl")
ITEM.FOV = 14.93553008596
ITEM.CamPos = Vector(-8.5959882736206, 21.203437805176, 33.237823486328)
ITEM.Weight = 2
ITEM.Category = "Tools"

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.UseName = "Place charge"
ITEM.UseWorkBarTime = 4
ITEM.UseWorkBarName = "Planting charge..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "weapons/slam/mine_mode.wav"


function ITEM:OnUse(ply, door)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

    local tr = util.TraceLine(trace)
	local traceEnt = tr.Entity
    
    
    if not traceEnt == door then return end

    if door.IsCharged then
        return
    end

    door.IsCharged = true

    local chargeProp = ents.Create("prop_dynamic")
    if not IsValid(chargeProp) then return end
    chargeProp:SetParent(door)
    chargeProp:SetModel("models/weapons/w_slam.mdl")
    chargeProp:SetCollisionGroup(COLLISION_GROUP_WORLD)
    chargeProp:SetPos(tr.HitPos)
    
    if chargeProp:GetLocalPos().x > 0 then
		chargeProp:SetLocalPos(chargeProp:GetLocalPos() + Vector(1.5,0,0))
	end
			
	if chargeProp:GetLocalPos().x < 0 then
		chargeProp:SetLocalPos(chargeProp:GetLocalPos() + Vector(-1.5,0,0))
	end
						
	if chargeProp:GetLocalPos().x > 0 then
		chargeProp:SetAngles( door:GetAngles() + Angle(-270,0,0))
	end
			
	if chargeProp:GetLocalPos().x < 0 then
		chargeProp:SetAngles( door:GetAngles() + Angle(270,0,0))
	end

    
    chargeProp:EmitSound("weapons/c4/c4_plant.wav")

    local playerPos = ply:GetPos()
    local originDir = ply:GetForward()

    timer.Simple(4, function()
        timer.Create("impulseHL2RPSlowChargeExplosionSoundTimer" .. chargeProp:EntIndex(), 0.25, 16, function()
            if not IsValid(chargeProp) then return end
            chargeProp:EmitSound("weapons/c4/c4_click.wav")
        end)
    end)

    timer.Simple(8, function()
        timer.Create("impulseHL2RPFastChargeExplosionSoundTimer" .. chargeProp:EntIndex(), 0.15, 6, function()
            if not IsValid(chargeProp) then return end
            chargeProp:EmitSound("weapons/c4/c4_click.wav")
        end)


        timer.Simple(0.15 * 6, function()
            if not IsValid(chargeProp) then
                return
            end
            
            local explodeEnt = ents.Create("env_explosion")
            explodeEnt:SetPos(chargeProp:GetPos())
            explodeEnt:Spawn()
            explodeEnt:Fire("explode", "", 0)

            chargeProp:Remove()

            if not IsValid(door) then return end

            if door:IsPropDoor() then
                door:Fire("open", "", .6)
                door:Fire("setanimation", "open", .6)
            else
                door:SetNotSolid(true)
                door:SetNoDraw(true)
                -- Attempt to fix PVS problems.
                door:DoorUnlock()
                door:Fire("open", "", 0.6)
                door:Fire("lock", "", 1.2)

                if door:GetClass() == "prop_door_rotating" then
                    local fakeDoor = ents.Create("prop_physics")
                    if IsValid(fakeDoor) and IsValid(door) then
                        fakeDoor:SetModel(door:GetModel())
                        fakeDoor:SetPos(door:GetPos())
                        fakeDoor:SetAngles(door:GetAngles())
                        fakeDoor:SetSkin(door:GetSkin())
                        fakeDoor:SetCollisionGroup(COLLISION_GROUP_WORLD)

                        fakeDoor:Spawn()

                        fakeDoor:GetPhysicsObject():SetVelocity(playerPos + originDir * 10000)

                        timer.Simple(impulse.Config.ExplosionDoorRespawnTime, function()
                            if IsValid(fakeDoor) then
                                fakeDoor:Remove()
                            end
                        end)
                    end
                end

                timer.Simple(impulse.Config.ExplosionDoorRespawnTime, function()
                    if not IsValid(door) then return end
                    door:DoorUnlock()
                    door:SetNotSolid(false)
                    door:SetNoDraw(false)

                    door.IsCharged = false
                end)
            end
        end)
    end)

    return true
end

function ITEM:ShouldTraceUse(ply, ent)
    if ent:IsPropDoor() then
        return true
    end

    if not ent:IsDoor() then 
        return false 
    end

    if (ent:GetSyncVar(SYNC_DOOR_GROUP) == 1 or ent:GetSyncVar(SYNC_DOOR_GROUP) == 2) then
        return false
	end

	if ent:GetSyncVar(SYNC_DOOR_BUYABLE, true) or ent:IsApartmentDoor() then
        return true
    else
        return false
    end
end

impulse.RegisterItem(ITEM)
