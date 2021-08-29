if SERVER then
    util.AddNetworkString("impulseHL2RPDispatchBroadcast")
end

impulse.Dispatch = impulse.Dispatch or {}

local dispatchCol = Color(30, 125, 137)
function impulse.Dispatch.Announce(index)
    if SERVER then
        net.Start("impulseHL2RPDispatchBroadcast")
        net.WriteUInt(index, 8)
        net.Broadcast()
    else
        local announcement = impulse.Config.DispatchLines[index]

        if LocalPlayer():IsCP() then
            LocalPlayer():SendCombineMessage("ALL UNITS, STAND BY FOR CIVIL ANNOUNCEMENT [#"..index.."]")
        end

        timer.Simple(2, function()
            impulse.customChatFont = "Impulse-ChatRadio"
            chat.AddText(dispatchCol, "[DISPATCH] " ..announcement.text)
            LocalPlayer():EmitSound(announcement.sound, announcement.volume or 80)
        end)
    end
end

if CLIENT then
    net.Receive("impulseHL2RPDispatchBroadcast", function()
        local index = net.ReadUInt(8)
        local announcement = impulse.Config.DispatchLines[index]
        if announcement then
            impulse.Dispatch.Announce(index)
        end
    end)
end

