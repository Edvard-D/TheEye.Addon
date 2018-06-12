local TEA = TheEyeAddon
TEA.UIObjects.Factories.Texture = {}


function TEA.UIObjects.Factories.Texture:Create(parentFrame, layer, fileID)
	local instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)

	return instance
end