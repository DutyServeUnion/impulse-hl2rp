local ITEM = {}

ITEM.UniqueID = "item_tv"
ITEM.Name = "Television"
ITEM.Desc =  "A small portable television. Can receive broadcasts."
ITEM.Category = "Tools"
ITEM.Model = Model("models/weapons/w_c4_planted.mdl")
ITEM.FOV = 10.308022922636
ITEM.CamPos = Vector(-0.57306587696075, -91.117477416992, 98.567337036133)
ITEM.NoCenter = true
ITEM.Weight = 4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = true
ITEM.CanStack = false

ITEM.UseName = "Place"
ITEM.UseWorkBarTime = 1
ITEM.UseWorkBarName = "Placing..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "weapons/c4/c4_plant.wav"

function ITEM:OnUse(ply, door)
	local freqs = {82.4, 87.9, 104.4, 115.4}
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	impulse.IEDS = impulse.IEDS or {}

	local ied = ents.Create("impulse_usable")
	ied:SetModel(self.Model)
	ied:SetPos(tr.HitPos)
	ied:SetAngles(ply:GetAngles())

	local phys = ied:GetPhysicsObject()

	if phys and IsValid(phys) then
		phys:SetMass(20)	
	end

	local freq = freqs[math.random(1, #freqs)]

	ied.Placer = ply
	ied.Freq = freq

	function ied:Use(ply)
		if self.Placer == ply then
			ply:GiveInventoryItem("item_ied")
			ply:Notify("You have disarmed and picked up the IED.")
			table.RemoveByValue(impulse.IEDS, self)

			self:Remove()
		end
	end

	function ied:Kaboom()
		self:EmitSound("weapons/c4/c4_beep1.wav", 90)
		table.RemoveByValue(impulse.IEDS, self)

		timer.Simple(1.5, function()
			if not IsValid(self) then
				return
			end

		    local debris = {}

	        for i=1,9 do
	        	local flyer = ents.Create("prop_physics")
	        	flyer:SetPos(self:GetPos())

	        	if i > 4 then
	        		flyer:SetModel("models/props_debris/wood_chunk08b.mdl")
	        	else
	        		flyer:SetModel("models/combine_helicopter/bomb_debris_"..math.random(2, 3)..".mdl")
	        	end

	        	flyer:Spawn()
	        	flyer:Ignite(30)

	        	local phys = flyer:GetPhysicsObject()

	        	if phys and IsValid(phys) then
	        		phys:SetVelocity(Vector(math.random(-150, 150), math.random(-150, 150), math.random(-150, 150)))
	        	end

	        	table.insert(debris, flyer)
	        end

	        timer.Simple(40, function()
		        for v,k in pairs(debris) do
		        	if IsValid(k) then
		        		k:Remove()
		        	end
		        end
		    end)

			local explodeEnt = ents.Create("env_explosion")
	        explodeEnt:SetPos(self:GetPos())

	        if IsValid(self.Placer) then
	        	explodeEnt:SetOwner(self.Placer)
	        end 

	        explodeEnt:Spawn()
	        explodeEnt:SetKeyValue("iMagnitude", "325")
	        explodeEnt:Fire("explode", "", 0)

	        local fire = ents.Create("env_fire")
	        fire:SetPos(self:GetPos())
	        fire:Spawn()
	        fire:Fire("StartFire")

	        timer.Simple(60, function()
	        	if IsValid(fire) then
	        		fire:Remove()
	        	end
	        end)

			local effectData = EffectData()
			effectData:SetOrigin(self:GetPos())
			util.Effect("Explosion", effectData)

	        self:EmitSound("weapons/c4/c4_explode1.wav", 500)
	        self:EmitSound("weapons/c4/c4_exp_deb1.wav", 125)
	        self:EmitSound("weapons/c4/c4_exp_deb2.wav", 125)
	        self:EmitSound("ambient/atmosphere/terrain_rumble1.wav", 108)

	        for v,k in pairs(player.GetAll()) do
	        	k:SurfacePlaySound("ambient/levels/streetwar/city_battle7.wav")
	        end

	        util.ScreenShake(self:GetPos(), 4, 2, 2.5, 100000)

	        self:Remove()

	        local pos = self:GetPos()

	        timer.Simple(1, function()
	        	for v,k in pairs(ents.FindByClass("prop_ragdoll")) do
	        		if k:GetPos():DistToSqr(pos) < (1200 ^ 2) then
	        			k:Ignite(40)
	        		end
	        	end
	        end)
	    end)
	end

	ied:Spawn()

	table.insert(impulse.IEDS, ied)

	ply:Notify("IED touch-off frequency is "..freq..".")

	return true
end

impulse.RegisterItem(ITEM)
