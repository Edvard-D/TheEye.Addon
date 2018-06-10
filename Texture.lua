local TEA = TheEyeAddon
TEA.UIObjects.Texture = {}

local setmetatable = setmetatable


function TEA.UIObjects.Texture:Create(instance, parentFrame, layer, fileID)
	local instance = instance or
	{
		parentFrame:CreateTexture(nil, layer)
	}
	instance:SetTexture(fileID)


	setmetatable(instance, TEA.UIObjects.Texture)
	self.__index = self

	return instance
end