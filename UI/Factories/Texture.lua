local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Factories.Texture = {}


function TheEyeAddon.UI.Factories.Texture:Create(instance, parentFrame, layer, fileID)
	instance = instance or parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetAllPoints()

	return instance
end