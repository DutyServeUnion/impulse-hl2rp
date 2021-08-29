local ITEM = {}

ITEM.UniqueID = "item_turret"
ITEM.Name = "Emplacement Turret"
ITEM.Desc =  "A tall defensive eplacement turret. Has a short battery life."
ITEM.Category = "Tools"
ITEM.Model = Model("models/combine_turrets/floor_turret.mdl")
ITEM.FOV = 19.269340974212
ITEM.CamPos = Vector(-160, 159.54154968262, 34.040115356445)
ITEM.NoCenter = true
ITEM.Weight = 8

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.DropIfRestricted = false
ITEM.DropOnDeathIfRestricted = false
ITEM.CraftIfRestricted = false

ITEM.UseName = "Deploy"

function ITEM:OnUse(ply)
    local trace = {}
    trace.start = ply:EyePos()
    trace.endpos = trace.start + ply:GetAimVector() * 85
    trace.filter = ply

    local tr = util.TraceLine(trace)

    if IsValid(tr.Entity) then
        ply:Notify("You can't deploy the turret here.")
        return false
    end

    if not ply:OnGround() then
        return false
    end

    ply:ForceSequence("deploy", function()
        if not IsValid(ply) then
            return
        end

        local m = ents.Create("npc_turret_floor")
        m:SetPos(tr.HitPos)
        m:SetAngles(ply:EyeAngles())
        m:SetOwner(ply)
        m:Spawn()
        m:Activate()

        m:CallOnRemove("turretCleaner", function()
            if IsValid(ply) then
                ply.activeTurret = nil
            end
        end)

        m:AddRelationship("player D_NU 99") -- be nice by default :)

        ply.activeTurret = m

        local sid = ply:SteamID()
        local endTime = CurTime() + impulse.Config.ManhackTime
        timer.Create("impulseTurretThink"..sid, 1, 0, function()
            if not IsValid(m) then
                timer.Remove("impulseTurretThink"..sid)
                return
            end

            if not IsValid(ply) or ply:Team() != TEAM_CP then
                timer.Remove("impulseTurretThink"..sid)
                m:Remove()
                return
            end

            if endTime < CurTime() then
                timer.Remove("impulseTurretThink"..sid)
                m:Remove()

                if IsValid(ply) then
                    ply:Notify("Your Turret's charge has expired.")
                end

                return
            end

            if IsValid(m.mainTarget) then
                if m.mainTarget:IsPlayer() and m.mainTarget:IsCP() then
                    return
                end

                m:AddEntityRelationship(m.mainTarget, D_HT, 200) -- hate ppl
                m:SetTarget(m.mainTarget)

                if m.mainTarget:IsPlayer() and not m.mainTarget:Alive() then
                    m:AddEntityRelationship(m.mainTarget, D_NU, 300)
                    m.mainTarget = nil
                    return
                end

                local dist = m.mainTarget:GetPos():DistToSqr(m:GetPos())

                if dist > 2000 then
                    m.mainTarget = nil
                end
            end
        end)
    end)

    ply:Notify("You have deployed a turret.")

    return true
end

impulse.RegisterItem(ITEM)
