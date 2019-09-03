TheEyeAddon.UI.Factories.Texture = {}
local this = TheEyeAddon.UI.Factories.Texture



function this.Create(parentFrame, layer, blendMode)
	instance = parentFrame:CreateTexture(nil, layer)
	instance.TextureSet = this.TextureSet
	blendMode = blendMode or "DISABLE"
	instance:SetBlendMode(blendMode)

	return instance
end

function this:TextureSet(fileID)	
	self:SetTexture(fileID)
	self:SetAllPoints()
end