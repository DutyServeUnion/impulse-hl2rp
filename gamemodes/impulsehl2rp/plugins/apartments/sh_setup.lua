function impulse.LoadApartments()
    impulse.ApartmentBlocks = impulse.ApartmentBlocks or {}
    impulse.ApartmentDoors = impulse.ApartmentDoors or {}

    -- EXPLANATION :
    -- This copies over the apartments from the config file to the object oriented approach
    -- in the live environment. 
    
    for v,k in pairs(impulse.Config.ApartmentBlocks) do
        table.insert(impulse.ApartmentBlocks, ApartmentBlock(k.name))
        for a,b in pairs(impulse.Config.ApartmentBlocks[v].apartments) do
            table.insert(impulse.ApartmentBlocks[v].apartments, Apartment(b.name, b.rent))
            for c,d in pairs(b.doors) do
                local doorIndex = d + game.MaxPlayers()
                if CLIENT then
                    impulse.ApartmentBlocks[v].apartments[a].doors[c] = doorIndex
                else
                    impulse.ApartmentBlocks[v].apartments[a]:AddDoor(Entity(doorIndex))
                end
                impulse.ApartmentDoors[doorIndex] = true
            end
        end
    end

    for v,k in pairs(impulse.ApartmentBlocks) do
        for a,b in pairs(k.apartments) do
            for c,d in pairs(b.inhabitants) do
                local ply = Entity(c) 
                if IsValid(ply) and IsPlayer(ply) then
                    ply.apartmentBlock = v
                    ply.apartment = c
                end
            end
        end
    end
end

hook.Add("CanEditDoor", "ApartmentDoorRestrictions", function(ply, door)
    if impulse.ApartmentDoors[door:EntIndex()] then return false end
end)

hook.Add("InitPostEntity", "LoadApartmentsClient", function()
    if SERVER then return end
    impulse.LoadApartments()
end)

hook.Add("DoorsSetup", "LoadApartmentsServer", function()
    impulse.LoadApartments()
end)

