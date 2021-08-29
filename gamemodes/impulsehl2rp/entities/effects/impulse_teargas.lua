function EFFECT:Init(data)
	local emitter = ParticleEmitter(data:GetOrigin())
	local canister = data:GetEntity()
	local rate = 0.33
	local time = 35
	local reps = math.ceil(time / rate)
	local rep = 0

	timer.Create("TearGasFX-"..math.random(1, 10000), 0.33, reps, function() -- hacky ik ik :(
		rep = rep + 1

		if not emitter then
			return
		end

		if rep >= reps then
			emitter:Finish()
			return
		end

		if not IsValid(canister) then
			return
		end

		local particle = emitter:Add("particle/smokesprites_000"..math.random(1,9), canister:GetPos())

		if particle then
			particle:SetVelocity(canister:GetForward() * 65)
			particle:SetDieTime(math.Rand(7, 15))
			particle:SetStartAlpha(math.Rand(15, 15))
			particle:SetEndAlpha(0)
			particle:SetStartSize(math.Rand(13, 50))
			particle:SetEndSize(math.Rand(360, 420))
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-1, 1))
			particle:SetColor(197, 222, 177)
			particle:SetAirResistance(100) 
			particle:SetGravity(VectorRand():GetNormalized() * math.random(5, 30)+ Vector(0, math.random(5, 30), math.random(5, 55))) 	
			particle:SetCollide(false)
		end
	end)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
