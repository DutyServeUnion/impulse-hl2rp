
// Block Class
ApartmentBlock = {}
ApartmentBlock.__index = ApartmentBlock

// Constructor
function ApartmentBlock:New(name)
    local newBlock = {
        name = name or "Block 404",
        apartments = {}
    }

    setmetatable(newBlock, ApartmentBlock)

    return newBlock
end

// Metamethods
setmetatable( ApartmentBlock, { __call = ApartmentBlock.New } )

// Methods
function ApartmentBlock:Notify(message)
    for v,k in pairs(self.apartments) do
        k:Notify(message)
    end
end

function ApartmentBlock:AddApartment(apartment)
    table.insert(self.apartments, apartment)
end

function ApartmentBlock:RemoveApartment(apartment)
    table.RemoveByValue(self.apartments, apartment)
end

function ApartmentBlock:GetInhabitants()
    local inhabs = {}
    for v,k in pairs(self.apartments) do
        table.Merge(inhabs, k.inhabitants)
    end
    return inhabs
end

function ApartmentBlock:GetApartments()
    return self.apartments
end

