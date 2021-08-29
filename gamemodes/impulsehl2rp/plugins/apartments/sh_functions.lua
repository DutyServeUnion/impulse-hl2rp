impulse.ApartmentBlocks = impulse.ApartmentBlocks or {}

if SERVER then
    util.AddNetworkString("impulseHL2RPBlockTerminalDerma")
end

function meta:IsApartmentOwner()
    return self:GetSyncVar(SYNC_APT_ISOWNER, nil)
end

function meta:GetApartment()
    local blockKey, aptKey = self:GetSyncVar(SYNC_APT_BLOCKKEY, nil), self:GetSyncVar(SYNC_APT_APTKEY, nil)
    if not blockKey or not aptKey then 
        return 
    end

    local apt = impulse.ApartmentBlocks[blockKey].apartments[aptKey]
    return apt
end

function meta:HasApartment()
    if self:GetSyncVar(SYNC_APT_BLOCKKEY, nil) != nil and self:GetSyncVar(SYNC_APT_APTKEY, nil) != nil then
        return true
    else
        return false
    end
end

function meta:GetApartmentBlock()
    local blockKey = self:GetSyncVar(SYNC_APT_BLOCKKEY, nil)
    if not blockKey then 
        return 
    end

    local aptBlock = impulse.ApartmentBlocks[blockKey]
    return aptBlock
end

local eMeta = FindMetaTable("Entity")

function eMeta:IsApartmentDoor()
    if impulse.ApartmentDoors[self:EntIndex()] == true then
        return true
    else
        return false
    end
end

concommand.Add("impulse_apartments_reload", function(ply, cmd, args)
    impulse.LoadApartments()
end)

