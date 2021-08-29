local function OpenAddApartmentDerma()
    local ply = LocalPlayer()

    if #impulse.ApartmentBlocks == 0 then
        ply:Notify("Add a city block first.")

        return
    end

    local selectedBlock
    local mainFrame = vgui.Create("DFrame")
    mainFrame:SetTitle("Apartment Creation")
    mainFrame:SetSize(400, 300)
    mainFrame:Center()
    mainFrame:MakePopup()
    local nameInput = vgui.Create("DTextEntry", mainFrame)
    nameInput:SetPos(50, 50)
    nameInput:SetSize(300, 20)
    local blockList = vgui.Create("DComboBox", mainFrame)

    for v, k in pairs(impulse.ApartmentBlocks) do
        blockList:AddChoice(k.name)
    end

    blockList:SetSize(300, 20)
    blockList:SetPos(50, 100)

    blockList.OnSelect = function(self, index, value)
        selectedBlock = index
    end

    local submit = vgui.Create("DButton", mainFrame)
    submit:SetPos(50, 200)
    submit:SetSize(300, 50)
    submit:SetText("Add apartment")

    submit.DoClick = function()
        net.Start("impulseHL2RPApartmentNew")
        net.WriteString(nameInput:GetValue())
        print(selectedBlock)
        net.WriteInt(selectedBlock, 8)
        net.SendToServer()
        mainFrame:Close()
    end
end

net.Receive("impulseHL2RPApartmentNewDerma", function(len, ply)
    OpenAddApartmentDerma()
end)

net.Receive("impulseHL2RPApartmentNewBroadcast", function(len, ply)
    local name = net.ReadString()
    local block = net.ReadInt(8)
    impulse.ApartmentBlocks[block]:AddApartment(Apartment(name))
end)

local function OpenAddDoorToApartmentDerma()
    local ply = LocalPlayer()
    local trace = {}
    trace.start = ply:EyePos()
    trace.endpos = trace.start + ply:GetAimVector() * 200
    trace.filter = ply
    local door = util.TraceLine(trace).Entity

    local apartmentBlocks = impulse.ApartmentBlocks
    local mainFrame = vgui.Create("DFrame")
    mainFrame:SetTitle("Adding door to apartment.")
    mainFrame:SetSize(400, 300)
    mainFrame:Center()
    mainFrame:MakePopup()
    local blockList = vgui.Create("DComboBox", mainFrame)

    for v, k in pairs(apartmentBlocks) do
        blockList:AddChoice(k.name)
    end

    blockList:SetSize(300, 20)
    blockList:SetPos(50, 100)
    local aptList = vgui.Create("DComboBox", mainFrame)
    aptList:SetSize(300, 20)
    aptList:SetPos(50, 150)

    aptList.OnSelect = function(self, index, value)
        selectedApt = index
        print(selectedApt)
    end

    blockList.OnSelect = function(self, index, value)
        aptList:Clear()
        selectedBlock = index
        print(selectedBlock)

        for v, k in pairs(apartmentBlocks[index].apartments) do
            aptList:AddChoice(k.name)
        end
    end

    local submit = vgui.Create("DButton", mainFrame)
    submit:SetPos(50, 200)
    submit:SetSize(300, 50)
    submit:SetText("Add door to apartment")
    submit:SetEnabled(true)

    submit.DoClick = function()
        net.Start("impulseHL2RPApartmentAddDoor")
        net.WriteEntity(door)
        net.WriteInt(selectedBlock, 8)
        net.WriteInt(selectedApt, 8)
        net.SendToServer()
        mainFrame:Close()
    end
end

net.Receive("impulseHL2RPApartmentAddDoorDerma", function()
    OpenAddDoorToApartmentDerma()
end)

net.Receive("impulseHL2RPApartmentAddDoorBroadcast", function()
    local door = net.ReadEntity()
    local blockNr = net.ReadInt(8)
    local aptNr = net.ReadInt(8)

    local block = impulse.ApartmentBlocks[blockNr]
    local apartment = block.apartments[aptNr]
    apartment:AddDoor(door)
end)

net.Receive("impulseHL2RPApartmentRemoveDoorBroadcast", function()
    local traceEnt = net.ReadEntity()

    for v, k in pairs(impulse.ApartmentBlocks) do
        for a, b in pairs(k.apartments) do
            b:RemoveDoor(traceEnt)
        end
    end
end)

local function OpenAddBlockDerma()
    Derma_StringRequest("Add City Block", "Choose a fancy name for your city block.", "404 Block", function(text)
        net.Start("impulseHL2RPApartmentAddBlock")
        net.WriteString(text)
        net.SendToServer()
    end)
end

net.Receive("impulseHL2RPApartmentAddBlockDerma", function()
    OpenAddBlockDerma()
end)

net.Receive("impulseHL2RPApartmentAddBlockBroadcast", function()
    table.insert(impulse.ApartmentBlocks, ApartmentBlock(net.ReadString()))
end)
