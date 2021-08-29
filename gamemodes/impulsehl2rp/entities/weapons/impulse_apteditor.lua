AddCSLuaFile()

if( CLIENT ) then
	SWEP.PrintName = "Apartment Editor"
	SWEP.Slot = 0
	SWEP.SlotPos = 0
	SWEP.CLMode = 0
end
SWEP.HoldType = "fists"

SWEP.Category = "impulse"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 0	
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0 	
SWEP.Primary.ClipSize		= -1	
SWEP.Primary.DefaultClip	= -1	
SWEP.Primary.Automatic   	= false	
SWEP.Primary.Ammo         	= "none"
SWEP.IsAlwaysRaised = true
 
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
SWEP.NextGo = 0

if SERVER then
	function SWEP:Equip(owner)
		if not owner:IsAdmin() then
			owner:StripWeapon("impulse_apteditor")
		end
	end
	function SWEP:PrimaryAttack()
	end

	function SWEP:Reload()
	end
	
	function SWEP:SecondaryAttack()
	end
else
	function SWEP:PrimaryAttack()
		if self.NextGo > CurTime() then return end
		
		local traceEnt = LocalPlayer():GetEyeTrace().Entity

		if not IsValid(traceEnt) or not traceEnt:IsDoor() then
			return self.Owner:Notify("Invalid entity selection. Look at a door.")
		end

		self.Doors = self.Doors or {}
		table.insert(self.Doors, traceEnt:EntIndex() - game.MaxPlayers())

		if #self.Doors == 1 then
			self.State = "Front door registered, awaiting more doors or an export."

			surface.PlaySound("buttons/blip1.wav")
		else
			self.State = #self.Doors.." doors registered."

			surface.PlaySound("buttons/blip1.wav")
		end

		self.NextGo = CurTime() + .3
	end

	function SWEP:SecondaryAttack()
		if self.NextGo > CurTime() then return end

		self.Doors = {}
		self.State = nil
		self.Exporting = false

		surface.PlaySound("buttons/button10.wav")
		self.NextGo = CurTime() + .3
	end

	function SWEP:Reload()
		if #self.Doors > 0 and not self.Exporting then
			self.Exporting = true


			local doors = "{"
			local size = #self.Doors

			for v,k in pairs(self.Doors) do
				doors = doors .. k

				if v != size then
					doors = doors .. ", "
				end
			end
			doors = doors .. "}"

			Derma_StringRequest("impulse", "Enter apartment number:", nil, function(name)
				local output = '{name = "'..name..'", doors = '..doors..'}'
				
				chat.AddText("-----------------OUTPUT-----------------")
				chat.AddText(output)
				chat.AddText("Output copied to clipboard.")
				SetClipboardText(output)

				self.Doors = {}
				self.State = nil
				self.Exporting = false
			end)
		end
	end

	function SWEP:DrawHUD()
		draw.SimpleText("LEFT: Register door, RIGHT: Reset, RELOAD: Export", "BudgetLabel", 100, 100)
		draw.SimpleText("STATE: "..(self.State or "Nothing selected"), "BudgetLabel", 100, 120)
		draw.SimpleText("Click on the main door to begin, then click on\nthe other doors.", "BudgetLabel", 100, 140)
	end
end
