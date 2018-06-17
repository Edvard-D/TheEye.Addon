local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Factories.Texture = {}


function TheEyeAddon.UI.Objects.Factories.Texture:Create(instance, parentFrame, layer, fileID)
	instance = instance or parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetAllPoints()

	return instance
end