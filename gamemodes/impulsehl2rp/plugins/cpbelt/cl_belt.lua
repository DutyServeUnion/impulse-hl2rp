local beltData = {
	["ls_stunstick"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_stunbaton.mdl",
			pos = Vector(2, -7.5, -3),
			ang = Angle(-100, 81, 45),
			scale = 1
		}
	},
	["ls_usp"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_pistol.mdl",
			pos = Vector(-1.2, -8.4, -0),
			ang = Angle(-56, 82, -65),
			scale = 1
		}
	},
	["ls_357"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_357.mdl",
			pos = Vector(-4, -8.2, -0),
			ang = Angle(90, -90, -90),
			scale = 0.9
		}
	},
	["ls_teargas"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/weapons/w_eq_smokegrenade.mdl",
			pos = Vector(-2, 7, 3),
			ang = Angle(-90, 0, -30),
			scale = 1
		}
	},
	["ls_mp7"] = {
		Bone = "ValveBiped.Bip01_Spine",
		Data = {
			model = "models/weapons/w_smg1.mdl",
			pos = Vector(-9, 1, 1.2),
			ang = Angle(195, 0, 110),
			scale = 0.88
		}
	},
	["ls_medkit"] = {
		Bone = "ValveBiped.Bip01_Pelvis",
		Data = {
			model = "models/warz/items/medkit.mdl",
			pos = Vector(-1.55, 8, 2),
			ang = Angle(-90, 0, -60),
			scale = 0.85
		}
	}
}

local LocalPlayer = LocalPlayer
local pairs = pairs
local IsValid = IsValid
local function beltCheck(ent, isPanel)
	local ply = isPanel and LocalPlayer() or ent
	local weps = ply.GetWeapons(ply)
	local active = ply.GetActiveWeapon(ply)
	local activeClass = IsValid(active) and active:GetClass() or nil

	ply.CPBeltCos = ply.CPBeltCos or {}

	for v,k in pairs(ply.CPBeltCos) do
		if not ply:HasWeapon(v) then
			RemoveCosmetic(ply, ply, "belt_"..v)
			ply.CPBeltCos[v] = nil
		end
	end

	for v,k in pairs(weps) do
		local class = k.GetClass(k)
		local beltId = "belt_"..class

		if not beltData[class] then
			continue
		end

		if activeClass and activeClass == class then
			if ply.Cosmetics and ply.Cosmetics[beltId] then
				RemoveCosmetic(ply, ply, beltId)
				ply.CPBeltCos[class] = nil
			end

			continue
		end

		--if not ply.Cosmetics or not ply.Cosmetics[beltId] then
			MakeCosmetic(ply, nil, beltData[class].Bone, beltData[class].Data, beltId)
			ply.CPBeltCos[class] = true
		--end
	end
end

function PLUGIN:PostPlayerDraw(ply)
	if not ply.Alive(ply) or ply.Team(ply) != TEAM_CP then 
		if ply.CPBeltCos then
			for v,k in pairs(ply.CPBeltCos) do
				RemoveCosmetic(ply, ply, "belt_"..v)
			end

			ply.CPBeltCos = nil
		end

		return 
	end

	beltCheck(ply)
end
