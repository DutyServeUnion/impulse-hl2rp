net.Receive("impulseHL2RPBlockTerminalDerma", function()
    local listedApartments = {}
    local blockIndex = net.ReadInt(8)
    local block = impulse.ApartmentBlocks[blockIndex]

    for v,k in pairs(block.apartments) do
        if k.doors[1] then
            local door = Entity(k.doors[1])

            if not IsValid(door) then
                continue
            end
            
            if #door:GetSyncVar(SYNC_DOOR_OWNERS, {}) != 0 then continue end
            listedApartments[v] = k
        end
    end

    local panel = vgui.Create("impulseApartmentPanel")
    panel.blockIndex = blockIndex
    panel.block = impulse.ApartmentBlocks[blockIndex]
    panel.listedApartments = listedApartments
    panel.hasApartment = net.ReadBool()
    panel:Show()
end)
