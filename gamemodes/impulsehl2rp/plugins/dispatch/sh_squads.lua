function meta:SquadCanMake()
	local t = self:Team()

	if t != TEAM_CP and t != TEAM_OTA then
		return false
	end

	local rank = self:GetTeamRank()

	if not rank or rank == 0 then
		return false
	end

	if t == TEAM_CP and rank < RANK_I1 then
		return false
	end

	if t == TEAM_OTA and rank < RANK_LDR then
		if self:GetTeamClass() != CLASS_SENTINEL and self:GetTeamRank() != RANK_EOW then
			return false
		end
	end

	if self:GetSyncVar(SYNC_SQUAD_ID) then
		return false
	end

	local c = 0
	local known = {}
	for v,k in pairs(team.GetPlayers(t)) do
		local sid = k:GetSyncVar(SYNC_SQUAD_ID)
		if sid and not known[sid] then
			c = c + 1
			known[sid] = true
		end
	end

	return c < (self:Team() == TEAM_CP and impulse.Config.MaxSquadsCP or impulse.Config.MaxSquadsOTA)
end

function meta:SquadCanJoin(squadId)
	local t = self:Team()

	if t != TEAM_CP and t != TEAM_OTA then
		return false
	end

	local rank = self:GetTeamRank()

	if not rank or rank == 0 then
		return false
	end

	if self:GetSyncVar(SYNC_SQUAD_ID) then
		return false
	end

	local c = 0
	for v,k in pairs(team.GetPlayers(t)) do
		local id = k:GetSyncVar(SYNC_SQUAD_ID)
		if id and id == squadId then
			c = c + 1
		end
	end

	if c == 0 then
		return false
	end

	return c < (self:Team() == TEAM_CP and impulse.Config.MaxSquadSizeCP or impulse.Config.MaxSquadSizeOTA)
end

function meta:SquadCanClaim()
	local t = self:Team()

	if t != TEAM_CP and t != TEAM_OTA then
		return false
	end

	local rank = self:GetTeamRank()

	if not rank or rank == 0 then
		return false
	end

	local squad = self:GetSyncVar(SYNC_SQUAD_ID)

	if not squad then
		return false
	end

	if t == TEAM_CP and rank < RANK_I1 then
		return false
	end

	if t == TEAM_OTA and rank < RANK_LDR then
		return false
	end

	local highestRank = 0
	local hasLeader = false
	for v,k in pairs(team.GetPlayers(t)) do
		local sqd = k:GetSyncVar(SYNC_SQUAD_ID)

		if sqd and sqd == squad then
			if k:GetSyncVar(SYNC_SQUAD_LEADER) then
				hasLeader = true
			end

			local r = k:GetTeamRank()

			if r and r != 0 and r > highestRank then
				highestRank = r
			end
		end
	end

	if hasLeader then
		return false
	end

	if rank < highestRank then
		return false
	end

	return true
end

function meta:GetSquad()
	local t = self:Team()

	if t != TEAM_CP and t != TEAM_OTA then
		return false
	end

	local rank = self:GetTeamRank()

	if not rank or rank == 0 then
		return false
	end

	local squad = self:GetSyncVar(SYNC_SQUAD_ID)

	if not squad then
		return false
	end

	return true, squad
end
