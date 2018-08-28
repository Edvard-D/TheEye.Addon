TheEyeAddon.UI.Factories.Texture = {}
local this = TheEyeAddon.UI.Factories.Texture


function this.Create(parentFrame, layer, fileID)
	instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetAllPoints()

	return instance
end