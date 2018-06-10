_TEA = TheEyeAddon
_TEA.UIObjects.Texture = {}


function _TEA.UIObjects.Texture:Create(instance, parentFrame, layer, fileID)
	instance = instance or
	{
		texture = parentFrame:CreateTexture(nil, layer)
	}

	instance.texture:SetTexture(fileID)


	setmetatable(instance, _TEA.UIObjects.Texture)
	self.__index = self

	return instance
end