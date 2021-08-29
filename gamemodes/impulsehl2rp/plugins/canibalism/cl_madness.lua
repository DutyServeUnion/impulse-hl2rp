local crazyThingies = {
	"THENDISNEVERthe",
	"HELP",
	"vOICesvoicesvoicesvoicesS",
	"IS COMING",
	"KILL OR BE KILLED",
	"DON'T TRUST HIM",
	"REMEMBERREMEMBERREMEMEBVR",
	"WHAT WAS IT? THE NAME?",
	"THENAME HIS NAME HER NAME NAME"
}

CRAZYNAME_CACHED = CRAZYNAME_CACHED or {}

function PLUGIN:PlayerGetKnownName(target)
	if LocalPlayer():GetSyncVar(SYNC_INSANE, 0) < 4 then
		return
	end

	if CRAZYNAME_CACHED[target] and CRAZYNAME_NEXT > CurTime() then
		return CRAZYNAME_CACHED[target]
	end
	
	local name = target:GetName()
	local nl = string.len(name)
	local crazyName = ""
	local crazed = false
	local wait = 0
	local doCrazy = nil

	if math.random(1, 100) < 5 then
		doCrazy = math.random(1, nl)
	end

	for i=1, nl do
		local o = string.sub(name, i, i)
		if math.random(1, 5) == 1 then
			o = string.char(math.random(97, 122))
		end

		if math.random(1, 3) == 1 then
			o = string.upper(o)
		end

		if not crazed and doCrazy and doCrazy == i then
			crazed = true
			o = crazyThingies[math.random(1, #crazyThingies)]
			wait = 0.3
		end

		crazyName = crazyName..o
	end

	CRAZYNAME_CACHED[target] = crazyName
	CRAZYNAME_NEXT = CurTime() + (math.random(10, 30) * 0.005) + wait
	return crazyName
end

local nextBonkers = 0
local bonkersSounds = {
	{"impulse/whispers1.wav", 10},
	{"impulse/whispers2.wav", 20},
	{"impulse/whispers3.wav", 135}
}
function PLUGIN:Think()
	if nextBonkers > CurTime() then
		return
	end

	local level = LocalPlayer():GetSyncVar(SYNC_INSANE, 0)


	if level < 2 then
		nextBonkers = CurTime() + math.random(3, 10)
		return
	end
	
	local dat

	if level > 4 then
		dat = bonkersSounds[math.random(1, #bonkersSounds)]
	else
		dat = bonkersSounds[math.random(1, #bonkersSounds - 1)]
	end

	LocalPlayer():EmitSound(dat[1], math.random(math.Clamp(level * 10, 0, 55), level * 16))

	if math.random(1, 4) == 1 then
		LocalPlayer():ConCommand("say /me begins to shake violently.")
	end

	if level == 5 and math.random(1, 5) == 5 then
		surface.PlaySound("ambient/voices/playground_memory.wav")
	end

	nextBonkers = CurTime() + dat[2] + math.random(LocalPlayer():GetSyncVar(SYNC_INSANE, 0) > 3 and 1 or 10, LocalPlayer():GetSyncVar(SYNC_INSANE, 0) > 3 and 7 or 40)
end

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.04,
	["$pp_colour_contrast"] = 1.35,
	["$pp_colour_colour"] = 5,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}
function PLUGIN:RenderScreenspaceEffects()
	if LocalPlayer():GetSyncVar(SYNC_INSANE, 0) < 5 then
		return
	end

	local tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = (-0.3 - math.sin(RealTime() * .5) * .1),
		["$pp_colour_contrast"] = 1.35,
		["$pp_colour_colour"] = 3,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	DrawColorModify(tab)
	DrawSobel(0.5)
end
