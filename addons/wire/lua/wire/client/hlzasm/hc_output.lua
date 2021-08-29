--------------------------------------------------------------------------------
-- HCOMP / HL-ZASM compiler
--
-- Code resolver and output generator
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
-- Resolve a single block/opcode (offsets and labels in it)
function HCOMP:Resolve(block)
  -- Set offset for the block
  block.Offset = self.WritePointer
  self:SetLabel("__PTR__",self.WritePointer)

  -- Set pointer offset
  block.PointerOffset = self.PointerOffset

  -- Label precedes the opcode and the data in the leaf
  if block.Label then
    if (self.Settings.SeparateDataSegment == true) and (block.Data) then

    else
      block.Label.Value = self.WritePointer
    end
  end

  -- Account for the opcode generated by the block
  if block.Opcode then
    if not self.Settings.FixedSizeOutput then -- Variable-sized instructions
      -- Write opcode
      self.WritePointer = self.WritePointer + 1
      -- Write RM if more than 1 operand
      if #block.Operands > 0 then self.WritePointer = self.WritePointer + 1 end
      -- Write all segment prefixes and constant operands
      for i=1,#block.Operands do
        if block.Operands[i].Segment       then self.WritePointer = self.WritePointer + 1 end
        if block.Operands[i].Constant      then self.WritePointer = self.WritePointer + 1 end
        if block.Operands[i].MemoryPointer then self.WritePointer = self.WritePointer + 1 end
        if block.Operands[i].Memory        then self.WritePointer = self.WritePointer + 1 end
      end
    else -- Fixed-size instructions
      self.WritePointer = self.WritePointer + 6
    end
  end

  -- Account for extra data in the block
  if block.Data then
    if self.Settings.SeparateDataSegment == true then
      for index,value in ipairs(block.Data) do
        if isnumber(value)then -- Data is a number
          self.DataPointer = self.DataPointer + 1
        elseif istable(value)then -- Data is a constant expression
          self.WritePointer = self.DataPointer + 1
        else -- Data is a string
          self.DataPointer = self.DataPointer + #value
        end
      end
    else
      for index,value in ipairs(block.Data) do
        if isnumber(value)then -- Data is a number
          self.WritePointer = self.WritePointer + 1
        elseif istable(value)then -- Data is a constant expression
          self.WritePointer = self.WritePointer + 1
        else -- Data is a string
          self.WritePointer = self.WritePointer + #value
        end
      end
    end
  end

  -- Zero padding after the block
  if block.ZeroPadding then
    if self.Settings.SeparateDataSegment == true then

    else
      self.WritePointer = self.WritePointer + block.ZeroPadding
    end
  end

  -- Special marker to change write pointer
  if block.SetWritePointer then
    self.WritePointer = block.SetWritePointer
  end

  -- Special marker to change pointer offset
  if block.SetPointerOffset then
    self.PointerOffset = block.SetPointerOffset
  end

  -- Output the block if required
  if self.Settings.OutputResolveListing then
    self:PrintBlock(block,"rlist")
  end
  -- Output the block as library if required
  if self.Settings.GenerateLibrary then
--    self:PrintBlock(block,"lib",true)
  end
  return false
end




--------------------------------------------------------------------------------
-- Output a single block to the output stream (for library mode)
function HCOMP:OutputLibrary(block)
  -- Write label
  if block.Label then
    if self.DBString then
      self:PrintLine("lib",self.DBString)
      self.DBString = nil
    end
    if not self.LabelLookup[block.Label.Name] then
      self.LabelLookup[block.Label.Name] = "_"..self.LabelLookupCounter
      self.LabelLookupCounter = self.LabelLookupCounter + 1
    end
    self:PrintLine("lib",self.LabelLookup[block.Label.Name]..":")
  end

  -- Resolve constant values in the block
  if block.Opcode then
    for i=1,#block.Operands do
      if block.Operands[i].Constant and (not tonumber(block.Operands[i].Constant)) then
        if block.PointerOffset ~= 0
        then block.Operands[i].Constant = self:PrintTokens(block.Operands[i].Constant).."+"..block.PointerOffset
        else block.Operands[i].Constant = self:PrintTokens(block.Operands[i].Constant)
        end
      end

      if block.Operands[i].MemoryPointer and (not tonumber(block.Operands[i].MemoryPointer)) then
        if block.PointerOffset ~= 0
        then block.Operands[i].MemoryPointer = self:PrintTokens(block.Operands[i].MemoryPointer).."+"..block.PointerOffset
        else block.Operands[i].MemoryPointer = self:PrintTokens(block.Operands[i].MemoryPointer)
        end
      end
    end
  end

  -- Resolve constant values in data
  if block.Data then
    for index,value in ipairs(block.Data) do
      if istable(value)then -- Data is a constant expression
        block.Data[index] = self:PrintTokens(value)
      end
    end
  end

  -- Write binary code
  local tempWriteByte = self.WriteByte
  self.WriteByte = function(self,value,block)
    if not self.DBString then
      self.DBString = "db "..value
    else
      if #self.DBString > 40 then
        self:PrintLine("lib",self.DBString)
        self.DBString = "db "..value
      else
        self.DBString = self.DBString..","..value
      end
    end
  end
  self:WriteBlock(block)
  self.WriteByte = tempWriteByte
end




--------------------------------------------------------------------------------
-- Output a single block to the output stream
function HCOMP:Output(block)
  -- Generate library output
  if self.Settings.GenerateLibrary then
    self:OutputLibrary(block)
    return
  end

  -- Resolve constant values in the block
  if block.Opcode then
    for i=1,#block.Operands do
      if block.Operands[i].Constant and (not tonumber(block.Operands[i].Constant)) then
        -- Prepare expression to parse
        self:RestoreParserState(block.Operands[i].Constant)
        -- Try to parse the expression
        local c,v = self:ConstantExpression(true)
        if not c then
          if (#block.Operands[i].Constant == 1) and
             (block.Operands[i].Constant[1].Type == self.TOKEN.IDENT) then
            self:Error("Undefined label or variable: "..block.Operands[i].Constant[1].Data,block)
          elseif (#block.Operands[i].Constant == 2) and
             (block.Operands[i].Constant[1].Type == self.TOKEN.AND) and
             (block.Operands[i].Constant[2].Type == self.TOKEN.IDENT) then
            self:Error("Undefined function or array: "..block.Operands[i].Constant[2].Data,block)
          else
            self:Error("Must be constant expression: "..self:PrintTokens(block.Operands[i].Constant),block)
          end
        end
        -- Set the result
        if v
        then block.Operands[i].Constant = v + block.PointerOffset
        else block.Operands[i].Constant = self.Settings.MagicValue
        end
      end

      if block.Operands[i].MemoryPointer and (not tonumber(block.Operands[i].MemoryPointer)) then
        -- Prepare expression to parse
        self:RestoreParserState(block.Operands[i].MemoryPointer)
        -- Try to parse the expression
        local c,v = self:ConstantExpression(true)
        if not c then
          if (#block.Operands[i].MemoryPointer == 1) and
             (block.Operands[i].MemoryPointer[1].Type == self.TOKEN.IDENT) then
            self:Error("Undefined label or variable: "..block.Operands[i].MemoryPointer[1].Data,block)
          elseif (#block.Operands[i].MemoryPointer == 2) and
             (block.Operands[i].MemoryPointer[1].Type == self.TOKEN.AND) and
             (block.Operands[i].MemoryPointer[2].Type == self.TOKEN.IDENT) then
            self:Error("Undefined function or array: "..block.Operands[i].MemoryPointer[2].Data,block)
          else
            self:Error("Must be constant expression: "..self:PrintTokens(block.Operands[i].MemoryPointer),block)
          end
        end
        -- Set the result
        if v
        then block.Operands[i].MemoryPointer = v + block.PointerOffset
        else block.Operands[i].MemoryPointer = self.Settings.MagicValue
        end
      end
    end
  end

  -- Resolve constant values in data
  if block.Data then
    for index,value in ipairs(block.Data) do
      if istable(value)then -- Data is a constant expression
        -- Prepare expression to parse
        self:RestoreParserState(value)
        -- Try to parse the expression
        self.IgnoreStringInExpression = true
        local c,v = self:ConstantExpression(true)
        if not c then
          if (#value == 1) and
             (value[1].Type == self.TOKEN.IDENT) then
            self:Error("Undefined label or variable: "..value[1].Data,block)
          else
            self:Error("Must be constant expression: "..self:PrintTokens(value),block)
          end
        end
        self.IgnoreStringInExpression = false
        -- Set the result
        block.Data[index] = v or self.Settings.MagicValue
      end
    end
  end


  -- Output the block
  if self.Settings.OutputFinalListing then
    self:PrintBlock(block,"flist")
  end
  self:WriteBlock(block)
end




--------------------------------------------------------------------------------
-- Lookup for CPU registers
local RegisterName = {}
RegisterName[01] = "EAX"
RegisterName[02] = "EBX"
RegisterName[03] = "ECX"
RegisterName[04] = "EDX"
RegisterName[05] = "ESI"
RegisterName[06] = "EDI"
RegisterName[07] = "ESP"
RegisterName[08] = "EBP"
RegisterName[16] = "CS"
RegisterName[17] = "SS"
RegisterName[18] = "DS"
RegisterName[19] = "ES"
RegisterName[20] = "GS"
RegisterName[21] = "FS"
RegisterName[22] = "KS"
RegisterName[23] = "LS"
for port=0,1023 do RegisterName[1024+port] = "port"..port end
for reg=0,31 do RegisterName[96+reg] = "R"..reg end


local SegmentRegisterName = {}
SegmentRegisterName[01] = "CS"
SegmentRegisterName[02] = "SS"
SegmentRegisterName[03] = "DS"
SegmentRegisterName[04] = "ES"
SegmentRegisterName[05] = "GS"
SegmentRegisterName[06] = "FS"
SegmentRegisterName[07] = "KS"
SegmentRegisterName[08] = "LS"
SegmentRegisterName[09] = "EAX"
SegmentRegisterName[10] = "EBX"
SegmentRegisterName[11] = "ECX"
SegmentRegisterName[12] = "EDX"
SegmentRegisterName[13] = "ESI"
SegmentRegisterName[14] = "EDI"
SegmentRegisterName[15] = "ESP"
SegmentRegisterName[16] = "EBP"
for reg=0,31 do SegmentRegisterName[17+reg] = "R"..reg end




--------------------------------------------------------------------------------
-- Print a block in a readable format
function HCOMP:PrintBlock(block,file,isLibrary)
  -- Print corresponding label
  if block.Label then
    if (self.Settings.OutputLabelsInListing == true) or (isLibrary) then
      self:PrintLine(file,block.Label.Name..":")-- /".."/ offset "..block.Label.Value)
    end
  end

  -- Print a comment
  if block.Comment and (not isLibrary) then
    self:PrintLine(file,"/".."/ "..block.Comment)
  end

  -- Print the opcode
  if block.Opcode then -- instruction
    local printText = ""
    if (self.Settings.OutputOffsetsInListing == true) and (not isLibrary) then
      printText = printText .. string.format("%6d ",block.Offset)
    else
      printText = printText .. "   "
    end
    printText = printText .. block.Opcode .. " "

    for i=1,#block.Operands do
      if block.Operands[i].Segment then
        printText = printText .. (SegmentRegisterName[block.Operands[i].Segment] or "???") .. ":"
      end

      if block.Operands[i].Constant then
        if istable(block.Operands[i].Constant) then
          printText = printText .. self:PrintTokens(block.Operands[i].Constant)
        else
          printText = printText .. block.Operands[i].Constant
        end
      elseif block.Operands[i].MemoryPointer then
        if istable(block.Operands[i].MemoryPointer) then
          printText = printText .. "#" .. self:PrintTokens(block.Operands[i].MemoryPointer)
        else
          printText = printText .. "#" .. block.Operands[i].MemoryPointer
        end
      elseif block.Operands[i].Memory then
        if istable(block.Operands[i].Memory) then
          if block.Operands[i].Memory.Value
          then printText = printText .. "#" .. block.Operands[i].Memory.Value
          else printText = printText .. "#" .. block.Operands[i].Memory.Name
          end
        else
          printText = printText .. "#" .. block.Operands[i].Memory
        end
      elseif block.Operands[i].MemoryRegister then
        printText = printText .. "#" .. (RegisterName[block.Operands[i].MemoryRegister] or "???")
      else
        printText = printText .. (RegisterName[block.Operands[i].Register] or "???")
      end

      if i < #block.Operands then printText = printText.."," end
    end

    self:PrintLine(file,printText)
  end

  -- Print the data
  if block.Data then
    local printText = ""
    if (self.Settings.OutputOffsetsInListing == true) and (not isLibrary) then
      printText = printText .. string.format("%6d db ",block.Offset)
    else
      printText = printText .. "   db "
    end

    for index,value in ipairs(block.Data) do
      if isnumber(value)then -- Data is a number
        printText = printText .. value
      elseif istable(value)then -- Data is an expression
        printText = printText .. self:PrintTokens(value)
      else -- Data is a string
        printText = printText .. "\"" .. value .. "\""
      end
      if index < #block.Data then
        printText = printText .. ","
      end
    end
    self:PrintLine(file,printText)
  end

  -- Add zero padding
  if block.ZeroPadding and (block.ZeroPadding > 0) then
    if (self.Settings.OutputOffsetsInListing == true) and (not isLibrary) then
      self:PrintLine(file,string.format("%6d alloc %d",block.Offset,block.ZeroPadding))
    else
      self:PrintLine(file,string.format("alloc %d",block.ZeroPadding))
    end
  end

  -- Parse marker commands
  if block.SetWritePointer then
    if (self.Settings.OutputOffsetsInListing == true) and (not isLibrary) then
      self:PrintLine(file,string.format("%6d org %d",block.Offset,block.SetWritePointer))
    else
      self:PrintLine(file,string.format("org %d",block.SetWritePointer))
    end
  end

  -- Parse marker commands
  if block.SetPointerOffset then
    if (self.Settings.OutputOffsetsInListing == true) and (not isLibrary) then
      self:PrintLine(file,string.format("%6d offset %d",block.Offset,block.SetPointerOffset))
    else
      self:PrintLine(file,string.format("offset %d",block.SetPointerOffset))
    end
  end
end




--------------------------------------------------------------------------------
-- Print a leaf in a readable format with specific nesting level
function HCOMP:PrintLeaf(leaf,level)
  -- Generate string for padding
  if not level then level = 0 end
  local pad = string.rep("  ",level)

  if istable(leaf) then
    if leaf.PreviousLeaf then
--      self:PrintLine("ctree",pad.."previous leaf:")
      self:PrintLeaf(leaf.PreviousLeaf,level)
    end

    if leaf.Opcode then
      if leaf.Opcode == "LABEL" then
        self:PrintLine("ctree",pad..leaf.Label.Name..": ("..string.lower(leaf.Label.Type)..")")
      elseif leaf.Opcode == "DATA" then
        if leaf.Label then
          self:PrintLine("ctree",pad..leaf.Label.Name..": ("..string.lower(leaf.Label.Type)..")")
        end
        self:PrintLine("ctree",pad.."  ["..(leaf.ZeroPadding or 0).." zero bytes, "..(#(leaf.Data or {})).." data bytes]")
      elseif leaf.Opcode == "MARKER" then
        self:PrintLine("ctree",pad.."  [marker]")
      else
        self:PrintLine("ctree",pad..leaf.Opcode)
        for i=1,#leaf.Operands do self:PrintLeaf(leaf.Operands[i],level+1) end
      end
    else
      if leaf.Constant then
        if istable(leaf.Constant) then
          self:PrintLine("ctree",pad..self:PrintTokens(leaf.Constant))
        else
          self:PrintLine("ctree",pad..leaf.Constant)
        end
      elseif leaf.Memory then
        self:PrintLine("ctree",pad.."#"..leaf.Memory.Name)
      elseif leaf.Register then
        self:PrintLine("ctree",pad..RegisterName[leaf.Register])
      elseif leaf.MemoryRegister then
        self:PrintLine("ctree",pad.."#"..RegisterName[leaf.MemoryRegister])
      elseif leaf.MemoryPointer then
        if istable(leaf.MemoryPointer) then
          if leaf.MemoryPointer.Opcode then
            self:PrintLine("ctree",pad.."#[")
            self:PrintLeaf(leaf.MemoryPointer,level+1)
            self:PrintLine("ctree",pad.." ]")
          else
            self:PrintLine("ctree",pad.."#"..self:PrintTokens(leaf.MemoryPointer))
          end
        else
          self:PrintLine("ctree",pad.."#"..leaf.MemoryPointer)
        end
      elseif leaf.Stack then
        if istable(leaf.Stack) then
          self:PrintLine("ctree",pad.."stack[")
          self:PrintLeaf(leaf.Stack,level+1)
          self:PrintLine("ctree",pad.."     ]")
        else
          self:PrintLine("ctree",pad.."stack["..leaf.Stack.."]")
        end
      elseif leaf.PointerToLabel then
        self:PrintLine("ctree",pad.."&"..leaf.PointerToLabel.Name)
      elseif leaf.TrigonometryHack then
        self:PrintLine("ctree",pad.."(trigonometry hack)")
      else
        for k,v in pairs(leaf) do
          print(k,v)
        end
        self:Error("Internal error 295")
      end
    end
  else
    self:Error("Internal error 229")
  end
end




--------------------------------------------------------------------------------
-- Generate RM for an operand
function HCOMP:OperandRM(operand,block)
  if operand.Constant then
    if not operand.Segment then
      operand.Value = operand.Constant
      return 0
    else
      operand.Value = operand.Constant
      return 50
    end
  elseif operand.Memory then
    if istable(operand.Memory) then -- label
      operand.Value = operand.Memory.Value
    else -- constant
      operand.Value = operand.Memory
    end
    return 25
  elseif operand.MemoryPointer then
    operand.Value = operand.MemoryPointer
    return 25
  elseif operand.Register then
    if not operand.Segment then
      if (operand.Register >=  1)   and (operand.Register <=  8)  then return operand.Register end
      if (operand.Register >= 16)   and (operand.Register <= 23)  then return operand.Register-16+9 end
      if (operand.Register >= 1024) and (operand.Register < 2048) then return operand.Register-1024+1000 end
      if (operand.Register >=  96)  and (operand.Register <= 127) then return operand.Register-96+2048 end
    else
      if (operand.Register >=  1) and (operand.Register <=  8) then return operand.Register+26 end
      if (operand.Register >= 16) and (operand.Register <= 23) then
        self:Error("Invalid instruction operand (cannot use segment prefix for segment register access)",block)
      end
      if (operand.Register >= 1024) and (operand.Register < 2048) then
        self:Error("Invalid instruction operand (cannot use segment prefix for port access)",block)
      end
      if (operand.Register >=  96) and (operand.Register <= 127) then return operand.Register-96+2112 end
    end
  elseif operand.MemoryRegister then
    if (operand.MemoryRegister >=  1) and (operand.MemoryRegister <=  8) then return operand.MemoryRegister+16 end
    if (operand.MemoryRegister >= 16) and (operand.MemoryRegister <= 23) then
      self:Error("Invalid instruction operand (cannot use segment register for memory access)",block)
    end
    if (operand.MemoryRegister >= 1024) and (operand.MemoryRegister < 2048) then
      self:Error("Invalid instruction operand (cannot use port for memory access)",block)
    end
    if (operand.MemoryRegister >=  96) and (operand.MemoryRegister <= 127) then return operand.MemoryRegister-96+2080 end
  end

  self:Error("Invalid instruction operand",block)
end




--------------------------------------------------------------------------------
-- Write the block to output stream
function HCOMP:WriteBlock(block)
  -- Write the opcode
  if block.Opcode then
    if not self.OpcodeNumber[block.Opcode] then
      self:Error("Undefined opcode: "..block.Opcode,block)
      return
    end
    local Opcode,RM = self.OpcodeNumber[block.Opcode],nil

    -- Generate RM if more than 1 operand
    if #block.Operands > 0 then
      RM = self:OperandRM(block.Operands[1],block)
      if #block.Operands > 1 then RM = RM + self:OperandRM(block.Operands[2],block)*10000 end
    end

    -- Generate segment offset marker
    if (#block.Operands > 0) and (block.Operands[1].Segment) then Opcode = Opcode + 1000 end
    if (#block.Operands > 1) and (block.Operands[2].Segment) then Opcode = Opcode + 10000 end

    if not self.Settings.FixedSizeOutput then -- Variable-size instructions
      -- Write opcode
      self:WriteByte(Opcode,block)
      -- Write RM
      if RM then self:WriteByte(RM,block) end

      -- Write segment offsets
      if (#block.Operands > 0) and (block.Operands[1].Segment) then self:WriteByte(block.Operands[1].Segment,block) end
      if (#block.Operands > 1) and (block.Operands[2].Segment) then self:WriteByte(block.Operands[2].Segment,block) end

      -- Write immediate bytes
      if (#block.Operands > 0) and (block.Operands[1].Value) then self:WriteByte(block.Operands[1].Value,block) end
      if (#block.Operands > 1) and (block.Operands[2].Value) then self:WriteByte(block.Operands[2].Value,block) end
    else -- Fixed-size instructions
      -- Write opcode
      self:WriteByte(Opcode + 2000,block)

      -- Write RM
      self:WriteByte(RM or 0,block)

      -- Write segment offsets
      if #block.Operands > 0 then self:WriteByte(block.Operands[1].Segment or -4,block) else self:WriteByte(-4,block) end
      if #block.Operands > 1 then self:WriteByte(block.Operands[2].Segment or -4,block) else self:WriteByte(-4,block) end

      -- Write immediate bytes
      if #block.Operands > 0 then self:WriteByte(block.Operands[1].Value or 0,block) else self:WriteByte(0,block) end
      if #block.Operands > 1 then self:WriteByte(block.Operands[2].Value or 0,block) else self:WriteByte(0,block) end
    end
  end

  -- Write the data
  if block.Data then
    for index,value in ipairs(block.Data) do
      if isnumber(value) then -- Data is a number
        self:WriteByte(value,block)
      else -- Data is a string
        for charIdx=1,#value do
          self:WriteByte(string.byte(value,charIdx),block)
        end
      end
    end
  end

  -- Write zero padding
  if block.ZeroPadding then
    for i=1,block.ZeroPadding do self:WriteByte(0,block) end
  end

  -- Set write pointer
  if block.SetWritePointer then
    self.WritePointer = block.SetWritePointer
  end
end
