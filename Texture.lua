local TEA = TheEyeAddon
TEA.UIObjects.Texture = {}

local setmetatable = setmetatable


function TEA.UIObjects.Texture:Create(parentFrame, layer, fileID)
	local instance = parentFrame:CreateTexture(nil, layer)
	
	instance:SetTexture(fileID)


	setmetatable(instance, TEA.UIObjects.Texture)
	self.__index = self

	return instance
end