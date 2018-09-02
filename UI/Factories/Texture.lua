TheEyeAddon.UI.Factories.Texture = {}
local this = TheEyeAddon.UI.Factories.Texture


function this.Create(parentFrame, layer)
	instance = parentFrame:CreateTexture(nil, layer)
	instance.TextureSet = this.TextureSet
	return instance
end

function this:TextureSet(fileID)	
	self:SetTexture(fileID)
	self:SetAllPoints()
end