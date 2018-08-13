TheEyeAddon.UI.Factories.Texture = {}
local this = TheEyeAddon.UI.Factories.Texture


function this.Create(instance, parentFrame, layer, fileID)
	instance = instance or parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)
	instance:SetAllPoints()

	return instance
end