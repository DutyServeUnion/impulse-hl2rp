hook.Add("CreateSyncVars", "impulseHL2RPApartmentSyncVars", function()
    SYNC_APT_APTKEY = impulse.Sync.RegisterVar(SYNC_INT)
    SYNC_APT_BLOCKKEY = impulse.Sync.RegisterVar(SYNC_INT)
    SYNC_APT_ISOWNER = impulse.Sync.RegisterVar(SYNC_BOOL)
end)

hook.Add("PlayerDisconnected", "ApartmentPlayerDisconnect", function(ply)
    if ply:HasApartment() then
        ply:LeaveApartment()
    end
    -- local apt = ply:GetApartment()
    -- if !apt then return end
    -- apt:RemoveInhabitant(ply)
end)

hook.Add("OnPlayerChangedTeam", "ApartmentTeamChanged", function(ply, oldTeam, newTeam)
    if !ply:GetApartment() then return end
    if newTeam != TEAM_CWU or newTeam != TEAM_CITIZEN then
        ply:Notify("Your apartment has been removed as you have changed to "..team.GetName (newTeam)..".")
        ply:LeaveApartment()
    end
end)
