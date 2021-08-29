local nextName
local tbNPCs = {}
hook.Add("PlayerSpawnNPC","CPspawngetname",function(pl,name,wepName) nextName = name end)
 
hook.Add("PlayerSpawnedNPC","CPspawnupdatemodel",function(pl,npc)
        if(!nextName) then return end
        if(tbNPCs[nextName]) then
                local min,max = npc:GetCollisionBounds()
                local hull = npc:GetHullType()
                npc:SetModel(tbNPCs[nextName])
                npc:SetSolid(SOLID_BBOX)
                npc:SetHullType(hull)
                npc:SetHullSizeNormal()
                npc:SetCollisionBounds(min,max)
                npc:DropToFloor()
        end
        nextName = nil
end)
 
local function AddNPC(category,name,class,model,keyvalues,skin,weapons)
        list.Set("NPC",name,{Name = name,Class = class,Skin = skin,Model = model,Category = category,KeyValues = keyvalues,Weapons = weapons})
        tbNPCs[name] = model
end


AddNPC("Metropolice Pack","Arctic","npc_metropolice","models/DPFilms/Metropolice/arctic_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Badass","npc_metropolice","models/DPFilms/Metropolice/badass_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Spec Ops","npc_metropolice","models/DPFilms/Metropolice/biopolice.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","City 08 Police","npc_metropolice","models/DPFilms/Metropolice/c08cop.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Civil Medic","npc_metropolice","models/DPFilms/Metropolice/civil_medic.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Black Metro Police","npc_metropolice","models/DPFilms/Metropolice/blacop.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Skull Squad","npc_metropolice","models/DPFilms/Metropolice/blacop.mdl",{["manhacks"] = 0},1,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Beta Metro Police","npc_metropolice","models/DPFilms/Metropolice/hl2beta_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Blue eyed Metro Police","npc_metropolice","models/DPFilms/Metropolice/hl2concept.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","HD Barney","npc_barney","models/DPFilms/Metropolice/HD_Barney.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","HD Barney ep1","npc_barney","models/DPFilms/Metropolice/HD_Barney.mdl",{["manhacks"] = 0},1,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","HD Metro Police","npc_metropolice","models/DPFilms/Metropolice/HDpolice.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Hunter Squad","npc_metropolice","models/DPFilms/Metropolice/hunter_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Phoenix Metro Police","npc_metropolice","models/DPFilms/Metropolice/phoenix_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Breen Troops","npc_metropolice","models/DPFilms/Metropolice/police_bt.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Elite Shock Unit","npc_metropolice","models/DPFilms/Metropolice/elite_police.mdl",{["manhacks"] = 1},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Concept Trenchcoat","npc_metropolice","models/DPFilms/Metropolice/rtb_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Female Metro Police","npc_metropolice","models/DPFilms/Metropolice/female_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Fragger Police","npc_metropolice","models/DPFilms/Metropolice/police_fragger.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Trenchcoat Metro Police","npc_metropolice","models/DPFilms/Metropolice/policetrench.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Rogue Police","npc_metropolice","models/DPFilms/Metropolice/rogue_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Resistance Police","npc_citizen","models/DPFilms/Metropolice/resistance_police.mdl",{["citizentype"] = CT_UNIQUE},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Retro Police","npc_metropolice","models/DPFilms/Metropolice/retrocop.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Steampunk Police","npc_metropolice","models/DPFilms/Metropolice/steampunk_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","TF2 RED Police","npc_metropolice","models/DPFilms/Metropolice/tf2_metrocop.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","TF2 BLU Police","npc_metropolice","models/DPFilms/Metropolice/tf2_metrocop.mdl",{["manhacks"] = 0},2,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Tribal Police","npc_metropolice","models/DPFilms/Metropolice/tribal_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Tron Styled Blue","npc_metropolice","models/DPFilms/Metropolice/tron_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Tron Styled Orange","npc_metropolice","models/DPFilms/Metropolice/tron_police.mdl",{["manhacks"] = 0},1,{"weapon_smg1","weapon_pistol"})
AddNPC("Metropolice Pack","Urban Camo","npc_metropolice","models/DPFilms/Metropolice/urban_police.mdl",{["manhacks"] = 0},0,{"weapon_smg1","weapon_pistol"})

