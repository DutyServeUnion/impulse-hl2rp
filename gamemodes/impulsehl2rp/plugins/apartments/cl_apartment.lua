surface.CreateFont("ApartmentDoorFont", {
    font = "BodoniXT",
    size = 30,
    weight = 800,
    antialias = true,
    shadow = true,
})

local textColor = Color(127, 89, 53, 255)
local doorCache
local ent = Entity
local isValid = IsValid
local cam = cam
local drawSimpleText = draw.SimpleText

hook.Add("PostDrawOpaqueRenderables", "ApartmentsDraw", function()
    if !impulse.ApartmentBlocks then 
        return 
    end

    if not doorCache then
        doorCache = {}
        for v,k in pairs(impulse.ApartmentBlocks) do
            for a,b in pairs(k.apartments) do
                if !isnumber(b.doors[1]) then continue end
                local door = b.doors[1]

                doorCache[door] = b.name
            end
        end
    end
    
    for v,k in pairs(doorCache) do
        local door = ent(v)
        local name = k

        if !isValid(door) or door.GetNoDraw(door) then 
            continue 
        end

        local doorPos = door.GetPos(door)
        local doorAng = door.GetAngles(door)

        local pos = door.GetPos(door)
        local ang = door.GetAngles(door)

        pos = pos + ang.Forward(ang) * 2
        pos = pos + ang.Right(ang) * -23
        pos = pos + ang.Up(ang) * 25

        ang.RotateAroundAxis(ang, doorAng.Up(doorAng), 90)
        ang.RotateAroundAxis(ang, doorAng.Right(doorAng), -90)

        cam.Start3D2D(pos, ang, 0.2)
            --surface.SetDrawColor(textColor)
            drawSimpleText(name, "ApartmentDoorFont", 0, 0, textColor, TEXT_ALIGN_CENTER)
        cam.End3D2D()

        ang.RotateAroundAxis(ang, doorAng.Right(doorAng), 180)
        ang.RotateAroundAxis(ang, doorAng.Forward(doorAng), 180)

        pos = pos + ang.Up(ang) * 3.1

        cam.Start3D2D(pos, ang, 0.2)
            drawSimpleText(name, "ApartmentDoorFont", 0, 0, textColor, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end)

