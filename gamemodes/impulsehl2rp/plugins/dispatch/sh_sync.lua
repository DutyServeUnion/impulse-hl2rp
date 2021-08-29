function PLUGIN:CreateSyncVars()
	SYNC_DISPATCH_BOL = impulse.Sync.RegisterVar(SYNC_INT)
	SYNC_CAM_CAMID = impulse.Sync.RegisterVar(SYNC_INT)
	
    SYNC_SQUAD_ID = impulse.Sync.RegisterVar(SYNC_INT)
    SYNC_SQUAD_LEADER = impulse.Sync.RegisterVar(SYNC_BOOL)
end
