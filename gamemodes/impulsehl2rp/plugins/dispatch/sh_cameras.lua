local entMeta = FindMetaTable("Entity")

function entMeta:IsCameraEnabled()
	return self:GetSequenceName(self:GetSequence()) != "ai_retract"
end
