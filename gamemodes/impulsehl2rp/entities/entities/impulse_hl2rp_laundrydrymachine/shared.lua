ENT.Base = "base_gmodentity"
ENT.Type = "anim"

ENT.PrintName		= "Dryer"
ENT.Author			= "aLoneWitness"
ENT.Contact			= "@aLoneWitness#8734"
ENT.Purpose			= "Laundry machine to wash laundry in."
ENT.Instructions	= "Laundry machine to wash laundry in."
ENT.Category 		= "impulse - factory"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.maxCapacity = 4
ENT.lastTouchTime = 0
ENT.status = {}
ENT.percentage = 0
ENT.isWashing = false

ENT.HUDName = "Dryer"
ENT.HUDDesc = "Dries wet laundry."
ENT.DryingTime = 10

LAUNDRYSTATE_EMPTY = 0
LAUNDRYSTATE_PROCESSING = 1
LAUNDRYSTATE_DONE = 2
LAUNDRYSTATE_DISPENSING = 3

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Laundry1")
	self:NetworkVar("Int", 1, "Laundry2")
	self:NetworkVar("Int", 2, "Laundry3")
	self:NetworkVar("Int", 3, "Laundry4")
	//self:NetworkVar("Int", 1, "StartTime")
end

