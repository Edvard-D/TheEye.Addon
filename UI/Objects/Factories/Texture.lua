local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Texture = {}


function TheEyeAddon.UI.Objects.Factories.Texture:Create(parentFrame, layer, fileID)
	local instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetAllPoints()

	return instance
end