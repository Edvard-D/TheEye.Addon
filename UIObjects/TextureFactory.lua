local TEA = TheEyeAddon
TEA.UIObjects.TextureFactory = {}


function TEA.UIObjects.TextureFactory:Create(parentFrame, layer, fileID)
	local instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)

	return instance
end