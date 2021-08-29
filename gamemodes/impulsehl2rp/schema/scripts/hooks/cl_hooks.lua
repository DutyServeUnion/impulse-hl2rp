function SCHEMA:ProcessICChatMessage(sender, message)
	if sender:IsCP() and sender:Team() != TEAM_CA then
		return "<:: "..message.." ::>"
	end
end

function SCHEMA:DefineSettings()
	impulse.DefineSetting("misc_localfootstepvol", {name="Local footstep volume", category="Misc", type="slider", default=65, minValue=30, maxValue=100})
end

function SCHEMA:PlayerGetJailData(duration, jailData)
	local cycles = duration / 60
	local reasons = "Your sentence length has been changed to "..cycles.." cycles in prison."

	if jailData then
		reasons = "You have been found guilty by Civil Protection of the following act(s):\n"

		for v,k in pairs(jailData) do
			reasons = reasons..impulse.Config.ArrestCharges[k].name.."\n"
		end

		reasons = reasons.."\nAs a punishment you have been assigned to serve "..cycles.." cycles in prison.\nCo-operation and civil behaviour may warrant a reduced sentence.\n\n\nWARNING: Disconnecting from the game will reset your sentence."
	end
	Derma_Message(reasons, "Your charges", "ACCEPT")
end

function SCHEMA:PlayerFootstep(ply, pos, foot, soundName, vol)
	if ply:KeyDown(IN_SPEED) then
		if ply:Team() == TEAM_CP then
			if ply == LocalPlayer() then
				EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, impulse.GetSetting("misc_localfootstepvol", 65) / 100)
			else
				ply:EmitSound("npc/metropolice/gear"..math.random(1,6)..".wav", 90)
			end

			return true
		elseif ply:Team() == TEAM_OTA then
			if ply == LocalPlayer() then
				EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", ply:GetPos(), -1, nil, impulse.GetSetting("misc_localfootstepvol", 65) / 100)
			else
				ply:EmitSound("npc/combine_soldier/gear"..math.random(1,6)..".wav", 100)
			end

			return true
		elseif ply:Team() == TEAM_VORT then
			if ply == LocalPlayer() then
				EmitSound("npc/vort/vort_foot"..math.random(1,4)..".wav", ply:GetPos(), -1, nil, impulse.GetSetting("misc_localfootstepvol", 65) / 100)
			else
				ply:EmitSound("npc/vort/vort_foot"..math.random(1,4)..".wav", 100)
			end
		end
	end
end

function SCHEMA:PlayerGetKnownName(target)
	if target:GetSyncVar(SYNC_COS_FACE, 0) == 4 and LocalPlayer() != target then -- if wearning facewrap
		return "Masked person"
	end
end

function SCHEMA:RenderScreenspaceEffects()
	if impulse_beingGassed and LocalPlayer():Alive() then
		if impulse_beingGassed > CurTime() then
			DrawMotionBlur(0.06, 2, 0.01)
		else
			impulse_beingGassed = nil
		end
	end
end

local blur = Material("pp/blurscreen")
function SCHEMA:HUDPaint()
	if impulse_beingGassed and LocalPlayer():Alive() then
		local X, Y = 0, 0
		local x, y = 0, 0
		local w, h = ScrW(), ScrH()

		surface.SetDrawColor(color_white)
		surface.SetMaterial(blur)

		for i = 1, 2 do
			blur:SetFloat("$blur", (i / 10) * 20)
			blur:Recompute()

			render.UpdateScreenEffectTexture()

			render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
	end
end

function SCHEMA:RagdollMenuAddOptions(panel, body)
	if not LocalPlayer():IsCP() or LocalPlayer():GetTeamClass() != CLASS_JURY then
		return
	end

	panel:AddAction("impulse/icons/detective-256.png", "Investigate Body", function()
		panel:Remove()

		if impulse.Anim.GetModelClass(body:GetModel()) == "metrocop" then
			impulse.MakeWorkbar(15, "Inspecting body...", function()
				if not IsValid(body) or not LocalPlayer():IsCP() or not LocalPlayer():Alive() then
					return
				end

				impulse.MakeWorkbar(15, "Reviewing bodycam footage...", function()
					if not IsValid(body) then
						return
					end

					net.Start("impulseHL2RPInspectBody")
					net.WriteEntity(body)
					net.SendToServer()
				end, true)
			end, true)
		else
			impulse.MakeWorkbar(15, "Inspecting body...", function()
				if not IsValid(body) then
					return
				end

				if body:GetModel() == "models/gibs/fast_zombie_legs.mdl" then
					Derma_Message("A skeleton remains, with most of it's flesh ripped off...\nWhat happened here?", "impulse", "Close")
					return
				end

				net.Start("impulseHL2RPInspectBody")
				net.WriteEntity(body)
				net.SendToServer()
			end, true)
		end
	end)
end

local range = impulse.Config.VortessenceRange ^ 2
local col = Color(138, 43, 226)
local nextVortScan = 0
local plys = {}
function SCHEMA:PreDrawHalos()
	if not VORTESSENCE_EXPIRE or VORTESSENCE_EXPIRE < CurTime() then
		return
	end
	
	if LocalPlayer():Team() != TEAM_VORT then
		VORTESSENCE_EXPIRE = nil
		return
	end

	if not LocalPlayer():Alive() then
		VORTESSENCE_EXPIRE = nil
		return
	end

	if nextVortScan < CurTime() then
		local pos = LocalPlayer():GetPos()
		plys = {}

		for v,k in pairs(player.GetAll()) do
			if not k:GetNoDraw() and k.GetPos(k):DistToSqr(pos) < range then
				table.insert(plys, k)
			end
		end

		nextVortScan = CurTime() + 0.5
	end

	halo.Add(plys, col, 5, 5, 1, nil, true)
end
