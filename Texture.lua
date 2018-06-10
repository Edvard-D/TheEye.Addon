local TEA = TheEyeAddon
TEA.UIObjects.Texture = {}

local setmetatable = setmetatable


function TEA.UIObjects.Texture:Create(instance, parentFrame, layer, fileID)
	local instance = instance or {}
	instance.texture = parentFrame:CreateTexture(nil, layer)
	instance.texture:SetTexture(fileID)


	setmetatable(instance, TEA.UIObjects.Texture)
	self.__index = self

	return instance
end