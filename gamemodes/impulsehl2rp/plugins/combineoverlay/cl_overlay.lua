local surface = surface
local draw = draw
local CurTime = CurTime
local LocalPlayer = LocalPlayer
local math = math
local player = player
local pairs = pairs
local ScrW = ScrW
local ScrH = ScrH

local overlayCol = Color(255, 255, 255, 10)
local messagesCol = Color(0, 0, 0, 175)
local bootCol = Color(0, 0, 0, 130)
local red = Color(255, 0, 0)
local nextFlicker
local nextCheck

local CMB_OVERLAY_COLS = {
    Color(65, 120, 200), -- universal
    Color(75, 155, 45), -- squad
    Color(255, 150, 0), -- command
    Color(210, 55, 50), -- danger
    Color(150, 150, 150) -- respond
}

local CMB_OVERLAY_ICONS = {
    Material("impulse/hl2rp/overlay/move"), -- move
    Material("impulse/hl2rp/overlay/alert"), -- alert
    Material("impulse/hl2rp/overlay/flatline"), -- death
    Material("impulse/hl2rp/overlay/blockinspect"), -- block insp.
    Material("impulse/hl2rp/overlay/move_sq"), -- move squad
    Material("impulse/hl2rp/overlay/combine"), -- UU
    Material("impulse/hl2rp/overlay/cctv") -- camera
}

surface.CreateFont("impulseHL2RPOverlayBig", {
    font = "Courier New",
    size = 21,
    weight = 800,
    scanlines = 10,
    outline = true,
    antialias = true
})

surface.CreateFont("impulseHL2RPScannerFont", {
    font = "Lucida Sans Typewriter",
    antialias = false,
    outline = true,
    weight = 800,
    size = 18
})


impulse.CombineMessages = impulse.CombineMessages or {}
impulse.CombineWaypoints = impulse.CombineWaypoints or {}
impulse.CombineMessageID = impulse.CombineMessageID or 0

impulse.DefineSetting("hud_combineoverlay", {name="Combine overlay enabled", category="HUD", type="tickbox", default=false})

local function DrawCombineWaypoints()
    for i = 1, #impulse.CombineWaypoints do
        local waypointData = impulse.CombineWaypoints[i]
        if not waypointData then continue end
        local pos = waypointData.pos:ToScreen()

        if not waypointData.nextUpdate or waypointData.nextUpdate < CurTime() then
            local plyPos = LocalPlayer():GetPos()

            waypointData.dist = (waypointData.pos:Distance(plyPos) / 39.3701) -- 39 inches in meter
            waypointData.nextUpdate = CurTime() + 0.5
        end

        surface.SetMaterial(waypointData.mat)
        surface.SetDrawColor(waypointData.colour)
        surface.DrawTexturedRect(pos.x - 16, pos.y, 32, 32)

        draw.SimpleText("<:: "..waypointData.text.." ::>", "BudgetLabel", pos.x, pos.y + 30, waypointData.textcolour or color_white, TEXT_ALIGN_CENTER)

        if waypointData.name then
            local prefix = waypointData.prefix or "UNIT"
            local text = waypointData.name

            draw.SimpleText("<:: "..prefix..": "..text.." ::>", "BudgetLabel", pos.x, pos.y + 42, color_white, TEXT_ALIGN_CENTER)
            draw.SimpleText("<:: DIST: "..math.Round(waypointData.dist).."m ::>", "BudgetLabel", pos.x, pos.y + 54, color_white, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("<:: DIST: "..math.Round(waypointData.dist).."m ::>", "BudgetLabel", pos.x, pos.y + 42, color_white, TEXT_ALIGN_CENTER)
        end

        if waypointData.endtime and waypointData.endtime < CurTime() then
            impulse.CombineWaypoints[i] = nil
            LocalPlayer():EmitSound("buttons/button17.wav", 35, 60)
        end 
    end
end

local scannerColorModify = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local lineYPos = 75
local lastTargetTime = 0
local lastTarget
local scanPercentage = 0
local lineWide = 5
local lineCol =  Color(190, 190, 190, 180)
local faceShadeCol =  Color(40, 40, 40, 60)
local redColor = 0
local loopDirection = true

local function DrawScannerPlayerBox(target, scanner, percentage)
    local head = target:LookupBone("ValveBiped.Bip01_Head1")

    if not head then
        return
    end

    local ang = LocalPlayer():GetAngles()
    local bottomPos = target:GetBonePosition(head) - (ang:Up() * 4)
    local xGap = ang:Right() * 7.5
    local topPos = bottomPos + (ang:Up() * 15)
    local bottomL = bottomPos - xGap
    local bottomR = bottomPos + xGap
    local topL = topPos - xGap
    local topR = topPos + xGap

    local tl = topL:ToScreen()
    local br = bottomR:ToScreen()
    
    local w = br.x - tl.x
    local h = br.y - tl.y
    
    surface.SetDrawColor(faceShadeCol)
    surface.DrawRect(tl.x, tl.y, w, h)

    surface.SetDrawColor(lineCol)
    surface.DrawOutlinedRect(tl.x, tl.y, w, h)

    surface.SetTextColor(Color(255, 255, 255, 255))
    surface.SetFont("BudgetLabel")
    surface.SetTextPos(tl.x + 2, tl.y + 2)
    if scanner:GetIsScanning() and target == scanner:GetScanTarget() then
        surface.DrawText(percentage .. "%")
    else
        surface.DrawText("IDLE...")
    end
end

local function DrawScannerHUD() 
    local scanner = LocalPlayer():GetScannerFromPlayer()
    local target = scanner:GetCurrentTarget()

    DrawColorModify(scannerColorModify)

    -- nutscript style scanner hud
    local boxWide, boxHeight = 580, 420
    local boxWide2, boxHeight2 = boxWide * 0.5, boxHeight * 0.5
    local scrW, scrH = ScrW() * 0.5, ScrH() * 0.5
    local x, y = scrW - boxWide2, scrH - boxHeight2
    local pos = scanner:GetPos()
    local ang = LocalPlayer():GetAimVector():Angle()

    draw.SimpleText("POS ("..math.floor(pos[1])..", "..math.floor(pos[2])..", "..math.floor(pos[3])..")", "impulseHL2RPScannerFont", x + 8, y + 8, color_white)
    draw.SimpleText("ANG ("..math.floor(ang[1])..", "..math.floor(ang[2])..", "..math.floor(ang[3])..")", "impulseHL2RPScannerFont", x + 8, y + 24, color_white)
    draw.SimpleText("IAS ("..math.Round(scanner:GetVelocity():Length2D())..")", "impulseHL2RPScannerFont", x + 8, y + 40, color_white)
    draw.SimpleText("ID  ("..LocalPlayer():Name()..")", "impulseHL2RPScannerFont", x + 8, y + 56, color_white)
    draw.SimpleText("ZM  ("..math.Round(SCANNER_ZOOM)..")", "impulseHL2RPScannerFont", x + 8, y + 72, color_white)

    surface.SetDrawColor(235, 235, 235, 230)

    surface.DrawLine(x, y, x + 128, y)
    surface.DrawLine(x, y, x, y + 128)

    x = scrW + boxWide2

    surface.DrawLine(x, y, x - 128, y)
    surface.DrawLine(x, y, x, y + 128)

    x = scrW - boxWide2
    y = scrH + boxHeight2

    surface.DrawLine(x, y, x + 128, y)
    surface.DrawLine(x, y, x, y - 128)

    x = scrW + boxWide2

    surface.DrawLine(x, y, x - 128, y)
    surface.DrawLine(x, y, x, y - 128)
end

local squadCol = Color(75, 155, 45, 255)
local grey = Color(60, 60, 60, 255)

local function DrawCombineSquad()
    local scrH = ScrH()
    local w, h = 330, 178
    local yadd = 0
    local lp = LocalPlayer()

    surface.SetTextColor(squadCol)
    surface.SetFont("BudgetLabel")

    surface.SetTextPos(w, scrH - 196)

    local squadId = lp:GetSyncVar(SYNC_SQUAD_ID, 0)
    local squadComp = {}
    local i = 2

    for v,k in pairs(team.GetPlayers(lp:Team())) do
        if k:GetSyncVar(SYNC_SQUAD_ID, -1) == squadId then
            if k:GetSyncVar(SYNC_SQUAD_LEADER, false) then
                squadComp[1] = k
            else
                squadComp[i] = k
                i = i + 1
            end
        end
    end

    local squadName = "SQUAD"
    if lp:Team() == TEAM_CP then
        squadName = "PT"
    end
    surface.DrawText(squadName.." "..squadId..":")

    for i=1,#squadComp do
        local k = squadComp[i]

        if not IsValid(k) then
            if i == 1 then
                surface.SetTextPos(w, scrH - h + yadd)
                surface.DrawText("⏺ NO LEADER (F6)")
                yadd = yadd + 18
            end
            continue
        end

        surface.SetTextPos(w, scrH - h + yadd)

        local hp = k:Health()
        if not k:Alive() then
            surface.SetTextColor(grey)
            hp = 0
        elseif hp < 26 then
            surface.SetTextColor(CMB_OVERLAY_COLS[4])
        else
            surface.SetTextColor(squadCol)
        end

        surface.DrawText("⏺ "..k:Nick().." ["..hp.."]")
        yadd = yadd + 18
    end

    return squadComp
end

local direction = {
    [0] = "N",
    [45] = "NE",
    [90] = "E",
    [135] = "SE",
    [180] = "S",
    [225] = "SW",
    [270] = "W",
    [315] = "NW",
    [360] = "N"
}

local function DrawCombineCompass(squad)
    local ang = LocalPlayer():EyeAngles()
    local bearing = impulse.AngleToBearing(ang)
    local width = ScrW() * .23
    local w2 = width / 2
    local m = 1
    local spacing = (width * m) / 360
    local lines = width / spacing
    local rang = math.Round(ang.y)
    local comX = ScrW() / 2
    local me = LocalPlayer()

    surface.SetDrawColor(messagesCol)
    surface.DrawRect(ScrW() / 2 - (width / 2) - 8, 30, width + 16, 40)

    if squad then
        local myPos = LocalPlayer():GetPos()

        for v,k in pairs(squad) do
            if k == me or not k:Alive() then
                continue
            end
            
            local isLeader = v == 1 and true or false

            local pos = k:GetPos()
            local yAng = ang.y - (pos - myPos):GetNormalized():Angle().y
            local squadMarker = math.Clamp(((comX + (w2 * m)) - (((-yAng - 180) % 360) * spacing)), comX - w2, comX + w2)

            draw.SimpleText(isLeader and "(LDR)" or "⏺", "BudgetLabel", squadMarker, 40, squadCol, TEXT_ALIGN_CENTER)
        end
    end

    draw.SimpleText(bearing, "BudgetLabel", ScrW() / 2, 58, color_white, TEXT_ALIGN_CENTER)

    for i = (rang - (lines / 2)) % 360, ((rang - (lines / 2)) % 360) + lines do
        local x = (comX + (width / 2)) - ((i - ang.y - 180) % 360) * spacing

        if i % 30 == 0 and i > 0 then
            local text = direction[360 - (i % 360)] and direction[360 - (i % 360)] or 360 - (i % 360)

            draw.SimpleText(text, "BudgetLabel", x, 30, color_white, TEXT_ALIGN_CENTER)
        end
    end
end

local function DrawLowAmmo(offset)
    draw.SimpleText("WARNING:\nLocal unit low on ammunition!", "BudgetLabel", ScrW() * 0.52, ScrH() * 0.45 + offset, CMB_OVERLAY_COLS[4])
end

local modeNames = {
    [0] = "Grounded",
    [1] = "Grounded",
    [2] = "Pacify",
    [3] = "Active"
}

local function DrawBatonStatus(baton, offset)
    local mode = baton:GetMode() or 1

    draw.SimpleText("BATON STATUS:\n"..modeNames[mode], "BudgetLabel", ScrW() * 0.52, ScrH() * 0.45 + offset, CMB_OVERLAY_COLS[1])
end

local bootCmds = {
    "./sh/boot/bit64.smd",
    "./sh/boot/bit32.smd",
    "./sh/boot/bit16.smd",
    "./sh/boot/gw33sybw3dz.so",
    "...1",
    "...2",
    "...3",
    "...4",
    "...5",
    "...6",
    "done",
    "syntax error! /boot/bit16.smd: (line 65): impulse was not capitalized!",
    "loading libraries...",
    "vindows-backwardscompat1",
    "vindows-servicepack2",
    "done!",
    "establishing connection to city interface...",
    "attempt 1",
    "attempt 2",
    "connection established (24ms): Code 54 Authorisation request",
    "login",
    "establishing overwatch data uplink...",
    "CMB1-001-CONNECTED",
    "CMB1-002-CONNECTED",
    "CMB1-003-CONNECTED",
    "CMB2-001-CONNECTED",
    "CMB3-001-CONNECTED",
    "CMB3-002-CONNECTED",
    "CMB4-001-FAILED",
    "connecting to local hardware...",
    "ASB vocoder - CONNECTED",
    "VHF/UHF two-way radio - CONNECTED",
    "biosignal controller - CONNECTED",
    "visual receptor - CONNECTED",
    "internal biolink - CONNECTED",
    "firearm RFID interface - CONNECTED",
    "./sh/os32.z",
    "./sh/js-compact.js",
    "...",
    "....",
    ".....",
    "......",
    "completed boot sequence! (last serviceID: 4349271)"
}

local command = 0
local nextCommand
local bootDone = 0
local startTime

local function DrawBootSequence()
    if bootDone and bootDone < CurTime() then
        startTime = nil
        return true
    end

    local blue = (LocalPlayer():Team() == TEAM_OTA and team.GetColor(TEAM_OTA)) or CMB_OVERLAY_COLS[1]
    local x, y = ScrW() * .4, ScrH() * .25
    startTime = startTime or CurTime()

    surface.SetDrawColor(blue)
    surface.SetMaterial(CMB_OVERLAY_ICONS[6])
    surface.DrawTexturedRect(x, y, 128, 128)

    if startTime + 0.2 < CurTime() then
        draw.SimpleText("<:: CENTRAL DISPATCH INTERFACE", "impulseHL2RPOverlayBig", x + 140, y + 20, blue)
    end
    
    if startTime + 0.5 < CurTime() then
        draw.SimpleText("Booting...                          "..bit.tohex(bit.tobit(math.random(-1000000,1000000))), "BudgetLabel", x + 140, y + 40, blue)
    end

    if startTime + 1.5 < CurTime() then
        if not bootDone and (not nextCommand or nextCommand < CurTime()) then
            command = command + 1

            chat.PlaySound()

            if not bootCmds[command] then
                bootDone = CurTime() + 1.1
                surface.PlaySound("ambient/levels/prison/radio_random12.wav")
                surface.PlaySound("items/suitchargeok1.wav")
            end

            local wait = 0.1

            if command == 22 or command == 30 or command == 13 then
                wait = wait + 0.9
            end

            nextCommand = CurTime() + wait
        end

        for i = 1, command do
            local cmd = bootCmds[i]

            if cmd then
                draw.SimpleText(cmd, "BudgetLabel", x + 140, (y + 55) + (10 * i))     
            end
        end
    end
end

local medCol = Color(255, 228, 0)
local armCol = Color(255, 0, 0)
local nextArmFlash = 0
local function DrawAuxData(offset)
    local zone = LocalPlayer():GetZoneName()
    local scrW = ScrW()
    local pos = LocalPlayer():GetPos()
    local grid = math.Round(pos.x / 100).."/"..math.Round(pos.y / 100)
    local hp = LocalPlayer():Health()
    local armour = LocalPlayer():Armor()
    local cityCode = impulse.Dispatch.GetCityCode()
    local cityCodeData = impulse.Dispatch.CityCodes[cityCode]
    local add = 0
    local sps = false

    draw.SimpleText("AUX DATA ::>", "BudgetLabel", scrW - 8, 24 + offset, nil, TEXT_ALIGN_RIGHT)
    draw.SimpleText("BIOSIGNAL: ON ::>", "BudgetLabel", scrW - 8, 38 + offset, nil, TEXT_ALIGN_RIGHT)
    draw.SimpleText("BIOSIGNAL ZONE: "..zone.." ::>", "BudgetLabel", scrW - 8, 52 + offset, nil, TEXT_ALIGN_RIGHT)
    draw.SimpleText("BIOSIGNAL GRID: "..grid.." ::>", "BudgetLabel", scrW - 8, 66 + offset, nil, TEXT_ALIGN_RIGHT)

    if LocalPlayer():Team() == TEAM_OTA then
        sps = true
        draw.SimpleText("SUIT PROTECTION SYSTEM CHARGE: "..armour.." ::>", "BudgetLabel", scrW - 8, 80 + offset, nil, TEXT_ALIGN_RIGHT)
        add = add + 14
    end

    draw.SimpleText("CITY CODE: "..cityCodeData[1].." ::>", "BudgetLabel", scrW - 8, 80 + add, cityCodeData[2], TEXT_ALIGN_RIGHT)

    add = add + 5

    if hp <= 70 then
        add = add + 14
        draw.SimpleText("WARNING: LOCAL UNIT REQUIRES MEDICAL ATTENTION!", "BudgetLabel", scrW - 8, 80 + add + offset, medCol, TEXT_ALIGN_RIGHT)
    end

    if sps and armour <= 40 then
        if armour <= 5 then
            if CurTime() > nextArmFlash + 1 then
                nextArmFlash = CurTime() + 1
            end
        end
        add = add + 14

        if CurTime() > nextArmFlash then
            draw.SimpleText("WARNING: LOCAL UNIT SPS REQUIRES RECHARGE!", "BudgetLabel", scrW - 8, 80 + add + offset, armCol, TEXT_ALIGN_RIGHT)
        end
    end

end

local function DrawCombineMessages(offset)
    local x, y

    for i = 1, #impulse.CombineMessages do
        local msgData = impulse.CombineMessages[i]
        x, y = 8 + offset, (i - 1) * 16 + 8

        surface.SetFont("BudgetLabel")
        local w, h = surface.GetTextSize(msgData.message)

        surface.SetDrawColor(msgData.bgCol or messagesCol)
        surface.DrawRect(x, y + 6, w + 12, h)

        draw.SimpleText(msgData.message, "BudgetLabel", x + 6, y + 6, color_white, 0, 0)
    end

    return y
end

local function DrawCombineCameraOverlay()
    if not IsValid(WATCHING_CAM) then
        return
    end

    local x = ScrW() * 0.3
    local y = ScrH() * 0.3
    local ang = WATCHING_CAM:GetAttachment(1).Ang

    DrawColorModify(scannerColorModify)

    draw.SimpleText("CAM-"..WATCHING_CAM:GetSyncVar(SYNC_CAM_CAMID, 0), "BudgetLabel", x, y, color_white)
    draw.SimpleText("ANG: "..math.floor(ang[1]).." "..math.floor(ang[2]).." "..math.floor(ang[3]), "BudgetLabel", x, y + 10, color_white)
    draw.SimpleText("STATUS: ONLINE", "BudgetLabel", x, y + 20, color_white)
    draw.SimpleText("HEALTH: "..WATCHING_CAM:Health(), "BudgetLabel", x, y + 30, color_white)
end

local otaWallsRange =  820 ^ 2
local function DrawCombineHUD()
    local lp = LocalPlayer()
    local offset = 0

    if not lp:IsCP() or lp:Team() == TEAM_CA then
        return
    end

    if lp:GetTeamClass() == 0 then
        return
    end

    if (not WATCHING_CAM and impulse.hudEnabled == false) or (IsValid(impulse.MainMenu) and impulse.MainMenu:IsVisible()) then
        return
    end

    if not CMB_OVERLAY then
        CMB_OVERLAY = Material("effects/combine_binocoverlay")
        CMB_OVERLAY:SetFloat("$salpha", "0.2")
        CMB_OVERLAY:Recompute()
    end

    if impulse.GetSetting("hud_combineoverlay", false) or WATCHING_CAM then
        surface.SetDrawColor(overlayCol)
        surface.SetMaterial(CMB_OVERLAY)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end

    if nextFlicker and nextFlicker > CurTime() then
        surface.SetDrawColor(messagesCol)
        surface.DrawRect(ScrW() * .3, ScrH() * .3, 700, 20)
        draw.SimpleText("FATAL ERROR: SYSTEM REQUIRES IMMEDIATE SERVICE. REBOOTING...", "BudgetLabel", ScrW() * .5, (ScrH() * .3) + math.random(1, 2), red, TEXT_ALIGN_CENTER, 0)
        return
    end

    local hp = lp:Health()
    if hp <= 25 and (not nextCheck or nextCheck < CurTime()) then
        local ubound = math.Clamp(hp, 8, 20)
        local rand = math.random(1, ubound)

        if rand == ubound then
            nextFlicker = CurTime() + math.Rand(0.1, 1)
            surface.PlaySound("ambient/levels/prison/radio_random"..math.random(1,13)..".wav")
        else
            nextCheck = CurTime() + 0.1
            offset = math.random(10, 80)
        end
    end

    if not DrawBootSequence() then
        return
    end
    
    DrawCombineWaypoints()

    if WATCHING_CAM then
        DrawCombineCameraOverlay()
    end

    local sqData
    if lp:GetSyncVar(SYNC_SQUAD_ID, nil) then
        sqData = DrawCombineSquad()
    end

    if lp:Team() == TEAM_OTA then
        local pos = lp:GetPos()

        DrawCombineCompass(sqData)

        local wep = lp:GetActiveWeapon()
        if wep and IsValid(wep) then
            local clip = wep:Clip1()
            local maxClip = wep:GetMaxClip1()

            if maxClip > 0 and clip < maxClip * 0.2 then
                DrawLowAmmo(offset)
            end
        end
    elseif lp:Team() == TEAM_CP then
        local wep = lp:GetActiveWeapon()

        if wep and IsValid(wep) and wep:GetClass() == "ls_stunstick" and lp:IsWeaponRaised() then
            DrawBatonStatus(wep, offset)
        end
    end

    local h = DrawCombineMessages(offset)
    DrawAuxData(offset)
end

hook.Add("HUDPaint", "impulseHL2RPCombineOverlay", DrawCombineHUD)

local function CameraView(ply, pos, ang, fov)
    if not WATCHING_CAM then
        return
    end

    if not IsValid(WATCHING_CAM) then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return
    end

    if not WATCHING_CAM:IsCameraEnabled() then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return LocalPlayer():Notify("Camera signal lost.")
    end

    if not LocalPlayer():Alive() then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return
    end

    if not LocalPlayer():IsCP() then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return
    end

    if WATCHING_CAM_POS:DistToSqr(LocalPlayer():GetPos()) > (70 ^ 2) then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return ply:Notify("You moved too far from the terminal.")
    end

    local eyes = WATCHING_CAM:LookupAttachment("eyes")

    if not eyes then
        impulse.hudEnabled = true
        WATCHING_CAM = nil
        return
    end

    local data = WATCHING_CAM:GetAttachment(eyes)
    data.Pos = data.Pos + data.Ang:Forward() * 2.8

    local view = {}
    view.origin = data.Pos
    view.angles = data.Ang
    view.fov = 110

    return view
end

hook.Add("CalcView", "impulseHL2RPCombineCamView", CameraView)

function impulse.AddCombineMessage(text, col, noSound)
    impulse.CombineMessageID = impulse.CombineMessageID + 1
    text = "<:: "..string.upper(text)

    if col then
        col.a = 175
    end

    local msgData = {
        message = "",
        bgCol = col
    }

    table.insert(impulse.CombineMessages, msgData)

    if (#impulse.CombineMessages > 8) then
        table.remove(impulse.CombineMessages, 1)
    end

    local i = 1
    local id = "impulse_CombineOverlay"..impulse.CombineMessageID

    timer.Create(id, 0.005, #text + 1, function()
        msgData.message = string.sub(text, 1, i + 2)
        i = i + 3

        if msgData.message == #text then
            LocalPlayer():EmitSound("buttons/button24.wav", 40, 135)
            timer.Remove(id)
        end
    end)

    if not noSound then
        LocalPlayer():EmitSound("buttons/button24.wav")
    end
end

function impulse.AddCombineWaypoint(message, pos, duration, icon, colour, textcolour, unit, sender, citizen)
    local waypoint = {
        text = message,
        pos = pos,
        endtime = duration and (CurTime() + duration) or nil,
        mat = CMB_OVERLAY_ICONS[icon or 1],
        colour = CMB_OVERLAY_COLS[colour or 1],
        textcolour = CMB_OVERLAY_COLS[textcolour or 1] or color_white
    }

    if unit and IsValid(unit) then
        waypoint.name = unit:Nick()
        waypoint.prefix = "UNIT"
    elseif sender and IsValid(sender) then
        waypoint.name = sender:Nick()
        waypoint.prefix = "SENDER"
    elseif citizen then
        waypoint.name = citizen:Nick()
        waypoint.prefix = "TARGET"
    end

    local id = table.insert(impulse.CombineWaypoints, waypoint)

    LocalPlayer():EmitSound("buttons/button17.wav", 45, 135)

    return id
end

net.Receive("impulseHL2RPCombineMessage", function()
    local message = net.ReadString()
    local col = net.ReadColor()

    if col == Color(0, 0, 0) then
        impulse.AddCombineMessage(message)
    else
        impulse.AddCombineMessage(message, col)
    end
end)

net.Receive("impulseHL2RPCombineWaypoint",function()
    local message = net.ReadString()
    local pos = net.ReadVector()
    local duration = net.ReadUInt(10)
    local icon = net.ReadUInt(8)
    local colour = net.ReadUInt(8)
    local unit = net.ReadUInt(8)

    if unit != 0 then
        unit = Entity(unit)

        if not IsValid(unit) then
            unit = nil
        end
    end

    impulse.AddCombineWaypoint(message, pos, duration, icon, colour, nil, unit or nil)
end)

net.Receive("impulseHL2RPCombineOverlayBoot", function()
    bootDone = nil
    command = 0
    nextCommand = nil
end)

local nextMessage
local lastMessage
local idleMessages = {
    "Idle connection...",
    "Pinging loopback...",
    "Updating biosignal coordinates...",
    "Establishing DC link...",
    "Checking exodus protocol status...",
    "Sending commdata to dispatch..."
}

hook.Add("Think", "impulseAmbientMessages", function()
    local lp = LocalPlayer()

    if (lp:Team() == TEAM_CP or lp:Team() == TEAM_OTA) and (nextMessage or 0) < CurTime() then
        local message = idleMessages[math.random(1, #idleMessages)]

        if message != (lastMessage or "") then
            impulse.AddCombineMessage(message, nil, true)
            lastMessage = message
        end

        nextMessage = CurTime() + 10 + math.random(10, 38)
    end
end)
