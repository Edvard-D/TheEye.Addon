local TEA = TheEyeAddon
TEA.UI.Objects.Factories.Texture = {}


function TEA.UI.Objects.Factories.Texture:Create(parentFrame, layer, fileID)
	local instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetPoint("CENTER", parentFrame, "CENTER", 0, 0)

	return instance
end