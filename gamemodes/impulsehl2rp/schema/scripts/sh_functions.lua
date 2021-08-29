local entityMeta = FindMetaTable("Entity")

function meta:IsRebel() -- if u want a smarter is rebel then make it SEPERATE to this func, this function should just be based off team,class and bodygroups/skins/models.
	if not self:Team() == TEAM_CITIZEN or not self:Team() == TEAM_VORT then
		return false
	end

	if self:Team() == TEAM_CITIZEN then
		if self:GetBodygroup(1) == 6 then -- if torso is rebel
			return true
		end
	end

	if self:GetModel() == "models/vortigaunt.mdl" then
		return true
	end

	return false
end

CRIME_ANTCIITIZEN = 1
CRIME_VORT = 2
CRIME_WEAPON = 3
CRIME_CONTRABAND = 4
CRIME_EVASION = 5
CRIME_CURFEW = 6
CRIME_BOL = 7

CRIME_NICENAMES = {
	[CRIME_ANTCIITIZEN] = "Anti-Citizen",
	[CRIME_VORT] = "Unregistered Biotic",
	[CRIME_WEAPON] = "High Tier Contraband",
	[CRIME_EVASION] = "Surveillance Evasion",
	[CRIME_CURFEW] = "Curfew Violation",
	[CRIME_BOL] = "BOL Target"
}

local allowedWeps = {
	["ls_vort"] = true,
	["ls_snowball"] = true,
	["ls_broom"] = true
}

local strsub = string.sub
function meta:IsRebelSmart()
	local isCriminal = false
	local idKnown = true
	local firstCrime
	local crimes = {}

	if self.IsCP(self) then
		return false, false, {}
	end

	if self.GetSyncVar(self, SYNC_COS_FACE, 0) == 4 then -- has facewrap on
		isCriminal = true
		idKnown = false
		firstCrime = firstCrime or CRIME_EVASION
		crimes[CRIME_EVASION] = true
	end

	--if impulse.Dispatch.GetCityCode() >= CODE_JW and  then this would be too annoying imo
	--	isCriminal = true
	--end

	if idKnown and self:IsDispatchBOL() then
		isCriminal = true
		firstCrime = firstCrime or CRIME_BOL
		crimes[CRIME_BOL] = true
	end

	local wep = self.GetActiveWeapon(self)

	if IsValid(wep) then
		local wepclass = wep.GetClass(wep)

		if strsub(wepclass, 1, 3) == "ls_" and not allowedWeps[wepclass] then
			isCriminal = true
			firstCrime = firstCrime or CRIME_WEAPON
			crimes[CRIME_WEAPON] = true
		end
	end

	local t = self.Team(self)

	if t == TEAM_CITIZEN and self.GetBodygroup(self, 1) == 6 then -- rebel suit
		isCriminal = true
		firstCrime = firstCrime or CRIME_ANTCIITIZEN
		crimes[CRIME_ANTCIITIZEN] = true
	elseif t == TEAM_VORT and self.GetModel(self) != "models/vortigaunt_slave.mdl" then -- unshackled vort
		isCriminal = true
		firstCrime = firstCrime or CRIME_VORT
		crimes[CRIME_VORT] = true
	end

	if self.GasSafe or self.HasHelmet or self.HasOTAVest then
		isCriminal = true
		firstCrime = firstCrime or CRIME_ANTCIITIZEN
		crimes[CRIME_ANTCIITIZEN] = true
	end

	return isCriminal, idKnown, crimes, firstCrime
end

function meta:GetDigits()
	if not self:IsCP() or self:Team() == TEAM_CA then return end

	local digits = string.Right(self:Name(), 4)
	digits = tonumber(digits)

	if digits and isnumber(digits) then
		return digits
	end
end

function meta:IsCPCommand()
	local rank = self:GetTeamRank()
	if not rank then return false end

	if self:Team() == TEAM_CP then
		if rank >= RANK_OFC then
			return true
		end
	elseif self:Team() == TEAM_OTA then
		if rank >= RANK_LDR then
			return true
		end
	end

	return false
end

function meta:CanUseTerminalConvicts()
	if not self:Team() == TEAM_CP then
		return false
	end

	if self:IsCPCommand() then
		return true
	end

	local class = self:GetTeamClass()

	if class and class == CLASS_JURY then
		return true
	end
	
	return false
end

function impulse.CanNexusRaid()
	local cps = #team.GetPlayers(TEAM_CP)
	local otas = #team.GetPlayers(TEAM_OTA)
	local players = player.GetCount()
	local baddies = cps + otas

	if baddies < 12 then
		return false
	end

	if otas < 3 then
		return false
	end

	if players < 40 then
		return false
	end

	return true
end

local gasMaskTeams = {
	[TEAM_OTA] = true,
	[TEAM_CP] = true
}

function meta:HasGasMask()
	if gasMaskTeams[self.Team(self)] then
		return true
	end

	if self.GasSafe then
		return true
	end

	if self.GetMoveType(self) == MOVETYPE_NOCLIP then
		return true
	end

	return false
end

if SERVER then
	function entityMeta:EmitChargedSounds(charges)
		local queueTime = 0
		local duration = 0
		local speechBreak = 0.5

		table.insert(charges, 1, {sound = "npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav"})
		table.insert(charges, {sound = "npc/overwatch/radiovoice/youarejudgedguilty.wav"})

		for v,k in pairs(charges) do
			duration = SoundDuration(k.sound)
			
			timer.Simple(queueTime, function()
				if not IsValid(self) then return end

				self:EmitSound(k.sound)
			end)

			queueTime = queueTime + duration + speechBreak
		end

		return queueTime
	end

	function meta:AddRewardRation(amount)
		if not self.RewardRation then
			self:Notify("Your reward ration is now ready to be collected at the ration distribution center.")
			self:SurfacePlaySound("buttons/blip1.wav")
		end

		self.RewardRation = (self.RewardRation or 0) + amount
	end
end
