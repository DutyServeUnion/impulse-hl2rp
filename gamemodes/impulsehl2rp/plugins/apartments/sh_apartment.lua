-- Apartment Class
Apartment = {}
Apartment.__index = Apartment

-- Constructor
function Apartment:New(name, rent)
    local newApartment = {
        name = name or "Apartment 404.",
        doors = {},
        owner = nil,
        inhabitants = {},
        rent = rent or 0
    }

    setmetatable(newApartment, Apartment)

    return newApartment
end

-- Metamagic
setmetatable(Apartment, {
    __call = Apartment.New
})

-- Methods
function Apartment:IsAvaiable()
    return self.owner != nil
end

function Apartment:PurgeInhabitants()
    for v,k in pairs(self:GetAllInhabitants()) do
        self:RemoveInhabitant(k)
        k:Notify("You left " .. self:ToString() .. ", due to the owner selling the apartment.")
    end

    self:RemoveApartmentOwner()
end

function Apartment:RemoveApartmentOwner()
    if not self.owner then return end
    if not self.owner:IsPlayer() then return end

    self.owner:SetSyncVar(SYNC_APT_ISOWNER, false, true)
    for v,k in pairs(self.doors) do
        self.owner:RemoveDoorMaster(Entity(k))
    end
    self.owner = nil
end

function Apartment:SetApartmentOwner(ply)
    self:RemoveApartmentOwner()        
    self.owner = ply

    ply:SetSyncVar(SYNC_APT_ISOWNER, true, true)
    for v,k in pairs(self.doors) do
        self.owner:SetDoorMaster(Entity(k))
    end
    
    ply:Notify("You are now the owner of " .. self:ToString())
end

function Apartment:AddInhabitant(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    
    table.insert(self.inhabitants, ply:EntIndex())
    
    for v, k in pairs(self.doors) do
        -- Entity(k):SetSyncVar(SYNC_DOOR_OWNERS, self.inhabitants, true)
        ply:SetDoorUser(Entity(k))
    end
end

function Apartment:RemoveInhabitant(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    table.RemoveByValue(self.inhabitants, ply:EntIndex())

    for v, k in pairs(self.doors) do
        -- if #self.inhabitants == 0 then
        --     Entity(k):SetSyncVar(SYNC_DOOR_OWNERS, nil, true)
        -- else
        --     Entity(k):SetSyncVar(SYNC_DOOR_OWNERS, self.inhabitants, true)
        -- end
        ply:RemoveDoorUser(Entity(k))
    end
end

function Apartment:AddDoor(door)
    if SERVER then
        door:SetSyncVar(SYNC_DOOR_BUYABLE, false, true)
        door:SetSyncVar(SYNC_DOOR_GROUP, nil, true)
        door:SetSyncVar(SYNC_DOOR_NAME, nil, true)
        door:DoorLock()
    end

    table.insert(self.doors, door:EntIndex())
end

function Apartment:RemoveDoor(door)
    table.RemoveByValue(self.doors, door:EntIndex())
    door.IsApartmentDoor = false

    if SERVER then
        door:SetSyncVar(SYNC_DOOR_BUYABLE, nil, true)
        door:SetSyncVar(SYNC_DOOR_GROUP, nil, true)
        door:SetSyncVar(SYNC_DOOR_NAME, nil, true)
        door:DoorUnlock()
    end
end

function Apartment:GetAllInhabitants()
    local inhabitantList = {}

    for v, k in pairs(self.inhabitants) do
        table.insert(inhabitantList, Entity(k))
    end

    return inhabitantList
end

function Apartment:Notify(message)
    self.owner:Notify(message)
    for v, k in pairs(self:GetAllInhabitants()) do
        k:Notify(message)
    end
end

function Apartment:ToString()
    return "Apartment " .. self.name
end
