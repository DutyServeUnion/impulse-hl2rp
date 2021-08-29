function meta:IsScanner()
    if self:GetObserverTarget() ~= NULL and self:GetObserverTarget():GetClass() == "impulse_hl2rp_scanner" then
        return true
    else
        return false
    end
end

function meta:GetScannerFromPlayer()
    if self:IsScanner() then
        return self:GetObserverTarget()
    end
end

hook.Add("CanUseInventory", "impulseHL2RPInvBlockScanner", function(ply)
    return not ply:IsScanner()
end)

